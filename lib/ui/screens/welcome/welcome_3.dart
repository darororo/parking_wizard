import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Welcome3 extends StatelessWidget {
  final String title;
  const Welcome3({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            child: Container(
              height: size.height * 0.45,
              width: double.infinity,
              color: const Color(0x0fffffff),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color(0x0fffffff),
                      child: Center(
                        child: Image.asset(
                          'assets/svg/p3.png',
                          height: 330,
                          width: 420,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 40, // adjust as needed
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        context.push('/welcome/2');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 0),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Extended Parking Time As You Need",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industryLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: index == 2 ? 20 : 20,
                height: 7,
                decoration: BoxDecoration(
                  color: index == 2 ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/welcome/4');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF407bff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
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
