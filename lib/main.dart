// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:math_expressions/math_expressions.dart';
// import 'historypage.dart';
// import 'tempConvert.dart';

// void main() async {
//   await Hive.initFlutter();
//   await Hive.openBox('history');
//   runApp(
//     ChangeNotifierProvider<ThemeProvider>(
//       create: (_) => ThemeProvider(),
//       child: const CalculatorApp(),
//     ),
//   );
// }

// class ThemeProvider with ChangeNotifier {
//   bool _isDarkMode = false;

//   bool get isDarkMode => _isDarkMode;

//   void toggleTheme() {
//     _isDarkMode = !_isDarkMode;
//     notifyListeners();
//   }
// }

// class CalculatorApp extends StatelessWidget {
//   const CalculatorApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeNotifier, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Calculator',
//           theme: themeNotifier.isDarkMode
//               ? ThemeData.dark(useMaterial3: true)
//               : ThemeData.light(useMaterial3: true),
//           home: const CalculatorScreen(),
//         );
//       },
//     );
//   }
// }

// class CalculatorScreen extends StatefulWidget {
//   const CalculatorScreen({Key? key}) : super(key: key);

//   @override
//   _CalculatorScreenState createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {
//   String _output = '';
//   String _equation = '';
//   double _result = 0.0;

//   void _buttonPressed(String buttonText) {
//     setState(() {
//       if (buttonText == 'C') {
//         _output = '';
//         _equation = '';
//         _result = 0.0;
//       } else if (buttonText == '=') {
//         _equation += buttonText;
//         _result = _computeResult();
//         _output = _result.toString();
//         _saveToHistory(_equation, _output);
//         _equation = '';
//       } else if (buttonText == '⌫') {
//         if (_equation.isNotEmpty) {
//           _equation = _equation.substring(0, _equation.length - 1);
//           _result = _computeResult();
//           _output = _result.toString();
//         }
//       } else {
//         _equation += buttonText;
//         _result = _computeResult();
//         _output = _result.toString();
//       }
//     });
//   }

//   double _computeResult() {
//     String equation = _equation;
//     equation = equation.replaceAll('=', '');
//     try {
//       Parser p = Parser();
//       Expression exp = p.parse(equation);
//       ContextModel cm = ContextModel();
//       return exp.evaluate(EvaluationType.REAL, cm);
//     } catch (e) {
//       return 0.0;
//     }
//   }

//   void _saveToHistory(String equation, String result) {
//     final box = Hive.box('history');
//     final historyItem = "$equation $result";
//     box.add(historyItem);
//   }

