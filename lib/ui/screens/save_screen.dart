import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/widgets/save/parking_item_widget.dart';
import 'package:parking_wizard/ui/widgets/datefilter.dart';
import 'dart:io';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';

class SaveScreenItem {
  final String dateLabel;
  final String title;
  final String imgUrl;
  final String description;
  final String time;

  SaveScreenItem({
    required this.dateLabel,
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.time,
  });
}

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key, required this.title});
  final String title;

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final ParkingService _databaseService = ParkingService.instance;

  late Future<List<ParkingSpot>> _parkingFuture;

  @override
  void initState() {
    super.initState();
    _loadParking(); // Initial load
  }

  void _loadParking() {
    _parkingFuture = _databaseService.getParking();
  }

  final List<SaveScreenItem> _save = [
    SaveScreenItem(
      dateLabel: "Today",
      title: "GT2 RS",
      imgUrl:
          "https://i.pinimg.com/736x/36/04/24/36042426ea56fa94687ea684705043d1.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "7:00 AM",
    ),
    SaveScreenItem(
      dateLabel: "Today",
      title: "GT3 RS",
      imgUrl:
          "https://i.pinimg.com/736x/57/70/60/57706026cec1428ff595f215655f2a86.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "12:00 PM",
    ),
  ];
  // group item by date
  Map<String, List<SaveScreenItem>> get _groupedHistory {
    final Map<String, List<SaveScreenItem>> map = {};
    for (var item in _save) {
      map.putIfAbsent(item.dateLabel, () => []).add(item);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(bottom: 10),
      //       child: filterButtonWidget(),
      //     ),
      //     Expanded(
      //       child: ListView(
      //         addAutomaticKeepAlives: false,
      //         children: [
      //           for (var entry in _groupedHistory.entries) ...[
      //             dateLabelWidget(entry.key),
      //             for (var item in entry.value)
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 10),
      //                 child: ParkingItemWidget(
      //                   title: item.title,
      //                   imgUrl: item.imgUrl,
      //                   description: item.description,
      //                   time: item.time,
      //                   onTap: () {
      //                     context.push('/parking');
      //                   },
      //                 ),
      //               ),
      //             const SizedBox(height: 10),
      //           ],
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      // SEANG
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 50,
        leadingWidth: 40,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: _parkingList(),
    );
  }

  // Widget _parkingList() {
  //   return FutureBuilder<List<ParkingSpot>>(
  //     future: _databaseService.getParking(), // You need to implement this
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //         return const Center(child: Text('No parking spots saved.'));
  //       }

  //       final spots = snapshot.data!;

  //       return ListView.builder(
  //         itemCount: spots.length,
  //         itemBuilder: (context, index) {
  //           final spot = spots[index];
  //           return ListTile(
  //             leading: (spot.imageUrls != null && spot.imageUrls.isNotEmpty)
  //                 ? spot.imageUrls[0].startsWith('http')
  //                       ? Image.network(
  //                           spot.imageUrls[0],
  //                           height: 50,
  //                           width: 50,
  //                           fit: BoxFit.cover,
  //                         )
  //                       : Image.file(
  //                           File(spot.imageUrls[0]),
  //                           height: 50,
  //                           width: 50,
  //                           fit: BoxFit.cover,
  //                         )
  //                 : const Icon(Icons.local_parking),
  //             title: Text(spot.title),
  //             subtitle: Text(spot.notes),
  //             trailing: Text(spot.parkingTime.toLocal().toString()),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget _parkingList() {
  //   return FutureBuilder<List<ParkingSpot>>(
  //     future: _databaseService.getParking(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //         return const Center(child: Text('No parking spots saved.'));
  //       }

  //       final spots = snapshot.data!;

  //       return ListView.builder(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         itemCount: spots.length,
  //         itemBuilder: (context, index) {
  //           final spot = spots[index];

  //           // Fallback values if data is missing
  //           final imageUrl = (spot.imageUrls.isNotEmpty)
  //               ? (spot.imageUrls[0].startsWith('http')
  //                     ? spot.imageUrls[0]
  //                     : File(spot.imageUrls[0]).path)
  //               : 'https://via.placeholder.com/150';

  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: 10),
  //             child: ParkingItemWidget(
  //               title: spot.title,
  //               imgUrl: imageUrl,
  //               description: spot.notes,
  //               time: spot.parkingTime.toLocal().toString().substring(11, 16),
  //               onTap: () {
  //                 context.push('/parking'); // Or any detail route
  //               },
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget _parkingList() {
    return FutureBuilder<List<ParkingSpot>>(
      future: _parkingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No parking spots saved.'));
        }

        final spots = snapshot.data!;

        // ✅ Filter by selected date and group by formatted label
        final Map<String, List<ParkingSpot>> groupedByDate = {};
        for (var spot in spots) {
          final spotDate = DateTime(
            spot.parkingTime.year,
            spot.parkingTime.month,
            spot.parkingTime.day,
          );
          final selected = DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
          );
          if (spotDate == selected) {
            final label = _formatDateLabel(spot.parkingTime);
            groupedByDate.putIfAbsent(label, () => []).add(spot);
          }
        }

        // return Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(bottom: 10),
        //       child: filterButtonWidget(_selectedDate),
        //     ),
        //     Expanded(
        //       child: groupedByDate.isEmpty
        //           ? const Center(child: Text('No data for selected date.'))
        //           : ListView(
        //               addAutomaticKeepAlives: false,
        //               children: [
        //                 for (var entry in groupedByDate.entries) ...[
        //                   dateLabelWidget(entry.key),
        //                   for (var spot in entry.value)
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(
        //                         horizontal: 10,
        //                       ),
        //                       child: ParkingItemWidget(
        //                         title: spot.title,
        //                         imgUrl: (spot.imageUrls.isNotEmpty)
        //                             ? (spot.imageUrls[0].startsWith('http')
        //                                   ? spot.imageUrls[0]
        //                                   : File(spot.imageUrls[0]).path)
        //                             : 'https://via.placeholder.com/150',
        //                         description: spot.notes,
        //                         time: spot.parkingTime
        //                             .toLocal()
        //                             .toString()
        //                             .substring(11, 16),
        //                         onTap: () {
        //                           context.push('/parking');
        //                         },
        //                       ),
        //                     ),
        //                   const SizedBox(height: 10),
        //                 ],
        //               ],
        //             ),
        //     ),
        //   ],)

        // CRUD2
        return ListView.builder(
          itemCount: spots.length,
          itemBuilder: (context, index) {
            final spot = spots[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(spot.notes),
                    const SizedBox(height: 12),
                    if (spot.imageUrls.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: spot.imageUrls.map((url) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: url.startsWith('http')
                                ? Image.network(
                                    url,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(url),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 10),
                    Text(
                      'Parked at: ${spot.parkingTime.toLocal()}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return "Today";
    if (target == today.subtract(const Duration(days: 1))) return "Yesterday";

    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // Row dateLabelWidget(String dateLabel) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 16),
  //         child: Text(
  //           dateLabel,
  //           style: TextStyle(
  //             fontFamily: 'Montserrat',
  //             fontSize: 12,
  //             color: Colors.grey.shade700,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Row dateLabelWidget(String dateLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
          child: Text(
            dateLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Row filterButtonWidget() {
  //   // DateTime selectedDate = DateTime.now();
  //   DateTime selectedDate = DateTime.now();
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(right: 16.0),
  //         child: SizedBox(
  //           width: 120,
  //           height: 36,
  //           child: OutlinedButton(
  //             style: OutlinedButton.styleFrom(
  //               foregroundColor: Colors.black,
  //               side: BorderSide(color: Colors.grey.shade700, width: 1.0),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               padding: const EdgeInsets.symmetric(horizontal: 10),
  //             ),
  //             onPressed: () async {
  //               showDialog(
  //                 context: context,
  //                 builder: (context) => CustomDatePickerDialog(
  //                   initialDate: selectedDate,
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime(2050),
  //                   onDateSelected: (DateTime newDate) {
  //                     setState(() {
  //                       selectedDate = newDate;
  //                     });
  //                   },
  //                 ),
  //               );
  //             },
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 const Text(
  //                   'Filter dates',
  //                   style: TextStyle(
  //                     fontFamily: 'Montserrat',
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(width: 10),
  //                 const Icon(Icons.filter_list, size: 18, color: Colors.black),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Row filterButtonWidget(DateTime selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SizedBox(
            width: 120,
            height: 36,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey.shade700, width: 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => CustomDatePickerDialog(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    onDateSelected: (DateTime newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Filter dates',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.filter_list, size: 18, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
