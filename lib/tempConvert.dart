import 'package:flutter/material.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/units_converter.dart';
import 'package:flutter/services.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  late TextEditingController _inputController;
  late ConversionNode<String> _conversionTree;
  final List<String> _units = [
    'Millimeter (mm)',
    'Centimeter (cm)',
    'Meter (m)',
    'Kilometer (km)',
    'Inch (in)',
    'Foot (ft)',
    'Yard (yd)',
    'Mile (mi)',
    'Nautical Mile (NM)',
    'Mils (mil)',
  ];
  String _fromUnit = 'Millimeter (mm)';
  String _toUnit = 'Centimeter (cm)';
  double _result = 0;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _conversionTree = ConversionNode(
      name: 'Length',
      leafNodes: [
        ConversionNode(
          name: 'Millimeter (mm)',
          coefficientProduct: 1000,
        ),
        ConversionNode(
          name: 'Centimeter (cm)',
          coefficientProduct: 100,
        ),
        ConversionNode(
          name: 'Meter (m)',
          coefficientProduct: 1,
        ),
        ConversionNode(
          name: 'Kilometer (km)',
          coefficientProduct: 0.001,
        ),
        ConversionNode(
          name: 'Inch (in)',
          coefficientProduct: 39.37,
        ),
        ConversionNode(
          name: 'Foot (ft)',
          coefficientProduct: 3.28,
        ),
        ConversionNode(
          name: 'Yard (yd)',
          coefficientProduct: 1.09,
        ),
        ConversionNode(
          name: 'Mile (mi)',
          coefficientProduct: 0.000621371,
        ),
        ConversionNode(
          name: 'Nautical Mile (NM)',
          coefficientProduct: 0.000539957,
        ),
        ConversionNode(
          name: 'Mils (mil)',
          coefficientProduct: 39370.1,
        ),
      ],
    );
    _inputController.addListener(_convert);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    final inputText = _inputController.text;
    if (inputText.isNotEmpty) {
      final double inputValue = double.parse(inputText);
      final CustomProperty converter = CustomProperty(
        conversionTree: _conversionTree,
        name: 'Length Converter',
      );

      converter.convert(_fromUnit, inputValue);
      final Unit convertedUnit = converter.getUnit(_toUnit);
      setState(() {
        _result = convertedUnit.value!;
      });
    } else {
      setState(() {
        _result = 0;
      });
    }
  }

  void _swapUnits() {
    setState(() {
      final String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
    _convert();
  }

  void _copyTextToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        actions: [
          IconButton(
            onPressed: () {
              final double inputValue =
                  double.tryParse(_inputController.text) ?? 0;

              if (inputValue == 0) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Value Required'),
                    content: const Text('Please enter a value.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                return;
              }

              final CustomProperty converter = CustomProperty(
                conversionTree: _conversionTree,
                name: 'Length Converter',
              );

              converter.convert(_fromUnit, inputValue);
              final List<String> convertedValues = _units.map((unit) {
                final Unit convertedUnit = converter.getUnit(unit);
                final convertedValue = convertedUnit.value?.toStringAsFixed(4);
                return '$unit: $convertedValue';
              }).toList();

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: const [
                        Text('Converted Values'),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: convertedValues.map((value) {
                          final convertedValue =
                              value.substring(value.indexOf(':') + 2);
                          return Row(
                            children: [
                              Expanded(
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: () {
                                  _copyTextToClipboard(convertedValue);
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.calculate),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a value',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _fromUnit,
              items: _units.map((unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (selectedUnit) {
                setState(() {
                  _fromUnit = selectedUnit!;
                });
                _convert();
              },
              decoration: const InputDecoration(
                labelText: 'From',
              ),
            ),
            const SizedBox(height: 16),
            IconButton(
              onPressed: _swapUnits,
              icon: const Icon(Icons.swap_horiz),
            ),
            DropdownButtonFormField<String>(
              value: _toUnit,
              items: _units.map((unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (selectedUnit) {
                setState(() {
                  _toUnit = selectedUnit!;
                });
                _convert();
              },
              decoration: const InputDecoration(
                labelText: 'To',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
