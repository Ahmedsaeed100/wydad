class PrayTime {
  final String? fajr;
  final String? sunrise;
  final String? dhuhr;
  final String? asr;
  final String? sunset;
  final String? maghrib;
  final String? isha;
  final String? imsak;
  final String? midnight;

  PrayTime({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
  });

  factory PrayTime.fromJson(Map<String, dynamic> json) {
    return PrayTime(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
    );
  }
}




//  factory PrayTime.fromJson(Map<String, dynamic> json) {
//     return PrayTime(
//       fajr: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Fajr']))
//           .toString(),
//       sunrise: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Sunrise']))
//           .toString(),
//       dhuhr: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Dhuhr']))
//           .toString(),
//       asr: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Asr']))
//           .toString(),
//       sunset: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Sunset']))
//           .toString(),
//       maghrib: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Maghrib']))
//           .toString(),
//       isha: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Isha']))
//           .toString(),
//       imsak: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Imsak']))
//           .toString(),
//       midnight: DateFormat.jm()
//           .format(DateFormat("hh:mm").parse(json['Midnight']))
//           .toString(),
//     );
//   }