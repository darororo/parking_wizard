import 'package:flutter/material.dart';
import 'package:parking_wizard/ui/screens/home_screen/open_street_map.dart';

class CreateParking extends StatelessWidget {
  const CreateParking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save Parking')),
      body: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: BoxBorder.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: OpenStreetMapWidget(),
          ),
        ],
      ),
    );
  }
}
