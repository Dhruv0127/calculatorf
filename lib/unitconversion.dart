// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyConvert extends StatefulWidget {
  const MyConvert({Key? key}) : super(key: key);

  @override
  State<MyConvert> createState() => _MyConvertState();
}

class _MyConvertState extends State<MyConvert> {
  double answer = 1;
  late double user_input;

  double convertValue() {
    // Conversion logic
    double result = 1;
    if (_start_measure == 'Millimeters' && _end_measure == 'Millimeters') {
      result = user_input * 1;
    } else if (_start_measure == 'Millimeters' &&
        _end_measure == 'Centimeters') {
      result = user_input * 0.1;
    } else if (_start_measure == 'Millimeters' && _end_measure == 'Meter') {
      result = user_input * 0.001;
    }
    // ... (remaining conversion cases)

    return result;
  }

  @override
  void initState() {
    user_input = 0;
    super.initState();
  }

  final List<String> measures = [
    "Millimeters",
    "Centimeters",
    "Meter",
    "Kilometer",
    "Inch",
    "Feet",
    "Yards",
    "Miles",
  ];

  String _start_measure = "Feet";
  String _end_measure = "Inch";
  double kilometer_to_meter = 1000;
  double meter_to_inch = 39.3701;
  double result = 1;

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

                      // ---- mm ----

                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 0.1;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.001;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.000001;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Inch') {
                        result = user_input * 0.0393700787;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Feet') {
                        result = user_input * 0.0032808399;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.0010936133;
                      } else if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Miles') {
                        result = user_input * 6.2137E-7;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 10;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.01;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.00001;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Inch') {
                        result = user_input * 0.3937007874;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Feet') {
                        result = user_input * 0.032808399;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.010936133;
                      } else if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1000;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 100;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Meter') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.001;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Inch') {
                        result = user_input * 39.3700787402;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Feet') {
                        result = user_input * 3.280839895;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1.0936132983;
                      } else if (_start_measure == 'Meter' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0006213712;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1000000;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 100000;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Meter') {
                        result = user_input * 1000;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Inch') {
                        result = user_input * 39370.078740157;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Feet') {
                        result = user_input * 3280.8398950131;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1093.6132953377;
                      } else if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.6213711922;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 25.4;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 2.54;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.0254;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.0000254;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Inch') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Feet') {
                        result = user_input * 0.0833333333;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.0277777778;
                      } else if (_start_measure == 'Inch' &&
                          _end_measure == 'Miles') {
                        result = user_input * 1.5783E-5;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 304.8;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 30.48;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.3048;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.0003048;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Inch') {
                        result = user_input * 12;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Feet') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.3333333333;
                      } else if (_start_measure == 'Feet' &&
                          _end_measure == 'Miles') {
                        result = user_input * 1.8939E-4;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 914.4;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 91.44;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.9144;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.0009144;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Inch') {
                        result = user_input * 36;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Feet') {
                        result = user_input * 3;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1;
                      } else if (_start_measure == 'Yards' &&
                          _end_measure == 'Miles') {
                        result = user_input * 5.6818E-4;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1609344;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 160934.4;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Meter') {
                        result = user_input * 1609.344;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 1.609344;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Inch') {
                        result = user_input * 63360;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Feet') {
                        result = user_input * 5280;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1760;
                      } else if (_start_measure == 'Miles' &&
                          _end_measure == 'Miles') {
                        result = user_input * 1;
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
