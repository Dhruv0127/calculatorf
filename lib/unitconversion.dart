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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //first - - - drop - - - menu
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: MyColors.background3
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text(
                    "Choose the unit",
                    style: TextStyle(
                        // color: Colors.white
                        ),
                  ),
                  // dropdownColor: MyColors.background2,
                  style: const TextStyle(
                      // color: Colors.white
                      ),
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
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
              child: Text(
                "To",
                style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //second - - - drop - - - menu
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: MyColors.background3
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text(
                    "Choose the unit",
                    // style: TextStyle(color: Colors.white),
                  ),
                  // dropdownColor: MyColors.background2,
                  // style: const TextStyle(color: Colors.white),
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
            //text --- field ---
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: MyColors.background2,
              ),
              margin: const EdgeInsets.all(15),
              height: 60,
              width: 400,
              child: TextField(
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
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 0.1;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.001;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.000001;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Inch') {
                        result = user_input * 0.0393700787;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Feet') {
                        result = user_input * 0.0032808399;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.0010936133;
                      }
                      if (_start_measure == 'Millimeters' &&
                          _end_measure == 'Miles') {
                        result = user_input * 6.2137E-7;
                      }

                      //--cm------

                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 10;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Meter') {
                        result = user_input * 0.01;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.00001;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Inch') {
                        result = user_input * 0.3937007874;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Feet') {
                        result = user_input * 0.032808399;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Yards') {
                        result = user_input * 0.010936133;
                      }
                      if (_start_measure == 'Centimeters' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
                      }

                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1000;
                      }
                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 100;
                      }
                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Meter') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 0.001;
                      }
                      if (_start_measure == 'Meter' && _end_measure == 'Inch') {
                        result = user_input * 39.3700787402;
                      }
                      if (_start_measure == 'Meter' && _end_measure == 'Feet') {
                        result = user_input * 3.280839895;
                      }
                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1.0936132983;
                      }
                      if (_start_measure == 'Meter' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0006213712;
                      }

                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 1000000;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 100000;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Meter') {
                        result = user_input * 1000;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Inch') {
                        result = user_input * 39370.078740157;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Feet') {
                        result = user_input * 3280.8398950131;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Yards') {
                        result = user_input * 1093.6132953377;
                      }
                      if (_start_measure == 'Kilometer' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.6213711922;
                      }

                      if (_start_measure == 'Inch' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Inch' && _end_measure == 'Meter') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' && _end_measure == 'Inch') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' && _end_measure == 'Feet') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' && _end_measure == 'Yards') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Inch' && _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
                      }

                      if (_start_measure == 'Feet' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Feet' && _end_measure == 'Meter') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' && _end_measure == 'Inch') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' && _end_measure == 'Feet') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' && _end_measure == 'Yards') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Feet' && _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
                      }

                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Meter') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' && _end_measure == 'Inch') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' && _end_measure == 'Feet') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Yards') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Yards' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
                      }

                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Millimeters') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Centimeters') {
                        result = user_input * 1;
                      }
                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Meter') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Kilometer') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' && _end_measure == 'Inch') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' && _end_measure == 'Feet') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Yards') {
                        result = user_input * 2;
                      }
                      if (_start_measure == 'Miles' &&
                          _end_measure == 'Miles') {
                        result = user_input * 0.0000062137;
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
            Text(
              "$user_input $_start_measure = $result $_end_measure",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // color: Colors.white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
