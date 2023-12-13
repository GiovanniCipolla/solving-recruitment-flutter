import 'package:flutter/material.dart';
import 'package:solving_recruitment_flutter/widgets/chart_bar.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key, 
    required this.a,
    required this.b,
    required this.c,
  }) ;

  final int a;
  final int b;
  final int c;

  double get maxTotalValue {
    return [a, b, c].reduce((max, value) => value > max ? value : max).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChartBar(a, Colors.orange),
                _buildChartBar(b, Colors.blue),
                _buildChartBar(c, Colors.yellow),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildIcon(Icons.person,context),
              _buildIcon(Icons.work,context),
              _buildIcon(Icons.more_horiz,context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(int value, Color color) {
    return ChartBar(fill: value == 0 ? 0 : value / maxTotalValue, color: color);
  }

  Widget _buildIcon(IconData icon, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
      ),
    );
  }
}