//   Widget _buildButton(String buttonText, Color buttonColor, Color textColor) {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: MaterialButton(
//           onPressed: () => _buttonPressed(buttonText),
//           padding: const EdgeInsets.all(24.0),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16.0)),
//           ),
//           color: buttonColor,
//           textColor: textColor,
//           child: Text(
//             buttonText,
//             style: const TextStyle(fontSize: 20.0),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calculator'),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               if (value == 'Toggle Theme') {
//                 themeNotifier.toggleTheme();
//               } else if (value == 'Show History') {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HistoryPage()),
//                 );
//               } else if (value == 'Unit Conversion') {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ConverterPage()),
//                 );
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'Toggle Theme',
//                 child: Text('Toggle Theme'),
//               ),
//               const PopupMenuItem(
//                 value: 'Show History',
//                 child: Text('Show History'),
//               ),
//               const PopupMenuItem(
//                 value: 'Unit Conversion',
//                 child: Text('Unit Conversion'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
//             child: Text(
//               _equation,
//               style: const TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               curve: Curves.easeInOut,
//               transform: Matrix4.identity()..scale(1.2),
//               child: Text(
//                 _output,
//                 style: const TextStyle(
//                   fontSize: 48.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Divider(),
//                 Row(
//                   children: [
//                     _buildButton('7', Colors.grey[300]!, Colors.black),
//                     _buildButton('8', Colors.grey[300]!, Colors.black),
//                     _buildButton('9', Colors.grey[300]!, Colors.black),
//                     _buildButton('/', Colors.orange, Colors.white),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     _buildButton('4', Colors.grey[300]!, Colors.black),
//                     _buildButton('5', Colors.grey[300]!, Colors.black),
//                     _buildButton('6', Colors.grey[300]!, Colors.black),
//                     _buildButton('*', Colors.orange, Colors.white),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     _buildButton('1', Colors.grey[300]!, Colors.black),
//                     _buildButton('2', Colors.grey[300]!, Colors.black),
//                     _buildButton('3', Colors.grey[300]!, Colors.black),
//                     _buildButton('-', Colors.orange, Colors.white),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     _buildButton('.', Colors.grey[300]!, Colors.black),
//                     _buildButton('0', Colors.grey[300]!, Colors.black),
//                     _buildButton('00', Colors.grey[300]!, Colors.black),
//                     _buildButton('+', Colors.orange, Colors.white),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     _buildButton('C', Colors.red, Colors.white),
//                     _buildButton('⌫', Colors.red, Colors.white),
//                     _buildButton('=', Colors.blue, Colors.white),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:math_expressions/math_expressions.dart';
import 'direction.dart';
import 'historypage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('history');
  runApp(
    const CalculatorApp(),
  );
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          title: 'Calculator',
          home: const CalculatorScreen(),
        );
      },
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '';
  String _equation = '';
  double _result = 0.0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _equation = '';
        _result = 0.0;
      } else if (buttonText == '=') {
        _equation += buttonText;
        _result = _computeResult();
        _output = _result.toString();
        _saveToHistory(_equation, _output);
        _equation = '';
      } else if (buttonText == '⌫') {
        if (_equation.isNotEmpty) {
          _equation = _equation.substring(0, _equation.length - 1);
          _result = _computeResult();
          _output = _result.toString();
        }
      } else {
        _equation += buttonText;
        _result = _computeResult();
        _output = _result.toString();
      }
    });
  }

  double _computeResult() {
    String equation = _equation;
    equation = equation.replaceAll('=', '');
    try {
      Parser p = Parser();
      Expression exp = p.parse(equation);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return 0.0;
    }
  }

  void _saveToHistory(String equation, String result) {
    final box = Hive.box('history');
    final historyItem = "$equation $result";
    box.add(historyItem);
  }

  Widget _buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: MaterialButton(
          onPressed: () => _buttonPressed(buttonText),
          padding: const EdgeInsets.all(24.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          color: buttonColor,
          textColor: textColor,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Basic Calculator'),
              Tab(text: 'Unit Conversion'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                  child: Text(
                    _equation,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    transform: Matrix4.identity()..scale(1.2),
                    child: Text(
                      _output,
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(),
                      Row(
                        children: [
                          _buildButton('7', Colors.grey[300]!, Colors.black),
                          _buildButton('8', Colors.grey[300]!, Colors.black),
                          _buildButton('9', Colors.grey[300]!, Colors.black),
                          _buildButton('/', Colors.orange, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          _buildButton('4', Colors.grey[300]!, Colors.black),
                          _buildButton('5', Colors.grey[300]!, Colors.black),
                          _buildButton('6', Colors.grey[300]!, Colors.black),
                          _buildButton('*', Colors.orange, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          _buildButton('1', Colors.grey[300]!, Colors.black),
                          _buildButton('2', Colors.grey[300]!, Colors.black),
                          _buildButton('3', Colors.grey[300]!, Colors.black),
                          _buildButton('-', Colors.orange, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          _buildButton('.', Colors.grey[300]!, Colors.black),
                          _buildButton('0', Colors.grey[300]!, Colors.black),
                          _buildButton('00', Colors.grey[300]!, Colors.black),
                          _buildButton('+', Colors.orange, Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          _buildButton('C', Colors.red, Colors.white),
                          _buildButton('⌫', Colors.red, Colors.white),
                          _buildButton('=', Colors.blue, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const DivertingScreen(),
            const HistoryPage(),
          ],
        ),
      ),
    );
  }
}
