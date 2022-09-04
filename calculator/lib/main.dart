import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Calculator(title: 'Calculator'),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _formula = "";
  String _numText = "0";
  String _operator = "";
  String _result = "";
  int _num = 0;

  void _clear() {
    _formula = "";
    _numText = "0";
    _num = 0;
    _operator = "";
    _result = "";
  }

  void _numeric(String text) {
    setState(() {
      if (_numText == "0") {
        _numText = "";
      }
      _numText = _numText + text;
      _result = _numText;
    });
  }

  int _calculate(String operator, int num1, int num2) {
    int num = 0;
    if (operator == "+") {
      num = num1 + num2;
    } else if (operator == "-") {
      num = num1 - num2;
    } else if (operator == "x") {
      num = num1 * num2;
    } else if (operator == "/") {
      num = num1 ~/ num2;
    }
    return num;
  }

  void _parse(String text) {
    setState(() {
      if (text == "=") {
        _formula += _numText + "=";
        _num = _calculate(_operator, _num, int.parse(_numText));
        _numText = _num.toString();
        _result = _num.toString();
      } else if (text == "C") {
        _clear();
      } else {
        _formula = _numText + text;
        _num = int.parse(_numText);
        _numText = "0";
        _operator = text;
        _result = "";
      }
    });
  }

  Widget _buildNumButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _numeric(text),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.black38,
            onPrimary: Colors.black87,
            minimumSize: const Size(double.infinity, double.infinity)),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _parse(text),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.black45,
            onPrimary: Colors.black87,
            minimumSize: const Size(double.infinity, double.infinity)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$_formula',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$_result',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  _buildNumButton('9'),
                  _buildNumButton('8'),
                  _buildNumButton('7'),
                  _buildOperatorButton('+'),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  _buildNumButton('4'),
                  _buildNumButton('5'),
                  _buildNumButton('6'),
                  _buildOperatorButton('-'),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  _buildNumButton('1'),
                  _buildNumButton('2'),
                  _buildNumButton('3'),
                  _buildOperatorButton('x'),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  _buildOperatorButton('C'),
                  _buildNumButton('0'),
                  _buildOperatorButton('='),
                  _buildOperatorButton('/'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
