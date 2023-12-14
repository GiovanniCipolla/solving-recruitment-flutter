import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/chart_bar.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({
    super.key,
    required this.a,
    required this.b,
    required this.c,
    required this.title,
  });

  final int a;
  final int b;
  final int c;
  final String title;

  double get maxTotalValue {
    return [a, b, c]
        .reduce((max, value) => value > max ? value : max)
        .toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.5), // Colore del bordo
              width: 2.0, // Spessore del bordo
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChartBar(a, Colors.orange),
                    _buildChartBar(b, Colors.blue),
                    _buildChartBar(c, Colors.yellow),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('Staff Tecnico',
                          style: TextStyle(color: Colors.orange))),
                  Expanded(
                      child: Text('Staff Interno',
                          style: TextStyle(color: Colors.blue))),
                  Expanded(
                      child: Text('Altro',
                          style: TextStyle(color: Colors.yellow))),
                ],
              ),
            ],
          ),
        ),
        Text('Totale : ${a + b + c}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ],
    );
  }

  Widget _buildChartBar(int value, Color color) {
    return ChartBar(fill: value == 0 ? 0 : value / maxTotalValue, color: color);
  }
}
