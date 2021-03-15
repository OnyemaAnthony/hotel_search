
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


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

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getJsonFile(60,-44.5465317);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels'),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            TextFormField(
              decoration: InputDecoration(
               // border: Board
              ),
            )

          ],
        ),
      ),
    );

  }


  Future<void> getJsonFile(double lat,double long)async{


    var data = await DefaultAssetBundle.of(context).loadString("assets/hotel.json");
    final jsonResult = json.decode(data);

    List rakuten = jsonResult['rakuten_hotels'];
    for(int i =0; i < rakuten.length; i++){

      double latitude = isNumeric(rakuten[i]['latitude'])?double.parse(rakuten[i]['latitude']):double.parse('0.0');
    //  double longitude = double.parse(rakuten[i]['longitude']);
     // double longitude = rakuten[i]['longitude']? double.parse(rakuten[i]['longitude']) : 0;
       //double longitude = rakuten[i]['longitude'] != null? double.parse(rakuten[i]['longitude']):double.parse('0.0');
      //print('the longitude is $longitude and the latitude is $latitude');





      double distanceInMeters = distanceBetween(latitude,0.0, lat,long);//returns distance in meters
      int distanceInKM = (distanceInMeters * 0.001).toInt();
      print('the names are ${rakuten[i]['city']}');

      if(distanceInKM <= 10){

        //nearbyHotels[0]= rakuten[i]['city'];
       // rakuten[i]['city'] = nearbyHotels.add()
        nearbyHotels.add(rakuten[i]['city']);

      }
     // print(distanceInKM>10);

    }
    print('the nearby is ${nearbyHotels.length}');

  }
bool isNumeric(String s){
    if(s == null){
      return false;
    }
    return double.parse(s,(e)=> null) != null;
}

}
