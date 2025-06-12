import 'package:flutter/material.dart';

class CatBottomSheet extends StatelessWidget {
  const CatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Location',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBEBEBE),
                    ),
                    width: 28,
                    height: 28,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFFFFFFFF),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Institute of Family Guy',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),

          Spacer(),

          Image.asset('assets/png/cat-sleep.png', width: 256),
          Text('No Parked Vehicle Currently'),

          // Button
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade400,
                  ),
                  child: const Text("Start Parking Now"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
