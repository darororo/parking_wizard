import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/router.dart';

class Welcome4 extends StatelessWidget {
  final String title;
  const Welcome4({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top blue curved container with logo
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              height: size.height * 0.45,
              width: double.infinity,
              color: const Color(0xFF407bff),
              child: Center(
                child: Image.asset(
                  'assets/svg/OBJECTS.png',
                  height: 138.57,
                  width: 120,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == 3 ? 30 : 20,
                height: 7,
                decoration: BoxDecoration(
                  color: index == 3 ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          const SizedBox(height: 55),

          const Text(
            "Welcome to Parking Wizard",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.go(Routes.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF407bff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Allow Access",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
