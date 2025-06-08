import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/routes/router.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

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
              child: Center(
                child: Image.asset(
                  'assets/svg/p1.png',
                  height: 330,
                  width: 420,
                ),
              ),
            ),
          ),

          const SizedBox(height: 0),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
            "Find Parking Sport Around You Easily",
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
                width: index == 0 ? 20 : 20,
                height: 7,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.blue : Colors.grey[300],
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
                  context.go(Routes.homeScreen1);
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


// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   final String title;
//   const HomeScreen({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Parking Wizard',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Montserrat',
//       ),
//       home: OnboardingScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class OnboardingScreen extends StatefulWidget {
//
//   const OnboardingScreen({super.key});
//
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }
//
// class OnboardingData {
//   final String title;
//   final String description;
//   final Widget image;
//   final Color backgroundColor;
//
//   OnboardingData ({
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.backgroundColor,
//   });
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//
//   final List<OnboardingData> _onboardingData = [
//     OnboardingData(
//       title: "Find Parking Sport Around You Easily",
//       description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",
//       image: Image.asset(
//         'assets/images/p1.png'
//       ),
//       backgroundColor: Colors.white,
//     ),
//     OnboardingData(
//       title: "Book and Pay Parking Quickly and Shortly",
//       description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",
//       image: Image.asset(
//           'assets/svg/p2.png'
//       ),
//       backgroundColor: Colors.white,
//     ),
//     OnboardingData(
//       title: "Extended Parking Time As You Need",
//       description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry",
//       image: Image.asset(
//           'assets/svg/p3.png'
//       ),
//       backgroundColor: Colors.white,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _currentPage == 3 ? Color(0xFF4A90E2) : Colors.white,
//       body: _currentPage == 3 ? _buildWelcomeScreen() : _buildOnboardingContent(),
//     );
//   }
//
//   Widget _buildOnboardingContent() {
//     return SafeArea(
//         child: Column(
//             children: [
//             // Status bar space
//             SizedBox(height: 20),
//
//         // Back button (only show after first page)
//         if (_currentPage > 0)
//     Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: EdgeInsets.only(left: 20),
//         child: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
//           onPressed: () {
//             if (_currentPage > 0) {
//               _pageController.previousPage(
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//               );
//             }
//           },
//         ),
//       ),
//     ),
//
//     // Main content
//     Expanded(
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: _onboardingData.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentPage = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return _buildOnboardingPage(_onboardingData[index]);
//         },
//       ),
//     ),
//
//     // Page indicators
//     _buildPageIndicators(),
//
//               // Next button
//               Padding(
//                 padding: EdgeInsets.all(32),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_currentPage < _onboardingData.length - 1) {
//                         _pageController.nextPage(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       } else {
//                         // Move to welcome screen
//                         setState(() {
//                           _currentPage = 3;
//                         });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF4A90E2),
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(28),
//                       ),
//                     ),
//                     child: Text(
//                       'Next',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//         ),
//     );
//   }
//
//   Widget _buildOnboardingPage(OnboardingData data) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 32),
//     child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//     // Illustration
//     Container(
//     width: 250,
//     height: 250,
//     decoration: BoxDecoration(
//     color: Color(0xFF4A90E2).withOpacity(0.1),
//     borderRadius: BorderRadius.circular(20),
//     ),
//     child: Stack(
//     alignment: Alignment.center,
//     children: [
//     // Background elements
//     Positioned(
//     top: 30,
//     right: 30,
//     child: Container(
//     width: 40,
//     height: 40,
//     decoration: BoxDecoration(
//     color: Color(0xFF4A90E2).withOpacity(0.2),
//     borderRadius: BorderRadius.circular(8),
//     ),
//     ),
//     ),
//     Positioned(
//     bottom: 40,
//     left: 20,
//     child: Container(
//     width: 60,
//     height: 20,
//     decoration: BoxDecoration(
//     color: Color(0xFF4A90E2).withOpacity(0.3),
//     borderRadius: BorderRadius.circular(10),
//     ),
//     ),
//     ),
//     // Main icon
//     Icon(
//     data.image as IconData?,
//     size: 120,
//     color: Color(0xFF4A90E2),
//     ),
//     // Additional decorative elements based on current page
//     if (_currentPage == 0) ...[
//     Positioned(
//     top: 50,
//     left: 50,
//     child: Icon(Icons.location_on, color: Color(0xFF4A90E2), size: 30),
//     ),
//     ],
//     if (_currentPage == 1) ...[
//     Positioned(
//     bottom: 60,
//     right: 40,
//     child: Icon(Icons.motorcycle, color: Color(0xFF4A90E2), size: 40),
//     ),
//     ],
//     if (_currentPage == 2) ...[
//     Positioned(
//     top: 60,
//     right: 20,
//     child: Icon(Icons.access_time, color: Color(0xFF4A90E2), size: 25),
//     ),
//     ],
//     ],
//     ),
//     ),
//
//     SizedBox(height: 60),
//
//       // Title
//       Text(
//         data.title,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//           height: 1.3,
//         ),
//       ),
//
//       SizedBox(height: 24),
//
//       // Description
//       Text(
//         data.description,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.black54,
//           height: 1.5,
//         ),
//       ),
//     ],
//     ),
//     );
//   }
//
//   Widget _buildPageIndicators() {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(
//           _onboardingData.length,
//               (index) => AnimatedContainer(
//             duration: Duration(milliseconds: 300),
//             margin: EdgeInsets.symmetric(horizontal: 4),
//             width: _currentPage == index ? 24 : 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: _currentPage == index
//                   ? Color(0xFF4A90E2)
//                   : Color(0xFF4A90E2).withOpacity(0.3),
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeScreen() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF4A90E2),
//             Color(0xFF357ABD),
//           ],
//         ),
//       ),
//       child: SafeArea(
//       child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//       // Logo
//       Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Icon(
//         Icons.local_parking,
//         size: 60,
//         color: Color(0xFF4A90E2),
//       ),
//     ),
//
//     SizedBox(height: 60),
//
//     // Welcome text
//     Text(
//     'Welcome to Parking Wizard',
//     style: TextStyle(
//     fontSize: 28,
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//     ),
//     textAlign: TextAlign.center,
//     ),
//
//     SizedBox(height: 24),
//
//     // Description
//     Padding(
//     padding: EdgeInsets.symmetric(horizontal: 40),
//     child: Text(
//     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
//     style: TextStyle(
//     fontSize: 16,
//     color: Colors.white.withOpacity(0.9),
//     height: 1.5,
//     ),
//     textAlign: TextAlign.center,
//     ),
//     ),
//
//     SizedBox(height: 80),
//
//         // Allow Access button
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 32),
//           child: SizedBox(
//             width: double.infinity,
//             height: 56,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle allow access action
//                 _showSuccessDialog();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Color(0xFF4A90E2),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(28),
//                 ),
//               ),
//               child: Text(
//                 'Allow Access',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//       ),
//       ),
//     );
//   }
//
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           title: Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.green, size: 28),
//               SizedBox(width: 12),
//               Text('Welcome!'),
//             ],
//           ),
//           content: Text('You have successfully completed the onboarding process.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Reset to first page
//                 setState(() {
//                   _currentPage = 0;
//                 });
//                 _pageController.animateToPage(
//                   0,
//                   duration: Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                 );
//               },
//               child: Text('Start Over'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }
//
// // class OnboardingData {
// //   final String title;
// //   final String description;
// //   final IconData image;
// //   final Color backgroundColor;
// //
// //   OnboardingData({
// //     required this.title,
// //     required this.description,
// //     required this.image,
// //     required this.backgroundColor,
// //   });
// // }