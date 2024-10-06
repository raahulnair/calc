import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';
  String result = '0';
  String operator = '';
  double num1 = 0;
  double num2 = 0;
  bool isOperatorSelected = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        displayText = '0';
        result = '0';
        num1 = 0;
        num2 = 0;
        operator = '';
        isOperatorSelected = false;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (!isOperatorSelected) {
          num1 = double.parse(displayText);
          operator = buttonText;
          displayText = '';
          isOperatorSelected = true;
        }
      } else if (buttonText == "=") {
        num2 = double.parse(displayText);
        if (operator == "+") {
          result = (num1 + num2).toString();
        } else if (operator == "-") {
          result = (num1 - num2).toString();
        } else if (operator == "*") {
          result = (num1 * num2).toString();
        } else if (operator == "/") {
          result = num2 != 0 ? (num1 / num2).toString() : 'Error';
        }
        displayText = result;
        isOperatorSelected = false;
      } else if (buttonText == ".") {
        if (!displayText.contains(".")) {
          displayText += ".";
        }
      } else {
        displayText += buttonText;
      }
      if (displayText == '') {
        displayText = '0';
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () => buttonPressed(buttonText),
        child: Container(
          margin: EdgeInsets.all(8),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> buttonTexts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          buttonTexts.map((buttonText) => buildButton(buttonText)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.centerRight,
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                buildButtonRow(['7', '8', '9', '/']),
                buildButtonRow(['4', '5', '6', '*']),
                buildButtonRow(['1', '2', '3', '-']),
                buildButtonRow(['C', '0', '.', '+']),
                buildButtonRow(['=', '', '', '']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
