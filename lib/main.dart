import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotel_search/hotel_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

List nearbyHotels = [];
List rakuten= [];

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
        await fetchHotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hotels'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: latController,
              decoration: InputDecoration(
                  hintText: 'Enter latitude here',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: longController,
              decoration: InputDecoration(

                  hintText: 'Enter latitude here',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async{
                await checkHotels(double.parse(latController.text), double.parse(longController.text));

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => HotelList(nearbyHotels)));
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }


  Future<void> fetchHotels()async{
    var data =
        await DefaultAssetBundle.of(context).loadString("assets/hotel.json");
    final jsonResult = json.decode(data);
   rakuten = jsonResult['rakuten_hotels'];
  }

  Future<void> checkHotels(double lat, double long) async {

    for (int i = 0; i < rakuten.length; i++) {
      double latitude = isNumeric(rakuten[i]['latitude'])
          ? double.parse(rakuten[i]['latitude'])
          : double.parse('0.0');
      double longitude = isNumeric(rakuten[i]['latitude'])
          ? double.parse(rakuten[i]['latitude'])
          : double.parse('0.0');

      double distanceInMeters = distanceBetween(lat,long,latitude, longitude);
      int distanceInKM = (distanceInMeters * 0.001).toInt();
      print('the distance is ${distanceInKM}');
      print('the names are ${rakuten[i]['city']}');
      if (distanceInKM > 10) {
        nearbyHotels.add(rakuten[i]['city']);
      }
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
