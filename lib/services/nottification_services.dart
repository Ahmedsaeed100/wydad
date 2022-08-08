import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:rxdart/subjects.dart';
import 'package:wydad/services/utils.dart';

class LocalNotificationService {
  BigPictureStyleInformation? bigPictureStyleInformation;
  Future<void> _showBigPictureNotification() async {
    final String largeIconPath = await Utils.downloadAndSaveFile(
      'https://i1.sndcdn.com/avatars-0Rxeza5NCGa4809b-6utmLQ-t240x240.jpg',
      'largeIcon',
    );
    final String bigPicturePath = await Utils.downloadAndSaveFile(
      'https://i1.sndcdn.com/avatars-0Rxeza5NCGa4809b-6utmLQ-t240x240.jpg',
      'bigPicture',
    );
    bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true,
    );
  }

  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  final sound = 'azan.wav';

  Future<void> intialize() async {
    _showBigPictureNotification();
    _configureLocalTimeZone();
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/baghdadi');

    // IOS
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    // Utils utils = Utils();

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      priority: Priority.max,
      color: Colors.transparent,
      showProgress: true,
      colorized: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      // sound: const UriAndroidNotificationSound("assets/tunes/azan.mp3"),
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      sound: sound,
    );
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  // method to Show Notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
    );
  }
  // end

  // method to Scheduled Notification
  Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      _scheduledDaily(Time(hour, minute)),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // end
  static tz.TZDateTime _scheduledDaily(Time time) {
    print('yyyyyyy${time.hour} hour scheduled');
    print('yyyyyyy${time.minute} minute scheduled');
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  ///_configureLocalTimeZone
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  // method to Show Notification
  Future<void> showNotificationWithPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  // end
//
  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

//
  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
