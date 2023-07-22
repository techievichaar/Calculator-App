import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  // variables
  num firstNum = 0;
  num secondNum = 0;
  var input = "";
  var output = "";
  var opearation = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    /// if value is  AC
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          /// input output area
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? "" : input,
                  style: TextStyle(fontSize: 48, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.8)),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeCOlor),
              button(
                  text: "<", buttonBgColor: operatorColor, tColor: orangeCOlor),
              button(text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeCOlor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(
                text: "9",
              ),
              button(
                  text: "x", buttonBgColor: operatorColor, tColor: orangeCOlor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", buttonBgColor: operatorColor, tColor: orangeCOlor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", buttonBgColor: operatorColor, tColor: orangeCOlor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonBgColor: operatorColor, tColor: orangeCOlor),
              button(text: "0"),
              button(text: ".", buttonBgColor: operatorColor),
              button(text: "=", buttonBgColor: orangeCOlor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: buttonBgColor,
              padding: EdgeInsets.all(22),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
