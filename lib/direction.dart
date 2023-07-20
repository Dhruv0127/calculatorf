import 'package:calculatorf/tempconverion.dart';
import 'package:calculatorf/unitconversion.dart';
import 'package:flutter/material.dart';

class DivertingScreen extends StatelessWidget {
  const DivertingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          UnitConversionItem(
            iconData: Icons.device_thermostat_outlined,
            name: 'Temperature Conversion',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyConvert2()),
              );
            },
          ),
          UnitConversionItem(
            iconData: Icons.straighten,
            name: 'Length Conversion',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyConvert()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class UnitConversionItem extends StatelessWidget {
  final IconData iconData;
  final String name;
  final VoidCallback onTap;

  const UnitConversionItem({
    Key? key,
    required this.iconData,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: const Color.fromARGB(255, 223, 243, 231),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconData, size: 48),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
