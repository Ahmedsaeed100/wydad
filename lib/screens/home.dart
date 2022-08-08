import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wydad/model/pray_time.dart';
import 'package:wydad/provider/next_pray.dart';
import 'package:wydad/services/nottification_services.dart';
import 'package:wydad/services/web_services.dart';
import 'package:wydad/widgets/widgets.dart';

class Home extends StatefulWidget {
  final String payload;
  const Home({Key? key, required this.payload}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WebServices services = WebServices();
  PrayTime prayTime = PrayTime();
  late final LocalNotificationService service;
  Timer? timer;
  int selectNextPray = 0;

  @override
  void initState() {
    super.initState();
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    getPrayTime();
    Provider.of<NextPray>(context, listen: false).startTimer();
    // WidgetsBinding.instance.addPostFrameCallback((_) => notification());
    timer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) =>
            Provider.of<NextPray>(context, listen: false).getNextPray());
    //  notificationscheduled();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  notificationscheduled() async {
    // Notification
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.intialize();
    //
    await service.showScheduledNotification(
      id: 0,
      title: "title",
      body: "body",
      hour: 21,
      minute: 31,
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

  getPrayTime() async {
    prayTime = await services.getPraytime();
  }

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    print("ssssssssssssssssssssssssssssssssssssssssssssss");
    return SafeArea(
      child: Scaffold(
        body: Consumer<NextPray>(builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 200,
                backgroundColor: const Color.fromARGB(255, 20, 21, 43),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 2,
                  collapseMode: CollapseMode.parallax,
                  title: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Image(
                      image: AssetImage('assets/icons/WydadIcon.png'),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  background: Stack(
                    children: [
                      const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(
                              "assets/images/headerImages/skynight.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(
                              "assets/images/headerImages/mosque.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 20,
                        child: Column(
                          children: [
                            Text(
                              value.testnumber.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              value.stopwatch,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  'مصر , الجيزة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              const SliverToBoxAdapter(
                child: PrayTimeWedget(),
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    TextButton(
                      clipBehavior: Clip.hardEdge,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        await service.showScheduledNotification(
                          id: 0,
                          title: 'Scheduled Wadad',
                          body: 'azan',
                          hour: 21,
                          minute: 30,
                        );
                      },
                      child: const Text('Scheduled Notification Test'),
                    ),
                    TextButton(
                      clipBehavior: Clip.hardEdge,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () async {
                        await service.showNotification(
                          id: 0,
                          title: 'Scheduled Wadad',
                          body: 'azan',
                        );
                      },
                      child: const Text('Notification Test'),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void listenToNotification() {
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => Home(payload: payload))));
    }
  }
}
