import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:wydad/provider/next_pray.dart';
import 'package:wydad/screens/screens.dart';

class UserCityName extends StatefulWidget {
  const UserCityName({Key? key}) : super(key: key);

  @override
  State<UserCityName> createState() => _UserCityNameState();
}

class _UserCityNameState extends State<UserCityName> {
  String country = '';
  String city = '';
  String name = '';
  String street = '';
  String postalCode = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
      UserLocation.lat,
      UserLocation.long,
      localeIdentifier: 'eg',
    );

    print(placemark[0].country);
    print(placemark[0].name);
    print(placemark[0].street);
    print(placemark[0].postalCode);

    setState(() {
      country = placemark[0].country!;
      city = placemark[0].locality!;
      name = placemark[0].name!;
      street = placemark[0].street!;
      postalCode = placemark[0].postalCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Lat : ${UserLocation.lat}"),
            Text("Long : ${UserLocation.long}"),
            Text("Country : $country"),
            Text("City : $city"),
            Text("Name : $name"),
            Text("Street : $street"),
            Text("PostalCode : $postalCode"),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<NextPray>(
                      create: ((_) => NextPray()),
                      child: const Home(payload: ''),
                    ),
                  ),
                );
              },
              child: const Text('Go To Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
