import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';
import 'package:parking_wizard/ui/screens/save_screen.dart';

class ParkingDetailScreen extends ConsumerWidget {
  final String title;
  final String imgUrl;
  final String description;
  final String time;

  const ParkingDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.time,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingItem = ref.read(activeSaveScreenItemProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 60,
        leadingWidth: 40,
        title: Text(
          'Parking Details',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => {context.pop()},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 220,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Image.file(File(parkingItem!.imgUrl)),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          parkingItem!.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          'Time: 6:44 PM',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      parkingItem.time,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFCCCCCC)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Notes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Divider(color: Color(0xFFCCCCCC), thickness: 1),
                          SizedBox(height: 6),
                          Text(
                            parkingItem.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Open in Google Map',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.sizeOf(context).height * 0.25,
                child: OpenStreetMapWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(url, height: 220, width: 320, fit: BoxFit.cover),
    );
  }
}
