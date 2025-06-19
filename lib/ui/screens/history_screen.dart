import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/widgets/history/parking_item_widget.dart';

class ParkingHistoryItem {
  final String dateLabel;
  final String title;
  final String imgUrl;
  final String description;
  final String time;

  ParkingHistoryItem({
    required this.dateLabel,
    required this.title,
    required this.imgUrl,
    required this.description,
    required this.time,
  });
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, required this.title});
  final String title;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<ParkingHistoryItem> _history = [
    ParkingHistoryItem(
      dateLabel: "Today",
      title: "BMW M4",
      imgUrl:
          "https://i.pinimg.com/736x/f8/9d/61/f89d618220b6796d0667446677f97756.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "7:00 AM",
    ),
    ParkingHistoryItem(
      dateLabel: "Today",
      title: "Santa Cruz",
      imgUrl:
          "https://i.pinimg.com/736x/fa/75/5c/fa755c4e758c7c8b9430799fad3761b9.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "6:00 PM",
    ),
    ParkingHistoryItem(
      dateLabel: "01/02/2025",
      title: "Spector Cruz ",
      imgUrl:
          "https://i.pinimg.com/736x/43/94/b9/4394b9788a2b51d0263e832e3ca3c263.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "8:00 AM",
    ),
    ParkingHistoryItem(
      dateLabel: "01/02/2025",
      title: "Honda Cofe ",
      imgUrl:
          "https://i.pinimg.com/736x/01/e2/86/01e286e5c2d665f642132893a8378fcd.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "9:00 AM",
    ),
    ParkingHistoryItem(
      dateLabel: "20/04/2024",
      title: "Porsche GT3 RS",
      imgUrl:
          "https://i.pinimg.com/736x/cb/e6/34/cbe63403c7416d31164168fa5c754f6c.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "12:00 PM",
    ),
    ParkingHistoryItem(
      dateLabel: "20/04/2023",
      title: "Ferrari 488",
      imgUrl:
          "https://i.pinimg.com/736x/6f/7f/57/6f7f57b9021bc96ccfdd8abfa1ca9359.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "12:00 PM",
    ),
    ParkingHistoryItem(
      dateLabel: "20/04/2023",
      title: "Motor Bike",
      imgUrl:
          "https://i.pinimg.com/736x/d9/e6/df/d9e6df45ec81390ee6c5038fe68c36a6.jpg",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
      time: "3:00 PM",
    ),
  ];
  // group item by date
  Map<String, List<ParkingHistoryItem>> get _groupedHistory {
    final Map<String, List<ParkingHistoryItem>> map = {};
    for (var item in _history) {
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
              // addAutomaticKeepAlives: false,
              // children: [
              //   dateLabelWidget('Yesterday'),
              //   for (int i = 0; i < 5; i++) ...{
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 10),
              //       child: ParkingItemWidget(
              //         title: 'Porsche 911',
              //         imgUrl:
              //             "https://i.pinimg.com/736x/8a/41/59/8a4159e41cd24e689834e31a80dbf9fb.jpg",
              //         description:
              //             "Car parked in a shaded spot to avoid direct sunlight. Please remember to validate your parking ticket before leaving.",
              //       ),
              //     ),
              //   },
              //   Padding(
              //     padding: const EdgeInsets.only(top: 10),
              //     child: dateLabelWidget('Yesterday'),
              //   ),
              //   for (int i = 0; i < 5; i++) ...{
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 10),
              //       child: ParkingItemWidget(
              //         title: 'Porsche 911',
              //         imgUrl:
              //             "https://i.pinimg.com/736x/8a/41/59/8a4159e41cd24e689834e31a80dbf9fb.jpg",
              //         description:
              //             "Car parked in a shaded spot to avoid direct sunlight. Please remember to validate your parking ticket before leaving.",
              //       ),
              //     ),
              //   },
              // ],
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
                final DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2050),
                );
                if (dateTime != null) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                }
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
