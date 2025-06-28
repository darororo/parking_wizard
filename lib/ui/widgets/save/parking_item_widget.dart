import 'dart:io';
import "package:flutter/material.dart";

class ParkingItemWidget extends StatelessWidget {
  const ParkingItemWidget({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.time,
    required this.onTap,
  });

  final String imgUrl;
  final String title;
  final String description;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 140,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade400, width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.14),
            offset: const Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: (imgUrl.startsWith('http') || imgUrl.startsWith('https'))
                  ? Image.network(
                      imgUrl,
                      height: 130,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(imgUrl),
                      height: 130,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title row
                  SizedBox(
                    height: 20,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz_sharp),
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  // description
                  SizedBox(
                    width: 220, // Set your desired width
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14, right: 20),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),

                  // time and more details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Time $time",
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 11,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 10),
                          child: Row(
                            children: [
                              const Text(
                                "More Details",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
