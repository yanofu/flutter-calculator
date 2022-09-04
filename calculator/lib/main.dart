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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

  void _numeric(String text){
    setState(() {
      if(_numText == "0"){
        _numText = "";
      }
      _numText = _numText + text;
      _result = _numText;
    });
  }

  int _calculate(String operator, int num1, int num2) {
    int num = 0;
    if(operator == "+") {
      num = num1 + num2;
    }
    else if(operator == "-") {
      num = num1 - num2;
    }
    else if(operator == "x") {
      num = num1 * num2;
    }
    else if(operator == "/") {
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
      }
      else if(text == "C") {
        _clear();
      }
      else {
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
        child: Text(text),
      ),
    );
  }

  Widget _buildOperatorButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _parse(text),
        child: Text(text),
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
            Text(
              '$_formula',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              children: <Widget>[
                _buildNumButton('9'),
                _buildNumButton('8'),
                _buildNumButton('7'),
                _buildOperatorButton('+'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildNumButton('4'),
                _buildNumButton('5'),
                _buildNumButton('6'),
                _buildOperatorButton('-'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildNumButton('1'),
                _buildNumButton('2'),
                _buildNumButton('3'),
                _buildOperatorButton('x'),
              ],
            ),
            Row(
              children: <Widget>[
                _buildOperatorButton('C'),
                _buildNumButton('0'),
                _buildOperatorButton('='),
                _buildOperatorButton('/'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
