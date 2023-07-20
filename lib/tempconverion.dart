// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyConvert2 extends StatefulWidget {
  const MyConvert2({Key? key}) : super(key: key);

  @override
  State<MyConvert2> createState() => _MyConvert2State();
}

class _MyConvert2State extends State<MyConvert2> {
  String _start_measure = "Kelvin";
  String _end_measure = "Kelvin";
  double result = 0;
  double answer = 1;
  late double user_input;

  @override
  void initState() {
    user_input = 0;
    super.initState();
  }

  final List<String> measures = [
    "Fahrenheit",
    "Celsius",
    "Kelvin",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.background1,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: const Text(
          "Converter",
          style: TextStyle(
              // color: Colors.white
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //first - - - drop - - - menu
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: MyColors.background3
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text(
                        "Choose the unit",
                        style: TextStyle(color: Colors.black),
                      ),
                      // dropdownColor: MyColors.background2,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      value: _start_measure,
                      items: measures
                          .map((item) => DropdownMenuItem<String>(
                              value: item, child: Text(item)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _start_measure = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: const Text(
                    "To",
                    style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //second - - - drop - - - menu
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: MyColors.background3
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text(
                        "Choose the unit",
                        style: TextStyle(color: Colors.black),
                      ),
                      // dropdownColor: MyColors.background2,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      value: _end_measure,
                      items: measures
                          .map((item) => DropdownMenuItem<String>(
                              value: item, child: Text(item)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _end_measure = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            //text --- field ---
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
                // color: MyColors.background2,
              ),
              margin: const EdgeInsets.all(15),
              height: 60,
              width: 400,
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter the amount"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  var input = double.tryParse(value);
                  if (input != null) {
                    setState(() {
                      user_input = input;

                      if (_start_measure == 'Celsius' &&
                          _end_measure == 'Celsius') {
                        result = user_input;
                      } else if (_start_measure == 'Celsius' &&
                          _end_measure == 'Fahrenheit') {
                        result = (user_input * 9 / 5) + 32;
                      } else if (_start_measure == 'Celsius' &&
                          _end_measure == 'Kelvin') {
                        result = user_input + 273.15;
                      } else if (_start_measure == 'Fahrenheit' &&
                          _end_measure == 'Celsius') {
                        result = (user_input - 32) * 5 / 9;
                      } else if (_start_measure == 'Fahrenheit' &&
                          _end_measure == 'Fahrenheit') {
                        result = user_input;
                      } else if (_start_measure == 'Fahrenheit' &&
                          _end_measure == 'Kelvin') {
                        result = (user_input + 459.67) * 5 / 9;
                      } else if (_start_measure == 'Kelvin' &&
                          _end_measure == 'Celsius') {
                        result = user_input - 273.15;
                      } else if (_start_measure == 'Kelvin' &&
                          _end_measure == 'Fahrenheit') {
                        result = user_input * 9 / 5 - 459.67;
                      } else if (_start_measure == 'Kelvin' &&
                          _end_measure == 'Kelvin') {
                        result = user_input;
                      }
                    });
                  }
                },
              ),
            ),
            // convert --- button ---

            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 17),
              alignment: Alignment.centerLeft,
              child: Text(
                "RESULT : $user_input $_start_measure = ${result.toStringAsFixed(4)} $_end_measure",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
