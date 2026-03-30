import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final _couponController = TextEditingController();

  // Sample Active Offers
  final List<Map<String, dynamic>> _activeOffers = [
    {
      'id': 1,
      'title': 'Welcome Offer',
      'code': 'SMART20',
      'discount': '20% OFF',
      'description': 'Get 20% off on your first booking. Max discount ₹200.',
      'validity': 'Valid till 31 Dec 2024',
      'color': Colors.green,
      'isActive': true,
    },
    {
      'id': 2,
      'title': 'Weekend Special',
      'code': 'WEEKEND50',
      'discount': '₹50 OFF',
      'description': 'Flat ₹50 off on bookings above ₹500. Valid on Sat-Sun.',
      'validity': 'Valid every weekend',
      'color': Colors.orange,
      'isActive': true,
    },
    {
      'id': 3,
      'title': 'Student Discount',
      'code': 'STUDENT10',
      'discount': '10% OFF',
      'description': 'Exclusive discount for students. Valid ID required.',
      'validity': 'Valid till 30 Jun 2025',
      'color': Colors.blue,
      'isActive': true,
    },
  ];

  // Sample Expired Offers
  final List<Map<String, dynamic>> _expiredOffers = [
    {
      'id': 4,
      'title': 'Diwali Dhamaka',
      'code': 'DIWALI100',
      'discount': '₹100 OFF',
      'description': 'Celebrate Diwali with huge savings!',
      'validity': 'Expired on 15 Nov 2024',
      'color': Colors.red,
      'isActive': false,
    },
  ];

  void _applyCoupon(String code) {
    if (code.isEmpty) return;

    // Check if code exists
    bool isValid =
        _activeOffers.any((offer) => offer['code'] == code.toUpperCase());

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Coupon "$code" applied successfully! 🎉'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Use Now',
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context); // Go back to search/booking
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Coupon Code. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Offers & Coupons'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Apply Coupon Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.purpleAccent],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Have a Coupon Code?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _couponController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter code here...',
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _applyCoupon(_couponController.text),
                        child: const Text('Apply'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Active Offers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Active Offers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ..._activeOffers
                      .map((offer) => _buildOfferCard(offer))
                      .toList(),
                ],
              ),
            ),

            const SizedBox(height: 25),
            // Expired Offers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expired Offers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ..._expiredOffers
                      .map((offer) => _buildOfferCard(offer))
                      .toList(),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    bool isActive = offer['isActive'];

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isActive
              ? (offer['color'] as Color).withOpacity(0.3)
              : Colors.grey.shade300,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isActive
              ? (offer['color'] as Color).withOpacity(0.05)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Discount Badge
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (offer['color'] as Color).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    offer['discount'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: offer['color'] as Color,
                    ),
                  ),
                  if (!isActive)
                    const Text(
                      'EXPIRED',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 15),

            // Offer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        offer['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration:
                              isActive ? null : TextDecoration.lineThrough,
                          color: isActive ? Colors.black87 : Colors.grey,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'ACTIVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    offer['description'],
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      decoration: isActive ? null : TextDecoration.lineThrough,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.label_outline,
                          size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text(
                        'Code: ${offer['code']}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isActive ? Colors.blue : Colors.grey,
                        ),
                      ),
                      if (isActive) ...[
                        IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            // Copy to clipboard logic would go here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Code ${offer['code']} copied!')),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    offer['validity'],
                    style: TextStyle(
                      fontSize: 11,
                      color: isActive ? Colors.grey.shade500 : Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
}
