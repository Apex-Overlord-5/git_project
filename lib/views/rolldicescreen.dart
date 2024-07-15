import 'dart:math';
import 'package:flutter/material.dart';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen({super.key, required this.title});
  final String title;

  @override
  State<RollDiceScreen> createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  int imageNumber = 6;

  void generateRandomNumber() {
    setState(() {
      imageNumber = Random().nextInt(6) + 1; // Dice will start from 1 to 6
    });

    print(imageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/images/$imageNumber.png", width: 200)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: generateRandomNumber,
            child: Text("Roll Rubesh's Dice")
          ),
          SizedBox(height: 20),
          Text(
            "Rubesh Raman 12115752",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
