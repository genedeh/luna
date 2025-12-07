import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  int selectedFilter = 0;

  final filters = [
    "Newest → Oldest",
    "Oldest → Newest",
    "A → Z",
    "Z → A",
    "Recently Updated",
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, _) {
        final bg = isDarkMode ? Colors.black38 : Colors.white;

        final iconColor = isDarkMode ? Colors.white70 : Colors.black54;

        final textColor = isDarkMode ? Colors.white : Colors.black87;

        return SearchBar(
          controller: _controller,
          hintText: "Search notes...",
          backgroundColor: WidgetStatePropertyAll(bg),
          elevation: WidgetStatePropertyAll(0),
          hintStyle: WidgetStatePropertyAll(
            TextStyle(color: isDarkMode ? Colors.white38 : Colors.black38),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(color: textColor, fontSize: 15),
          ),
          leading: Icon(Icons.search_rounded, color: iconColor),

          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          ),

          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),

          trailing: [
            PopupMenuButton<String>(
              color: isDarkMode ? Colors.black38 : Colors.white,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                setState(() {
                  selectedFilter = filters.indexOf(value);
                });
              },
              icon: Icon(Icons.tune_rounded, color: iconColor),
              itemBuilder: (context) {
                return filters
                    .map((f) => PopupMenuItem(value: f, child: Text(f)))
                    .toList();
              },
            ),
          ],
        );
      },
    );
  }
}
