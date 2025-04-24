import 'package:flutter/material.dart';
import 'package:dtmobile/pages/home_page.dart';

class OTPVerificationPage extends StatelessWidget {
  final String phoneNumber;

  const OTPVerificationPage({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color djiboutiBlue = Color(0xFF0A3B76);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: djiboutiBlue,
        title: const Text("Vérification OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Code OTP envoyé à $phoneNumber",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Entrer OTP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: djiboutiBlue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                // Supposons que l'OTP soit vérifié avec succès.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(phoneNumber: phoneNumber),
                  ),
                );
              },
              child: const Text(
                "Vérifier",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
