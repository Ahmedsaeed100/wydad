import 'package:flutter/cupertino.dart';
import 'package:wydad/model/pray_time.dart';
import 'package:wydad/services/web_services.dart';
import 'package:wydad/viewmodel/pray_time_view_model.dart';

enum LoadingStatus {
  complete,
  searching,
  empty,
}

class PrayTimeListViewModel with ChangeNotifier {
  // ignore: unused_field
  LoadingStatus _loadingStatus = LoadingStatus.empty;
  PrayTimeViewModel pray = PrayTimeViewModel as PrayTimeViewModel;
  void getprayTime() async {
    PrayTime praytime = await WebServices().getPraytime();
    _loadingStatus = LoadingStatus.searching;
    notifyListeners();

    pray = PrayTimeViewModel(pray: praytime);

    notifyListeners();
  }
}
