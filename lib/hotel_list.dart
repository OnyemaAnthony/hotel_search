import 'package:flutter/material.dart';

class HotelList extends StatelessWidget {
  final List hotels;

  HotelList(this.hotels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel List'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return hotels.isEmpty ? Text('No hotels available in the specified location'):Card(
              child: Padding
                (padding:EdgeInsets.all(10),child: Text(hotels[index])),
              
            );
          }),
    );
  }
}
