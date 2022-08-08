import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wydad/model/pray_time.dart';
import 'package:wydad/provider/next_pray.dart';
import 'package:wydad/services/web_services.dart';

class PrayTimeWedget extends StatefulWidget {
  const PrayTimeWedget({Key? key}) : super(key: key);

  @override
  State<PrayTimeWedget> createState() => _PrayTimeWedgetState();
}

class _PrayTimeWedgetState extends State<PrayTimeWedget> {
  WebServices services = WebServices();
  PrayTime prayTime = PrayTime();
  @override
  void initState() {
    super.initState();
    getPrayTime();
  }

  getPrayTime() async {
    prayTime = await services.getPraytime();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 100,
        width: size.width,
        child: FutureBuilder(
          future: getPrayTime(),
          builder: ((context, snapshot) {
            print('ssssssssssstttttttttttttttttt$snapshot');
            if (snapshot.connectionState == ConnectionState.done) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5),
                  Container(
                    width: 57,
                    padding: const EdgeInsets.all(2),
                    decoration: Provider.of<NextPray>(context, listen: false)
                                .selectNextPray ==
                            6
                        ? const BoxDecoration(
                            color: Color.fromARGB(255, 177, 199, 238),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'العشاء',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/praytime/isha.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          NextPray.timeFormatAMandPM(
                              (prayTime.isha.toString())),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
                  Container(
                    width: 57,
                    padding: const EdgeInsets.all(2),
                    decoration: Provider.of<NextPray>(context, listen: false)
                                .selectNextPray ==
                            5
                        ? const BoxDecoration(
                            color: Color.fromARGB(255, 177, 199, 238),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'المغرب',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/praytime/maghrib.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          NextPray.timeFormatAMandPM(
                              prayTime.maghrib.toString()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 57,
                    padding: const EdgeInsets.all(2),
                    decoration: Provider.of<NextPray>(context, listen: false)
                                .selectNextPray ==
                            4
                        ? const BoxDecoration(
                            color: Color.fromARGB(255, 177, 199, 238),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'العصر',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/praytime/asr.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          NextPray.timeFormatAMandPM(prayTime.asr.toString()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 57,
                    padding: const EdgeInsets.all(2),
                    decoration: Provider.of<NextPray>(context, listen: false)
                                .selectNextPray ==
                            2
                        ? const BoxDecoration(
                            color: Color.fromARGB(255, 177, 199, 238),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'الظهر',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/praytime/dhuhr.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          NextPray.timeFormatAMandPM(prayTime.dhuhr.toString()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 57,
                    padding: const EdgeInsets.all(2),
                    decoration: Provider.of<NextPray>(context, listen: false)
                                .selectNextPray ==
                            1
                        ? const BoxDecoration(
                            color: Color.fromARGB(255, 177, 199, 238),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          )
                        : null,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'الفجر',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Image.asset(
                          "assets/images/praytime/fajer.png",
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          NextPray.timeFormatAMandPM(prayTime.fajr.toString()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              );
            } else {
              return Container();
            }
          }),
        ));
  }
}
