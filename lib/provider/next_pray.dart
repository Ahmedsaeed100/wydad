import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:wydad/model/pray_time.dart';
import 'package:wydad/services/nottification_services.dart';
import 'package:wydad/services/web_services.dart';

PrayTime prayTime = PrayTime();

/////

class NextPray with ChangeNotifier {
  // get Pray Hours
  int remaininghours = 0;
  int remainingminutes = 0;
  DateTime timeNow = DateTime.now();
  bool isCountdown = false;
  int selectNextPray = 0;
  int testnumber = 0;

  ///
  WebServices services = WebServices();
  PrayTime prayTime = PrayTime();

  getPrayTime() async {
    prayTime = await services.getPraytime();
  }

  showScheduled(int hour, int minute) async {
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    await service.showScheduledNotification(
      id: 0,
      title: 'أذان الظهر',
      body: 'حان الأن موعد أذان الظهر',
      hour: hour,
      minute: minute,
    );
  }

  notifications() async {
    // Notification
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    //
    await service.showNotification(
      id: 0,
      title: "title",
      body: "body",
    );
  }

  getNextPray() {
    // print('yyyyyyy${getHour(prayTime.isha.toString())} gethour');
    // print('yyyyyyy${timeNow.hour} hour now');
    // notifications();
    testnumber == timeNow.minute;
    notifyListeners();
    if (timeNow.minute == 37) {
      notifications();
    }

    String dateTimeNow =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    DateTime now = DateTime.parse(dateTimeNow);
    // bool nowbeforeFajer = now.isBefore(prayTime.fajr);

    if (timeNow.hour <= getHour(prayTime.fajr.toString())) {
      selectNextPray = 1;
      isCountdown = true;
      remainingtime(
          prayTime.fajr, timeNow.hour.toString(), timeNow.minute.toString());
      nextPrayNameAR = 'الفجر بعد';
      //

      notifyListeners();
    }

    ///
    else if (timeNow.hour < getHour(prayTime.sunrise.toString())) {
      selectNextPray = 2;
      isCountdown = true;
      remainingtime(
          prayTime.sunrise, timeNow.hour.toString(), timeNow.minute.toString());
      nextPrayNameAR = 'الشروق بعد';
      notifyListeners();
    }

    ///
    else if (timeNow.hour <= getHour(prayTime.dhuhr.toString())) {
      selectNextPray = 2;
      var sssss = timeNow.hour + timeNow.minute <
          getHour(prayTime.dhuhr.toString()) + getminute(prayTime.dhuhr);
      print('yyyyy${sssss}');
      if (timeNow.hour + timeNow.minute <
          getHour(prayTime.dhuhr.toString()) + getminute(prayTime.dhuhr)) {
        isCountdown = true;
        remainingtime(
            prayTime.dhuhr, timeNow.hour.toString(), timeNow.minute.toString());
        nextPrayNameAR = 'الظهر بعد';
      } else {
        isCountdown = false;
        remainingtime(
            prayTime.dhuhr, timeNow.hour.toString(), timeNow.minute.toString());
        nextPrayNameAR = 'الظهر منذ';
      }
      //
      // await service.showScheduledNotification(
      //   id: 0,
      //   title: 'أذان الظهر',
      //   body: 'حان الأن موعد أذان الظهر',
      //   hour: getHour(
      //     prayTime.dhuhr.toString(),
      //   ),
      //   minute: getminute(
      //     prayTime.dhuhr.toString(),
      //   ),
      // );
      notifyListeners();
    }

    ///
    else if (timeNow.hour <= getHour(prayTime.asr.toString())) {
      selectNextPray = 4;
      if (timeNow.minute < getminute(prayTime.asr.toString())) {
        isCountdown = true;
        remainingtime(
            prayTime.asr, timeNow.hour.toString(), timeNow.minute.toString());
        nextPrayNameAR = 'العصر بعد';
      }

      ///
      else {
        isCountdown = false;
        remainingtime(
            prayTime.asr, timeNow.hour.toString(), timeNow.minute.toString());
        nextPrayNameAR = 'العصر منذ';
      }
      notifyListeners();
    } ////
    else if (timeNow.hour <= getHour(prayTime.maghrib.toString())) {
      selectNextPray = 5;
      isCountdown = true;
      remainingtime(
        prayTime.maghrib,
        timeNow.hour.toString(),
        timeNow.minute.toString(),
      );
      nextPrayNameAR = 'المغرب بعد';

      notifyListeners();
    }

    ///
    else if (timeNow.hour <= getHour(prayTime.isha.toString())) {
      //
      selectNextPray = 6;
      isCountdown = true;
      remainingtime(
          prayTime.isha, timeNow.hour.toString(), timeNow.minute.toString());
      nextPrayNameAR = 'العشاء بعد';
    }

    ///
    else {
      selectNextPray = 6;
      isCountdown = false;
      remainingtime(
          prayTime.isha, timeNow.hour.toString(), timeNow.minute.toString());
      nextPrayNameAR = 'العشاء منذ';
    }

    notifyListeners();
  }

