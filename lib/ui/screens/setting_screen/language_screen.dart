// import 'package:flutter/material.dart';
// import 'package:parking_wizard/ui/screens/setting_screen/widgets/language_tile.dart';

// class LanguageScreen extends StatefulWidget {
//   const LanguageScreen({super.key});

//   @override
//   State<LanguageScreen> createState() => _LanguageScreenState();
// }

// class _LanguageScreenState extends State<LanguageScreen> {
//   int selectedIndex = 1;

//   final List<Map<String, String>> languages = [
//     {'flag': '🇰🇭', 'name': 'Khmer', 'region': 'Cambodia'},
//     {'flag': '🇬🇧', 'name': 'English', 'region': 'UK'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Back button
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Icon(Icons.arrow_back, size: 28),
//                   ),
//                 ),
//               ),

//               // Header image
//               ClipRRect(
//                 child: Image.asset(
//                   'assets/images/image_setting_page.png',
//                   width: double.infinity,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               // Language card with list
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title row
//                       Row(
//                         children: const [
//                           Icon(Icons.language),
//                           SizedBox(width: 8),
//                           Text(
//                             'Languages',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(Icons.check_box, color: Colors.blue),
//                         ],
//                       ),
//                       const SizedBox(height: 16),

//                       // Language list
//                       ListView.builder(
//                         shrinkWrap: true, // <- Important for nested ListView
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: languages.length,
//                         itemBuilder: (context, index) {
//                           final lang = languages[index];
//                           return LanguageTile(
//                             flag: lang['flag']!,
//                             name: lang['name']!,
//                             region: lang['region']!,
//                             selected: index == selectedIndex,
//                             onTap: () {
//                               setState(() {
//                                 selectedIndex = index;
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 1; // English selected by default

  final List<Map<String, String>> languages = [
    {'flag': '🇰🇭', 'name': 'Khmer', 'region': 'Cambodia'},
    {'flag': '🇬🇧', 'name': 'English', 'region': 'UK'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section with image and overlay
            Stack(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/image_setting_page.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Status bar overlay
                // Positioned(
                //   top: 40,
                //   left: 20,
                //   right: 20,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         '10:26',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.signal_cellular_4_bar,
                //             color: Colors.white,
                //             size: 16,
                //           ),
                //           SizedBox(width: 4),
                //           Icon(Icons.wifi, color: Colors.white, size: 16),
                //           SizedBox(width: 4),
                //           Icon(
                //             Icons.battery_full,
                //             color: Colors.white,
                //             size: 16,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Back button
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //   color: Colors.black.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Language selection content
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.14),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header with Languages title
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/language.png',
                            width: 24,
                            height: 24,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Languages',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Language options
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: languages.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey[200],
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemBuilder: (context, index) {
                      final language = languages[index];
                      final isSelected = index == selectedIndex;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              // Flag
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    language['flag']!,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),

                              SizedBox(width: 16),

                              // Language name
                              Expanded(
                                child: Text(
                                  language['name']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              // Region
                              Text(
                                '(${language['region']})',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600],
                                  fontFamily: 'Montserrat',
                                ),
                              ),

                              SizedBox(width: 16),

                              // Selection indicator
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// If you still want to use the separate LanguageTile widget, here's the updated version:
class LanguageTile extends StatelessWidget {
  final String flag;
  final String name;
  final String region;
  final bool selected;
  final VoidCallback onTap;

  const LanguageTile({
    Key? key,
    required this.flag,
    required this.name,
    required this.region,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Flag
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Center(child: Text(flag, style: TextStyle(fontSize: 18))),
            ),

            SizedBox(width: 16),

            // Language name
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // Region
            Text(
              '($region)',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(width: 16),

            // Selection indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.blue : Colors.transparent,
                border: Border.all(
                  color: selected ? Colors.blue : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: selected
                  ? Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
