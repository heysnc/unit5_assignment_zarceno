import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 231, 91, 158)),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  int additionResult = 0;
  int subtractionResult = 0;
  int multiplicationResult = 0;
  int divisionResult = 0;

  void calculateResults() {
    setState(() {
      int firstNum = int.tryParse(firstController.text) ?? 0;
      int secondNum = int.tryParse(secondController.text) ?? 0;

      additionResult = firstNum + secondNum;
      subtractionResult = firstNum - secondNum;
      multiplicationResult = firstNum * secondNum;
      divisionResult = secondNum != 0 ? (firstNum ~/ secondNum) : 0;
    });
  }

  void clearInputs() {
    setState(() {
      firstController.clear();
      secondController.clear();
      additionResult = 0;
      subtractionResult = 0;
      multiplicationResult = 0;
      divisionResult = 0;
    });
  }

  Widget operationRow(String operation, int result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: TextField(
            controller: firstController,
            decoration: const InputDecoration(labelText: "First Number"),
            keyboardType: TextInputType.number,
            onChanged: (_) => calculateResults(),
          ),
        ),
        Text(" $operation "),
        Expanded(
          child: TextField(
            controller: secondController,
            decoration: const InputDecoration(labelText: "Second Number"),
            keyboardType: TextInputType.number,
            onChanged: (_) => calculateResults(),
          ),
        ),
        Text(' = $result'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            operationRow("+", additionResult),
            operationRow("-", subtractionResult),
            operationRow("*", multiplicationResult),
            operationRow("/", divisionResult),
            ElevatedButton(
              onPressed: clearInputs,
              child: const Text("Clear"),
            ),
          ],
        ),
      ),
    );
  }
}
