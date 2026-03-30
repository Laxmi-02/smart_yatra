import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Current selected language
  String _selectedLanguage = 'English';

  // Available languages list
  final List<Map<String, dynamic>> _languages = [
    {
      'code': 'en',
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇺🇸',
      'isRTL': false,
    },
    {
      'code': 'hi',
      'name': 'Hindi',
      'nativeName': 'हिंदी',
      'flag': '🇮🇳',
      'isRTL': false,
    },
    {
      'code': 'es',
      'name': 'Spanish',
      'nativeName': 'Español',
      'flag': '🇪🇸',
      'isRTL': false,
    },
    {
      'code': 'fr',
      'name': 'French',
      'nativeName': 'Français',
      'flag': '🇫🇷',
      'isRTL': false,
    },
    {
      'code': 'de',
      'name': 'German',
      'nativeName': 'Deutsch',
      'flag': '🇩🇪',
      'isRTL': false,
    },
    {
      'code': 'ar',
      'name': 'Arabic',
      'nativeName': 'العربية',
      'flag': '🇸🇦',
      'isRTL': true, // Right to Left
    },
  ];

  void _changeLanguage(String code, String name) {
    setState(() {
      _selectedLanguage = name;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language changed to $name successfully!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _selectedLanguage = 'English';
            });
          },
        ),
      ),
    );

    // Note: In a real app, you would save this preference to SharedPreferences
    // and restart the app to apply translations.

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Select Language'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Info Card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.translate, color: Colors.blue.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Choose your preferred language for the app interface.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Languages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = lang['name'] == _selectedLanguage;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  color: isSelected ? Colors.blue.shade50 : Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: Text(
                      lang['flag'],
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      lang['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color:
                            isSelected ? Colors.blue.shade800 : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      lang['nativeName'],
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.blue.shade600
                            : Colors.grey.shade600,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.blue.shade700,
                            size: 28,
                          )
                        : null,
                    onTap: () {
                      _showConfirmationDialog(lang['code'], lang['name']);
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showConfirmationDialog(String code, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Language'),
        content: Text('Are you sure you want to switch to $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _changeLanguage(code, name); // Change language
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text('Yes, Change',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
