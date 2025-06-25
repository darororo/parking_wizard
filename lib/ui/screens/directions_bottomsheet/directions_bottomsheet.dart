import 'dart:ffi';

import 'package:flutter/material.dart';

class Directions extends StatelessWidget {
  const Directions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      height: 350,  
     
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Building J Near Container',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBEBEBE),
                      ),
                      width: 28,
                      height: 28,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Institute of Technology of Cambodia',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF333333),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '40 km',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                            SizedBox(width: 8), 
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 6), 
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(255, 19, 158, 227),
                                          ),
                                          width: 15,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'My Current Location',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          Text(
                                            '404 Street, Phnom Penh',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF333333),
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                SizedBox(width: 8),
                                Image.asset(
                                  'assets/png/distance.png',
                                  width: 10,
                                  height: 10,
                                ),
                                Text(
                                  'Total Distance',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 6), 
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(255, 231, 237, 55),
                                          ),
                                          width: 15,
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'My Vehicle',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          Text(
                                            '500 Street, Phnom Penh',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF333333),
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 2, 2, 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.pedal_bike_rounded),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 6), 
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Parking duration',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          Text(
                                            '7 hours',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF333333),
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), 
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'You\'ve been here ',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                          Text(
                                            '3 Times',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF333333),
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),  
                                  ],
                                ),
                              ),
                            ),
                            
                          ],
                        ),                   
                      ],
                    ),
                  ), 
                ],
                
              ),
              
            ),
            
          ],
        ),
      ),
    );
  }

 
  Widget _buildInfoCard({
    required Widget child,
    double? height,   
    double? width,   
  }) {
    return SizedBox(
      height: height ?? 200,
      width: width ?? 351,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}