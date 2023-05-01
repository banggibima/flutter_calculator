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
        case "\u{0025}":
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Not implemented yet'),
            ),
          );
          break;
        case "\u{003D}":
          if (equation == "0") {
            equation = textButton;
          } else if (equation == "00") {
            equation = textButton;
          } else if (equation == ".") {
            equation = textButton;
          } else {
            expression = equation;
            expression = expression.replaceAll('\u{002B}', '+');
            expression = expression.replaceAll('\u{2212}', '-');
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
      body: Container(
        color: Color(0xFF22252D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF292C36),
                borderRadius: BorderRadius.circular(17.5),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 140.0,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.sun_max,
                    color: Color(0xFF7C7E83),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    CupertinoIcons.moon,
                    color: Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 110.0,
            ),
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
                      fontSize: 25.0,
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
                      fontSize: 50.0,
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
                color: Color(0xFF292C36),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: 480.0,
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
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        numberButton(
                          "AC",
                          Color(0xFF26F8D2),
                          Color(0xFF272B33),
                          20.0,
                        ),
                        numberButton(
                          "C",
                          Color(0xFF26F8D2),
                          Color(0xFF272B33),
                          20.0,
                        ),
                        operatorButton(
                          CupertinoIcons.percent,
                          Color(0xFF26F8D2),
                          Color(0xFF272B33),
                          30.0,
                          "\u{0025}",
                        ),
                        operatorButton(
                          CupertinoIcons.divide,
                          Color(0xFFEB6666),
                          Color(0xFF272B33),
                          30.0,
                          "\u{00F7}",
                        ),
                        numberButton(
                          "7",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "8",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "9",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        operatorButton(
                          CupertinoIcons.multiply,
                          Color(0xFFEB6666),
                          Color(0xFF272B33),
                          30.0,
                          "\u{00D7}",
                        ),
                        numberButton(
                          "4",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "5",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "6",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        operatorButton(
                          CupertinoIcons.minus,
                          Color(0xFFEB6666),
                          Color(0xFF272B33),
                          30.0,
                          "\u{2212}",
                        ),
                        numberButton(
                          "1",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "2",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "3",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        operatorButton(
                          CupertinoIcons.plus,
                          Color(0xFFEB6666),
                          Color(0xFF272B33),
                          30.0,
                          "\u{002B}",
                        ),
                        numberButton(
                          '.',
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "0",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        numberButton(
                          "00",
                          Color(0xFFFFFFFF),
                          Color(0xFF272B33),
                          24.0,
                        ),
                        operatorButton(
                          CupertinoIcons.equal,
                          Color(0xFFEB6666),
                          Color(0xFF272B33),
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
    Color decorationColor,
    double textSize,
  ) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: decorationColor,
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
    Color decorationColor,
    double iconSize,
    String iconValue,
  ) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: decorationColor,
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
