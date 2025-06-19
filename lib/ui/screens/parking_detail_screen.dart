import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/screens/open_street_map.dart';

class ParkingDetailScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                            _buildImage(
                              'https://i.pinimg.com/736x/cb/38/6a/cb386ad02edb00c831e32643b2e7f306.jpg',
                            ),
                            const SizedBox(width: 12),
                            _buildImage(
                              'https://i.pinimg.com/736x/ec/e0/6e/ece06e300e3a809becbdb651d8d49299.jpg',
                            ),
                            const SizedBox(width: 12),
                            _buildImage(
                              'https://i.pinimg.com/736x/65/ae/db/65aedb82a3de3584fbba370c0a2f80a4.jpg',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Porsche GT3 911',
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
                      'Location: No. 28, Street 302, BKK1, Phnom Penh, Cambodia',
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
                        children: const [
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
                            'I parked my vehicle near building 3, in front the E Luk Bay.',
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
