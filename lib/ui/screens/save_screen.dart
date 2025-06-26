import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/widgets/save/parking_item_widget.dart';
import 'package:parking_wizard/ui/widgets/datefilter.dart';
import 'dart:io';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';

// crud
import 'dart:io';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/common/service/parking_service.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

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
  // crud
  final ParkingService _databaseService = ParkingService.instance;
  late Future<List<ParkingSpot>> _parkingFuture;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadParking(); // Initial load
  }

  void _loadParking() {
    _parkingFuture = _databaseService.getParking();
  }

  // Convert ParkingSpot to SaveScreenItem and group by date
  Map<String, List<SaveScreenItem>> _groupParkingSpotsByDate(
    List<ParkingSpot> spots,
  ) {
    final Map<String, List<SaveScreenItem>> map = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var spot in spots) {
      final spotDate = DateTime(
        spot.parkingTime.year,
        spot.parkingTime.month,
        spot.parkingTime.day,
      );

      String dateLabel;
      if (spotDate.isAtSameMomentAs(today)) {
        dateLabel = "Today";
      } else if (spotDate.isAtSameMomentAs(yesterday)) {
        dateLabel = "Yesterday";
      } else {
        dateLabel = DateFormat('MMM dd, yyyy').format(spotDate);
      }

      final item = SaveScreenItem(
        dateLabel: dateLabel,
        title: spot.title,
        imgUrl: spot.imageUrls.isNotEmpty ? spot.imageUrls.first : '',
        description: spot.notes,
        time: DateFormat('h:mm a').format(spot.parkingTime),
      );

      map.putIfAbsent(dateLabel, () => []).add(item);
    }

    // Sort each group by time (most recent first)
    map.forEach((key, value) {
      value.sort((a, b) => b.time.compareTo(a.time));
    });

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: filterButtonWidget(),
          ),
          Expanded(child: _parkingList()),
        ],
      ),
    );
  }

  Widget _parkingList() {
    return FutureBuilder<List<ParkingSpot>>(
      future: _parkingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_parking_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No parking spots saved.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          );
        }

        final spots = snapshot.data!;
        final groupedHistory = _groupParkingSpotsByDate(spots);

        if (groupedHistory.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_parking_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No parking spots saved.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          );
        }

        return ListView(
          addAutomaticKeepAlives: false,
          children: [
            for (var entry in groupedHistory.entries) ...[
              dateLabelWidget(entry.key),
              for (var item in entry.value)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ParkingItemWidget(
                    title: item.title,
                    imgUrl: item.imgUrl,
                    description: item.description,
                    time: item.time,
                    onTap: () {
                      context.push('/parking');
                    },
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }

  Row dateLabelWidget(String dateLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text(
            dateLabel,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Row filterButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
          child: SizedBox(
            width: 120,
            height: 38,
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
                        selectedDate = newDate;
                        // Optionally filter the results based on selected date
                        _loadParking(); // Reload data if needed
                      });
                    },
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Filter dates',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.filter_list, size: 16, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
