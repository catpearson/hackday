import 'package:flutter/material.dart';
import 'appointment_card_screen.dart';

void main() {
  runApp(const HackdayApp());
}

class HackdayApp extends StatelessWidget {
  const HackdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Hackday',
      debugShowCheckedModeBanner: false,
      home: AppointmentCardScreen(),
    );
  }
}