  notificationss() async {
    // Notification
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    //
    await service.showNotification(
      id: 0,
      title: "title",
      body: "body",
    );
  }

  // Get Remainig Time Before Next Pray
  remainingtime(String? nextPrayTime, String timeNowHour, timeNowMinute) {
    int hourNow = int.parse(timeNowHour.padLeft(2, '0'));
    int minutesNow = int.parse(timeNowMinute.padLeft(2, '0'));
    int prayHours = getHour(nextPrayTime!.padLeft(2, '0'));
    int prayminutes = getminute(nextPrayTime);

    if (hourNow >= 0) {
      if (isCountdown) // Remaining Time For Salahe
      {
        remaininghours = (prayHours - int.parse(timeNowHour));
        remainingminutes = (prayminutes - minutesNow);
      } //
      else // Salahe Started From
      {
        remaininghours = (int.parse(timeNowHour) - prayHours);
        remainingminutes = (minutesNow - prayminutes);
      }
    }
  }

  int getHour(String? val) {
    int hours = int.parse(val!.split(':')[0]);
    //print('eeeeeee : $hours');
    return hours;
  } // get character before semicolon

//
  // get Pray Minutes
  int getminute(String? val) {
    RegExp regExp =
        RegExp(r'(?<=:).{0,1}(\d)'); // get First 2 Number after semicolon

    int minutes = int.parse(regExp.stringMatch(val!).toString());

    return minutes;
  } // get tow character after semicolon

  // StopWatch Time Pray Started From 30 minutes
  Duration duration = const Duration();
  // Remaining Time to Next Pray
  //

  Timer? timer;
  String stopwatch = '';
  String nextPrayNameAR = '';
  void startTimer() async {
    await getPrayTime();
    //
    getNextPray();
    Duration countDowbDuration =
        Duration(hours: remaininghours, minutes: remainingminutes);
    // is CountDown Or StopWatch
    if (isCountdown) {
      duration = countDowbDuration;
    } else {
      duration = Duration(hours: remaininghours, minutes: remainingminutes);
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int addSeconds = isCountdown ? -1 : 1;
      final second = duration.inSeconds + addSeconds;

      // check if Count Down End
      second == 0 ? isCountdown = false : duration = Duration(seconds: second);
      //
      String towDigits(int n) => n.toString().padLeft(2, '0');
      String hours = towDigits(duration.inHours.remainder(60));
      String minutes = towDigits(duration.inMinutes.remainder(60));
      String seconds = towDigits(duration.inSeconds.remainder(60));
      //
      stopwatch = '$hours:$minutes:$seconds';
      //
      notifyListeners();
    });
  }

  // Convert Pray Time To AM An PM
  static String timeFormatAMandPM(String praytime) {
    String theTimeNow =
        DateFormat.jm().format(DateFormat("hh:mm").parse(praytime)).toString();
    return theTimeNow;
  }
}
