import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:prj1/Constants/constants.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String equation = "0";
  String result = "0";
  String expression = '';
  double equationFont = 48.0;
  double resultFont = 38.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFont = 48.0;
        resultFont = 38.0;
      } else if (buttonText == "DEL") {
        equationFont = 48.0;
        resultFont = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) equation = "0";
      } else if (buttonText == "=") {
        equationFont = 38.0;
        resultFont = 48.0;
        expression = equation;
        try {
          Parser pr = Parser();
          Expression ex = pr.parse(expression);
          ContextModel cm = ContextModel();
          double eval = ex.evaluate(EvaluationType.REAL, cm);
          print(eval);
          result = eval.toString();
        } catch (e) {
          result = "E";
        }
      } else {
        equationFont = 48.0;
        resultFont = 38.0;
        if (equation == "0") {
          if (buttonText == "sin" ||
              buttonText == "ln" ||
              buttonText == "tan" ||
              buttonText == "cos") {
            equation = buttonText + "(";
          } else
            equation = buttonText;
        } else if (buttonText == "sin" ||
            buttonText == "ln" ||
            buttonText == "tan" ||
            buttonText == "cos") {
          equation = equation + buttonText + "(";
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, int heightButton, Color colorButton) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * heightButton,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: const Color.fromARGB(31, 67, 65, 65), width: 2),
      ),
      child: TextButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: (buttonText == "C") ? Colors.red[400] : Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: Text('MyCalc'),
          ),
          body: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text(
                      equation,
                      style: TextStyle(
                          fontSize: equationFont, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text(
                      result,
                      style:
                          TextStyle(fontSize: resultFont, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Divider(
                    color: Colors.black,
                    height: 2.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("ln", 1, buttonColor),
                          buildButton("tan", 1, buttonColor),
                          buildButton("sin", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("C", 1, CbuttonColor),
                          buildButton("(", 1, buttonColor),
                          buildButton(")", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("7", 1, buttonColor),
                          buildButton("8", 1, buttonColor),
                          buildButton("9", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("4", 1, buttonColor),
                          buildButton("5", 1, buttonColor),
                          buildButton("6", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("1", 1, buttonColor),
                          buildButton("2", 1, buttonColor),
                          buildButton("3", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("0", 1, buttonColor),
                          buildButton("00", 1, buttonColor),
                          buildButton(".", 1, buttonColor),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("cos", 1, buttonColor),
                        ]),
                        TableRow(children: [
                          buildButton("/", 1, funcColor),
                        ]),
                        TableRow(children: [
                          buildButton("*", 1, funcColor),
                        ]),
                        TableRow(children: [
                          buildButton("-", 1, funcColor),
                        ]),
                        TableRow(children: [
                          buildButton("+", 1, funcColor),
                        ]),
                        TableRow(children: [
                          buildButton("=", 1, resultColor),
                        ]),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
