import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class CalculatingWidget extends StatelessWidget {
  const CalculatingWidget(this._isCalculating, {Key? key}) : super(key: key);

  final bool _isCalculating;

  @override
  Widget build(BuildContext context) {
    return _isCalculating ?
    DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black38,
        ),
        child: Center(
            child: CircularProgressIndicator()
        )
    )
        : const SizedBox.shrink();
  }
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
  bool _isCalculating = false;

  void _clear() {
    _formula = "";
    _numText = "0";
    _num = 0;
    _operator = "";
    _result = "";
  }

  void _numeric(String text) async {

    setState(() {
      _isCalculating = true;
    });

    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        if (_numText == "0") {
          _numText = "";
        }
        _numText = _numText + text;
        _result = _numText;
      });
    }).whenComplete(() {
      setState(() {
        _isCalculating = false;
      });
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
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FittedBox(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '$_result',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CalculatingWidget(_isCalculating),
                  ],
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
