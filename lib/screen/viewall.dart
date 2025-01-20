import 'package:flutter/material.dart';
import '../styles/typography.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B2A47)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {},
              child: Text('Edit', style: AppTypography.viewAllText),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: OutlinedButton(
          //     onPressed: () {},
          //     child: Text('Remove', style: AppTypography.viewAllText),
          //   ),
          // ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // replace with your dynamic item count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Image.asset('assets/logo.png', width: 50, height: 50),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Jon Doe', style: AppTypography.businessCardTitle, overflow: TextOverflow.ellipsis),
                                  Text('CEO & Founder - ABC Company', style: AppTypography.businessCardSubtitle, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF0B2A47)),
                        onPressed: () {
                          // Handle delete action
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.phone, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('011 234567\n077 1234567', style: AppTypography.businessCardSubtitle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.email, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('example@mail.com', style: AppTypography.businessCardSubtitle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.web, color: Color.fromARGB(255, 61, 66, 70)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('example.com', style: AppTypography.businessCardSubtitle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('123, nowhere st, New York, US', style: AppTypography.businessCardSubtitle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
