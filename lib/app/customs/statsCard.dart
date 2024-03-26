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
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0.5,
              color: Colors.black12,
              offset: Offset(0, 2),
            ),
          ],
          color: color ?? Colors.blue.shade100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff140F1A)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 20, color: Color(0xff140F1A)),
              ),
              const SizedBox(
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
