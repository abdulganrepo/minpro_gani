// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "About Me",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Muhammad Abdul Gani Wijaya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mobile Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    showMailAlertDialog(context);
                  },
                  icon: const Icon(Icons.mail),
                ),
                IconButton(
                  onPressed: () {
                    showMessageAlertDialog(context);
                  },
                  icon: const Icon(Icons.message),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showMailAlertDialog(BuildContext context) {
  const snackbar = const SnackBar(
    content: const Text("muhammad.gani33@gmail.com"),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showMessageAlertDialog(BuildContext context) {
  const snackbar = const SnackBar(
    content: const Text("THANK YOU !!!"),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
