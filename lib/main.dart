/// Name:Andrew Naseif
/// project Calculator
/// Version 1.0

import 'package:flutter/material.dart';

dynamic text = '0';
double firstNum = 0;
double secondNum = 0;
dynamic result = '';
dynamic finalResult = '';
dynamic operator = '';
dynamic preOperator = '';

void main() {
  runApp(MyApp());
}
//Build the state less widget for app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}
//build the calculator
class _CalculatorState extends State<Calculator> {
  dynamic displayText = 20;

  //Button Widget for Zero only
  Widget button0() {
    return Container(
      width: 196,
      height: 80.0,
      child: RaisedButton(
        onPressed: () {
          calculate('0');
          setState(() {
            text = result;
          });
        },
        child: Text(
          '0',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }
  //Button Widget for all elements
  Widget button(String text, Color buttonColor, Color TextColor) {
    return Container(
      height: 80,
      width: 97,
      child: RaisedButton(
        onPressed: () {
          calculate(text);
        },
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: 35,
            color: TextColor,
          ),
        ),
        color: buttonColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      //the app bar of the app
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blue,
        toolbarHeight: 80,
      ),
      //build the calculator elements using Container, row and columns
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$text',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 100,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('AC', Colors.blue, Colors.white),
              button('+/-', Colors.blue, Colors.white),
              button('%', Colors.blue, Colors.white),
              button('/', Colors.blue, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('7', Colors.white, Colors.black87),
              button('8', Colors.white, Colors.black87),
              button('9', Colors.white, Colors.black87),
              button('x', Colors.blue, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('4', Colors.white, Colors.black87),
              button('5', Colors.white, Colors.black87),
              button('6', Colors.white, Colors.black87),
              button('-', Colors.blue, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('1', Colors.white, Colors.black87),
              button('2', Colors.white, Colors.black87),
              button('3', Colors.white, Colors.black87),
              button('+', Colors.blue, Colors.white),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              button('=', Colors.blue, Colors.white),
              button('.', Colors.white, Colors.black87),
              button0(),
            ],
          ),
        ],
      ),
    );
  }
  //function to calculate the result of clicked buttons
  void calculate(displayText) {
    if (displayText == 'AC') {
      text = '0';
      firstNum = 0;
      secondNum = 0;
      result = '';
      finalResult = '0';
      operator = '';
      preOperator = '';
    } else if (operator == '=' && displayText == '=') {
      if (preOperator == '+') {
        finalResult = add();
      } else if (preOperator == '-') {
        finalResult = subtract();
      } else if (preOperator == 'x') {
        finalResult = multiply();
      } else if (preOperator == '/') {
        finalResult = diveded();
      }
    } else if (displayText == '+' ||
        displayText == '-' ||
        displayText == 'x' ||
        displayText == '/' ||
        displayText == '=') {
      if (firstNum == 0) {
        firstNum = double.parse(result);
      } else {
        secondNum = double.parse(result);
      }

      if (operator == '+') {
        finalResult = add();
      } else if (operator == '-') {
        finalResult = subtract();
      } else if (operator == 'x') {
        finalResult = multiply();
      } else if (operator == '/') {
        finalResult = diveded();
      }
      preOperator = operator;
      operator = displayText;
      result = '';
    } else if (displayText == '%') {
      result = firstNum / 100;
      finalResult = ContainsDecimal(result);
    } else if (displayText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (displayText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + displayText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }
//add two nums
  String add() {
    result = (firstNum + secondNum).toString();
    firstNum = double.parse(result);
    return ContainsDecimal(result);
  }
//subtract to nums
  String subtract() {
    result = (firstNum - secondNum).toString();
    firstNum = double.parse(result);
    return ContainsDecimal(result);
  }
//multiply to nums
  String multiply() {
    result = (firstNum * secondNum).toString();
    firstNum = double.parse(result);
    return ContainsDecimal(result);
  }
//divide to nums
  String diveded() {
    result = (firstNum / secondNum).toString();
    firstNum = double.parse(result);
    return ContainsDecimal(result);
  }
//handle the nums after .
  String ContainsDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
