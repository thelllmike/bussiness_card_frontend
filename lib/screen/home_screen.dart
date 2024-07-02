import 'package:beehive/styles/typography.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFF69C2C), // button background color
              ),
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add New', style: AppTypography.button),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {},
              child: Text('View All', style: AppTypography.button.copyWith(color: const Color(0xFF0B2A47))),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // replace with your dynamic item count
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/logo.png', width: 50, height: 50),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jon Doe', style: AppTypography.businessCardTitle),
                          Text('CEO & Founder - ABC Company', style: AppTypography.businessCardSubtitle),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.phone, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Text('011 234567\n077 1234567', style: AppTypography.businessCardSubtitle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.email, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Text('example@mail.com', style: AppTypography.businessCardSubtitle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.web, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Text('example.com', style: AppTypography.businessCardSubtitle),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF0B2A47)),
                      SizedBox(width: 8),
                      Text('123, nowhere st, New York, US', style: AppTypography.businessCardSubtitle),
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
