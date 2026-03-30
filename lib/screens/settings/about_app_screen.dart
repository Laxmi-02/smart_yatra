import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('About SmartYatra'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // App Logo & Name
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.directions_bus,
                size: 80,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'SmartYatra',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your trusted companion for safe and smart bus travel across India.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // Information Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _buildInfoCard(
                    context,
                    'Privacy Policy',
                    'Read our privacy policy to understand how we protect your data.',
                    Icons.privacy_tip,
                    Colors.purple,
                    () {
                      _showContentDialog(
                        context,
                        'Privacy Policy',
                        '''At SmartYatra, we are committed to protecting your privacy. 

1. INFORMATION WE COLLECT
We collect information you provide directly to us, such as when you create an account, book a ticket, or contact customer support.

2. HOW WE USE YOUR INFORMATION
We use the information we collect to:
- Process your bookings
- Send you transactional messages
- Improve our services
- Provide customer support

3. DATA SECURITY
We implement appropriate technical and organizational measures to protect your personal information against unauthorized access.

4. SHARING OF INFORMATION
We do not sell your personal information. We may share information with:- Bus operators (for booking fulfillment)
- Payment processors
- Legal authorities (if required by law)

5. YOUR RIGHTS
You have the right to access, correct, or delete your personal information. Contact us at privacy@smartyatra.com for any requests.

Last Updated: January 2024''',
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    'Terms & Conditions',
                    'Read our terms and conditions for using the SmartYatra app.',
                    Icons.description,
                    Colors.blue,
                    () {
                      _showContentDialog(
                        context,
                        'Terms & Conditions',
                        '''By using the SmartYatra application, you agree to the following terms:

1. ELIGIBILITY
You must be at least 18 years old to use this service.

2. BOOKINGS
- All bookings are subject to availability.
- Cancellation policies vary by bus operator.
- Refunds are processed within 5-7 business days.

3. USER CONDUCT
You agree not to:
- Use the app for any unlawful purpose
- Harass or abuse our staff
- Attempt to hack or interfere with the service

4. PAYMENTS
- All payments are secure and encrypted.
- We accept major credit/debit cards, UPI, and net banking.
- Wallet balances are non-refundable but can be used for future bookings.

5. LIMITATION OF LIABILITY
SmartYatra is a booking platform. We are not responsible for:
- Delays or cancellations by bus operators
- Lost luggage
- Accidents during the journey
6. CHANGES TO TERMS
We reserve the right to modify these terms at any time. Continued use constitutes acceptance of new terms.

Last Updated: January 2024''',
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    'Cancellation Policy',
                    'Understand our refund and cancellation rules.',
                    Icons.cancel,
                    Colors.red,
                    () {
                      _showContentDialog(
                        context,
                        'Cancellation Policy',
                        '''CANCELLATION CHARGES

1. More than 48 hours before departure:
   - Cancellation Charge: 10% of fare
   - Refund: 90% of fare

2. Between 24-48 hours before departure:
   - Cancellation Charge: 25% of fare
   - Refund: 75% of fare

3. Between 12-24 hours before departure:
   - Cancellation Charge: 50% of fare
   - Refund: 50% of fare

4. Less than 12 hours before departure:
   - Cancellation Charge: 100% of fare
   - Refund: No refund

NOTE:
- Some bus operators may have different policies.
- Wallet refunds are instant.
- Bank/Card refunds take 5-7 working days.''',
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildInfoCard(
                    context,
                    'Contact Developer',
                    'Developed with ❤️ in India',
                    Icons.code,
                    Colors.green,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Developed by SmartYatra Team'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Social Media Links
            const Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, Colors.blue),
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.chat, Colors.green), // WhatsApp
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.camera_alt, Colors.purple), // Instagram
                const SizedBox(width: 20),
                _buildSocialIcon(Icons.video_library, Colors.red), // YouTube
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade400,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  void _showContentDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: SelectableText(
            content,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
