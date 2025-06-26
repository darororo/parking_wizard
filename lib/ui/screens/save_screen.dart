import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/widgets/save/parking_item_widget.dart';
import 'package:parking_wizard/ui/widgets/datefilter.dart';

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
          Expanded(
            child: ListView(
              addAutomaticKeepAlives: false,
              children: [
                for (var entry in _groupedHistory.entries) ...[
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
            ),
          ),
        ],
      ),
    );
  }

  Row dateLabelWidget(String dateLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
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

  Row filterButtonWidget() {
    // DateTime selectedDate = DateTime.now();
    DateTime selectedDate = DateTime.now();
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
                        selectedDate = newDate;
                      });
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Filter dates',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.filter_list, size: 18, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
