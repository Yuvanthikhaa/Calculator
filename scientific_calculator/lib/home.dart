import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String equation = '0';
  String result = '0';
  String expression = '';
  double doubleres = 0;
  int intres = 0;

  calculation (String btntext) {
    setState(() {
      if (btntext == '⌥') {
        Navigator.pushNamed(context, '/scical');
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      }
      else if (btntext == '⌫') {
        equation = equation.substring(0, equation.length-1);
        if (equation == '') {
          equation = '0';
        }
      }
      else if (btntext == 'C') {
        equation = '0';
        result = '0';
      }
      else if (btntext == '=') {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          doubleres = double.parse(result);
          if (doubleres%1==0) {
            intres = doubleres.toInt();
            result = intres.toString();
          }
        }
        catch(e) {
          result = 'Error';
        }
      }
      else {
        if (equation == '0') {
          equation = btntext;
        }
        else {
          equation = equation + btntext;
        }
      }
    });
  }

  Widget calcbtns(String btntext, Color btncolor, Color textcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntext);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: btncolor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(15.0)
        ),
        child: Text(btntext,
          style: TextStyle(
            fontSize: 35,
            color: textcolor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(equation,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                        fontSize: 40
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(result,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,
                      fontSize: 70
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: calcbtns('⌥', Colors.grey.shade900, Colors.yellow.shade600),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: calcbtns('⌫', Colors.grey.shade900, Colors.yellow.shade600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbtns('C', Colors.grey, Colors.yellow.shade600),
                calcbtns('(', Colors.grey, Colors.black),
                calcbtns(')', Colors.grey, Colors.black),
                calcbtns('÷', Colors.yellow.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbtns('7', Colors.grey.shade700, Colors.white),
                calcbtns('8', Colors.grey.shade700, Colors.white),
                calcbtns('9', Colors.grey.shade700, Colors.white),
                calcbtns('×', Colors.yellow.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbtns('4', Colors.grey.shade700, Colors.white),
                calcbtns('5', Colors.grey.shade700, Colors.white),
                calcbtns('6', Colors.grey.shade700, Colors.white),
                calcbtns('-', Colors.yellow.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbtns('1', Colors.grey.shade700, Colors.white),
                calcbtns('2', Colors.grey.shade700, Colors.white),
                calcbtns('3', Colors.grey.shade700, Colors.white),
                calcbtns('+', Colors.yellow.shade700, Colors.white),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbtns('%', Colors.grey, Colors.black),
                calcbtns('0', Colors.grey.shade700, Colors.white),
                calcbtns('.', Colors.grey, Colors.black),
                calcbtns('=', Colors.yellow.shade700, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
