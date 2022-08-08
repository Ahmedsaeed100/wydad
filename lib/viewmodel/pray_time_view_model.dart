import 'package:wydad/model/pray_time.dart';

class PrayTimeViewModel {
  final PrayTime? _prayTime;
  PrayTimeViewModel({PrayTime? pray}) : _prayTime = pray;
  String? get fajr {
    return _prayTime!.fajr;
  }

  String? get sunrise {
    return _prayTime!.sunrise;
  }

  String? get dhuhr {
    return _prayTime!.dhuhr;
  }

  String? get asr {
    return _prayTime!.asr;
  }

  String? get sunset {
    return _prayTime!.sunset;
  }

  String? get maghrib {
    return _prayTime!.maghrib;
  }

  String? get isha {
    return _prayTime!.isha;
  }

  String? get imsak {
    return _prayTime!.imsak;
  }

  String? get midnight {
    return _prayTime!.midnight;
  }
}
