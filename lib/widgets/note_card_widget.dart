import 'dart:math';
import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';

class NoteCardWidget extends StatefulWidget {
  final String title;
  final String shortDescPreview;

  const NoteCardWidget({
    super.key,
    required this.title,
    required this.shortDescPreview,
  });

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget>
    with SingleTickerProviderStateMixin {
  late final Color randomDotColor;

  @override
  void initState() {
    super.initState();
    randomDotColor = _randomColor();
  }

  Color _randomColor() {
    final colors = [
      Colors.pink,
      Colors.blue,
      Colors.green,
      Colors.lightGreen,
      Colors.orange,
      Colors.teal,
      Colors.redAccent,
    ];
    return colors[Random().nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 80),
      margin: const EdgeInsets.only(bottom: 16),

      child: ValueListenableBuilder(
        valueListenable: isDarkModeNotifier,
        builder: (context, isDarkMode, child) {
          return Material(
            color: isDarkMode
                ? const Color(0xFF0F0F0F)
                : const Color(0xFFFDFDFD),
            shadowColor: Colors.black38,
            elevation: 3,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                width: 1,
              ),
            ),

            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {},

              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Description preview
                    Text(
                      widget.shortDescPreview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        color: isDarkMode ? Colors.white38 : Colors.black38,
                      ),
                    ),

                    SizedBox(height: 12),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: randomDotColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: randomDotColor.withValues(
                                red: 0.5,
                                blue: 0.5,
                                green: 0.5,
                                alpha: 0.5,
                              ),
                              blurRadius: 6,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
