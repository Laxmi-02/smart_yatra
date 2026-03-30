import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'faq_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'live_chat_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _copyEmailToClipboard(BuildContext context) async {
    await Clipboard.setData(
        const ClipboardData(text: 'support@smartyatra.com'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email copied to clipboard!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> _copyPhoneToClipboard(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: '1800-123-4567'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number copied to clipboard!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@smartyatra.com',
      query: 'subject=Help%20Request&body=Please%20describe%20your%20issue',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        await _copyEmailToClipboard(context);
      }
    } catch (e) {
      await _copyEmailToClipboard(context);
    }
  }

  Future<void> _makePhoneCall(BuildContext context) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '1800-123-4567',
    );

    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        await _copyPhoneToClipboard(context);
      }
    } catch (e) {
      await _copyPhoneToClipboard(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('Help & Support'),
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(Icons.help_outline, size: 60, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'How can we help you?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'We\'re here to assist you 24/7',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Help',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    _buildHelpCard(
                      context,
                      'Call Support',
                      'Tap to copy: 1800-123-4567',
                      Icons.phone,
                      Colors.green,
                      () => _makePhoneCall(context),
                    ),
                    const SizedBox(height: 10),
                    _buildHelpCard(
                      context,
                      'Email Support',
                      'Tap to copy: support@smartyatra.com',
                      Icons.email,
                      Colors.blue,
                      () => _sendEmail(context),
                    ),
                    const SizedBox(height: 10),
                    _buildHelpCard(
                      context,
                      'FAQs',
                      'Find answers to common questions',
                      Icons.question_answer,
                      Colors.orange,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildHelpCard(
                      context,
                      'Cancellation Policy',
                      'Know our cancellation rules',
                      Icons.info_outline,
                      Colors.purple,
                      () => _showCancellationPolicy(context),
                    ),
                    const SizedBox(height: 10),
                    _buildHelpCard(
                      context,
                      'Live Chat',
                      'Chat with us in real-time',
                      Icons.chat,
                      Colors.teal,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LiveChatScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          _buildContactInfo(
                              '📍 Address', '123 Tech Park, Delhi - 110001'),
                          const SizedBox(height: 10),
                          _buildContactInfo('📞 Toll Free', '1800-123-4567'),
                          const SizedBox(height: 10),
                          _buildContactInfo(
                              '✉️ Email', 'support@smartyatra.com'),
                          const SizedBox(height: 10),
                          _buildContactInfo(
                              '🕐 Support Hours', '24/7 Available'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHelpCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey.shade400, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String label, String value) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14))),
        Expanded(
            flex: 3,
            child: Text(value,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14))),
      ],
    );
  }

  void _showCancellationPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancellation Policy'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPolicyPoint('✓ More than 24 hours before', '100% refund'),
              const SizedBox(height: 8),
              _buildPolicyPoint('✓ 12-24 hours before', '75% refund'),
              const SizedBox(height: 8),
              _buildPolicyPoint('✓ 6-12 hours before', '50% refund'),
              const SizedBox(height: 8),
              _buildPolicyPoint('✗ Less than 6 hours', 'No refund'),
              const SizedBox(height: 15),
              const Text(
                'Note: Refund will be processed within 5-7 business days.',
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildPolicyPoint(String label, String refund) {
    return Row(
      children: [
        Expanded(
            flex: 3, child: Text(label, style: const TextStyle(fontSize: 13))),
        Expanded(
            flex: 2,
            child: Text(refund,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 13))),
      ],
    );
  }
}
