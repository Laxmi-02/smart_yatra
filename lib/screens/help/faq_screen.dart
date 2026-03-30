import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildFAQItem(
            'How do I book a bus ticket?',
            '1. Enter your source and destination\n'
                '2. Select travel date\n'
                '3. Choose a bus from available options\n'
                '4. Select your preferred seats\n'
                '5. Enter passenger details\n'
                '6. Make payment\n'
                '7. Get your e-ticket instantly!',
          ),
          _buildFAQItem(
            'Can I cancel my ticket?',
            'Yes, you can cancel your ticket from the "My Bookings" section. '
                'Refund amount depends on the time of cancellation as per our '
                'cancellation policy.',
          ),
          _buildFAQItem(
            'How will I receive my ticket?',
            'Your e-ticket will be sent to your registered email address and '
                'mobile number. You can also view it in the "My Bookings" section.',
          ),
          _buildFAQItem(
            'Can I reschedule my journey?',
            'Currently, rescheduling is not available. You need to cancel '
                'your existing booking and make a new one.',
          ),
          _buildFAQItem(
            'What payment methods are accepted?',
            'We accept all major payment methods:\n'
                '• Credit/Debit Cards\n'
                '• UPI (Google Pay, PhonePe, Paytm, etc.)\n'
                '• Net Banking\n'
                '• Digital Wallets',
          ),
          _buildFAQItem(
            'How do I track my bus?',
            'Once your journey starts, you can track your bus in real-time '
                'using the "Track Bus" feature in the app. You\'ll see live '
                'location, ETA, and driver details.',
          ),
          _buildFAQItem(
            'What if my bus is delayed?',
            'In case of delay, you\'ll receive a notification. You can also '
                'track the bus location in real-time. For major delays, contact '
                'our support team.',
          ),
          _buildFAQItem(
            'Are there any hidden charges?',
            'No, there are no hidden charges. The price you see is the final '
                'price you pay.',
          ),
          _buildFAQItem(
            'Can I book for multiple passengers?',
            'Yes, you can book tickets for multiple passengers in a single '
                'booking. Just add passenger details for each person.',
          ),
          _buildFAQItem(
            'Is my personal information safe?',
            'Absolutely! We use industry-standard security measures to '
                'protect your personal and payment information.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.help_outline,
            color: Colors.blue,
            size: 24,
          ),
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
