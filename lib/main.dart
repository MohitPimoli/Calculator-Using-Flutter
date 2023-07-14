import 'package:flutter/material.dart';
import 'bmi_calculator.dart';
import 'package:calculator/colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: operatorColor,
        shadowColor: Colors.black,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicator: BoxDecoration(
                color: operatorColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelColor: orangeColor,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(text: 'Calculator'),
                Tab(text: 'BMI'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const CalculatorApp(title: 'Calculator'),
                  BMICalculator(),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: buttonColor,
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key, required this.title});
  final String title;
  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double num1 = 0.0;
  double num2 = 0.0;
  var input = '';
  var output = '';
  String operation = "";
  var hideinput = false;
  var outputsize = 34.0;
  final int inputLimit = 15;

  void buttonPressed(String buttonText) async {
    if (buttonText == "AC") {
      input = '';
      output = '';
    } else if (buttonText == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (buttonText == "=") {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = input.replaceAll("X", "*");
        Parser p = Parser();
        Expression exp = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalval = exp.evaluate(EvaluationType.REAL, cm);
        output = finalval.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 40;
        FlutterTts tts = FlutterTts();
        await tts.speak(output);
      }
    } else {
      input = input + buttonText;
      hideinput = false;
      outputsize = 30;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //////////////_INPUT AND OUTPUT AREA_//////////////////
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: const Color.fromARGB(255, 19, 17, 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    hideinput ? '' : input,
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    minFontSize: 20,
                    maxFontSize: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    output,
                    style: TextStyle(
                      fontSize: outputsize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    minFontSize: 20,
                    maxFontSize: 40,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          /////////input screen///////////
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "<", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "."),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "X", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "0"),
              button(text: "00"),
              button(text: "=", buttonBgColor: orangeColor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(22),
            primary: buttonBgColor,
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
