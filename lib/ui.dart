import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class myUI extends StatefulWidget {
  const myUI({Key? key}) : super(key: key);

  @override
  State<myUI> createState() => _myUIState();
}

class _myUIState extends State<myUI> {
  String result = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) => {_deleteNumber()},
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                _format(result),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: result.length > 5 ? 60 : 100,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: _buttonGrid(),
          )
        ],
      )),
    );
  }

  _deleteNumber() {
    setState(() {
      if (result.length > 1) {
        result = result.substring(0, result.length - 1);
        newNum = result;
      } else {
        result = '0';
        newNum = '';
      }
    });
  }

  String _format(String num) {
    var formatter = NumberFormat("###,###.##", "en_US");
    return formatter.format(stringToDouble(num));
  }

  String newNum = "";
  String oldNum = "";
  String operation = "";

  _operations(value) {
    setState(() {
      switch (value) {
        case "+":
        case "-":
        case "x":
        case "÷":
          if (oldNum != '') {
          } else {
            oldNum = newNum;
          }
          newNum = '';
          operation = value;
          break;
        case '+/-':
          newNum = stringToDouble(newNum) < 0
              ? newNum.replaceAll('-', '')
              : "-$newNum";
          result = newNum;
          break;
        case '%':
          newNum = (stringToDouble(newNum) / 100).toString();
          break;
        case '=':
          _calculation();
          oldNum = '';
          operation = '';
          break;
        case 'AC':
          result = '0';
          oldNum = '';
          newNum = '';
          operation = '';
          break;
        default:
          newNum = newNum + value;
          result = newNum;
      }
    });
  }

  void _calculation() {
    double _oldNum = stringToDouble(oldNum);
    double _newNum = stringToDouble(newNum);
    switch (operation) {
      case '+':
        _oldNum = _oldNum + _newNum;
        break;
      case '-':
        _oldNum = _oldNum - _newNum;
        break;
      case 'x':
        _oldNum = _oldNum * _newNum;
        break;
      case '÷':
        _oldNum = _oldNum / _newNum;
        break;
    }
    newNum = (_oldNum % 1 == 0 ? _oldNum.toInt() : _oldNum).toString();
    result = newNum;
  }

  double stringToDouble(String num) {
    return double.tryParse(num) ?? 0;
  }

  Widget _buttonGrid() {
    return Column(
      children: [
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton("AC", 0xffa5a5a5, 0xff000000),
            // Spacer(),
            calcButton("+/-", 0xffa5a5a5, 0xff000000),
            // Spacer(),
            calcButton("%", 0xffa5a5a5, 0xff000000),
            // Spacer(),
            calcButton("÷", 0xffff9e0b, 0xffffffff),
            // Spacer(),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            calcButton("7", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("8", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("9", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("x", 0xffff9e0b, 0xffffffff),
            // Spacer(),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Spacer(),
            calcButton("4", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("5", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("6", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("-", 0xffff9e0b, 0xffffffff),
            // Spacer(),
          ],
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Spacer(),
            calcButton("1", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("2", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("3", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("+", 0xffff9e0b, 0xffffffff),
            // Spacer(),
          ],
        ),
        Spacer(),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            calcButtonZero("0", 0xff333333, 0xffffffff),
            Spacer(),
            calcButton(".", 0xff333333, 0xffffffff),
            // Spacer(),
            calcButton("=", 0xffff9e0b, 0xffffffff),
            // Spacer(),
          ],
        ),
        Spacer(),
      ],
    );
  }

  Widget calcButton(
    value,
    bgColor,
    fgColor,
  ) {
    return MaterialButton(
      onPressed: () {
        _operations(value);
      },
      child: Text(
        "$value",
        style: TextStyle(color: Color(fgColor), fontSize: 25),
      ),
      shape: CircleBorder(),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
      color: Color(bgColor),
    );
  }

  Widget calcButtonZero(
    value,
    bgColor,
    fgColor,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.47,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          _operations(value);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "$value",
              style: TextStyle(color: Color(fgColor), fontSize: 25),
            ),
          ],
        ),
        color: Color(bgColor),
      ),
    );
  }
}