import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    super.key,
    required this.title,
    required this.description,
    required this.type,
    required this.isDarkMode,
  });

  final String title;
  final String description;
  final int type;
  final bool isDarkMode;

  Color get _color {
    switch (type) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.red;
      case 2:
        return Colors.amber;
      default:
        return Colors.blueGrey;
    }
  }

  IconData get _icon {
    switch (type) {
      case 0:
        return Icons.check_circle_rounded;
      case 1:
        return Icons.error_rounded;
      case 2:
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon, color: _color, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: (isDarkMode ? Colors.white70 : Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
