import 'package:flutter/material.dart';

class ParkingLocationScreen extends StatelessWidget {
  final String title;
  const ParkingLocationScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: 180,
              width: 410,
              color: const Color(0xFF407bff),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        
                      
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      width: 15,
                                      height: 15,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                                Text(
                                  'Parking Locations',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                Text(
                                  '404 Street, Phnom Penh',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                Text(
                                  'Mountain Way,KA 3000(Phnom Penh)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                            ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 50),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                
                              ],
                            ),
                          ),
                          
                        ),
                    ],
                    
                  ),
                   const SizedBox(height: 24),
                    _buildParkingLocationButton(context),
                    const SizedBox(height: 24),
                  
                ],
                
              ),
              
            ),
            
          ),
         
        ],
      ),
    );
  }

  Widget _buildParkingLocationButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/parkingDetails');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 118, 154, 234),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Text(
              'Parking Nearby Container',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Image.asset(
                'assets/png/container.png',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}