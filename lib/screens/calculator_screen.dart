import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:math_expressions/math_expressions.dart";

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";

  void calculation(textButton) {
    setState(() {
      switch (textButton) {
        case "AC":
          equation = "";
          result = "0";
          break;
        case "C":
          if (equation == "") {
            equation = "";
          } else {
            equation = equation.substring(0, equation.length - 1);
          }
          break;
        case "\u{00B1}":
          print("feature is not yet available");
          break;
        case ".":
          print("feature is not yet available");
          break;
        case "\u{003D}":
          if (equation == "0") {
            equation = textButton;
          } else if (equation == "00") {
            equation = textButton;
          } else {
            expression = equation;
            expression = expression.replaceAll('\u{00D7}', '*');
            expression = expression.replaceAll('\u{00F7}', '/');
            try {
              Parser p = Parser();
              Expression exp = p.parse(expression);
              ContextModel cm = ContextModel();
              result = '${exp.evaluate(EvaluationType.REAL, cm).round()}';
            } catch (err) {
              result = err.toString();
            }
          }
          break;
        default:
          equation = equation + textButton;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22252D),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${equation}',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20.0,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 5.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${result}',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 45.0,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4.0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 30.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF2C2F3A),
                borderRadius: BorderRadius.circular(40.0),
              ),
              height: 460.0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 75.0,
                        childAspectRatio: 4.0 / 4.0,
                        crossAxisSpacing: 17.5,
                        mainAxisSpacing: 17.5,
                      ),
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        numberButton("AC", Colors.teal.shade300, 20.0),
                        numberButton("C", Colors.teal.shade300, 20.0),
                        operatorButton(
                          CupertinoIcons.plus_slash_minus,
                          Colors.teal.shade300,
                          30.0,
                          "\u{00B1}",
                        ),
                        operatorButton(
                          CupertinoIcons.divide,
                          Colors.red.shade300,
                          30.0,
                          "\u{00F7}",
                        ),
                        numberButton("7", Colors.white, 20.0),
                        numberButton("8", Colors.white, 20.0),
                        numberButton("9", Colors.white, 20.0),
                        operatorButton(
                          CupertinoIcons.multiply,
                          Colors.red.shade300,
                          30.0,
                          "\u{00D7}",
                        ),
                        numberButton("4", Colors.white, 20.0),
                        numberButton("5", Colors.white, 20.0),
                        numberButton("6", Colors.white, 20.0),
                        operatorButton(
                          CupertinoIcons.minus,
                          Colors.red.shade300,
                          30.0,
                          "\u{2212}",
                        ),
                        numberButton("1", Colors.white, 20.0),
                        numberButton("2", Colors.white, 20.0),
                        numberButton("3", Colors.white, 20.0),
                        operatorButton(
                          CupertinoIcons.plus,
                          Colors.red.shade300,
                          30.0,
                          "\u{002B}",
                        ),
                        numberButton(".", Colors.white, 20.0),
                        numberButton("0", Colors.white, 20.0),
                        numberButton("00", Colors.white, 20.0),
                        operatorButton(
                          CupertinoIcons.equal,
                          Colors.red.shade300,
                          30.0,
                          "\u{003D}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget numberButton(
    String textButton,
    Color textColor,
    double textSize,
  ) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF272B33),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          textButton,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
      ),
      onTap: () {
        calculation(textButton);
      },
    );
  }

  Widget operatorButton(
    IconData iconButton,
    Color iconColor,
    double iconSize,
    String iconValue,
  ) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF272B33),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          iconButton,
          color: iconColor,
          size: iconSize,
        ),
      ),
      onTap: () {
        calculation(iconValue);
      },
    );
  }
}
