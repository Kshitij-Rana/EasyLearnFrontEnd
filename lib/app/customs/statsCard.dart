import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;
  const StatsCard(
      {super.key,
      required this.label,
      required this.value,
      this.icon,
      this.isAmount = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          color: Colors.black12,
          offset: Offset(1, 1),
        )
      ], color: color ?? Colors.blue.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              icon ?? const SizedBox.shrink(),
            ],
          )
        ],
      ),
    );
  }
}
