import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, _) {
        final Color activeColor = isDark ? Colors.white : Colors.black;
        final Color inactiveColor = isDark ? Colors.grey.shade400 : Colors.grey;
        final Color bg = isDark ? Colors.black : Colors.white;

        return ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, selectedPage, _) {
            return BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 30,
              color: bg,
              elevation: 40,
              child: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.grid_view_rounded,
                        size: 30,
                        color: selectedPage == 0 ? activeColor : inactiveColor,
                      ),
                      onPressed: () => selectedPageNotifier.value = 0,
                    ),

                    SizedBox(width: 30),

                    IconButton(
                      icon: Icon(
                        Icons.calendar_month_rounded,
                        size: 30,
                        color: selectedPage == 2 ? activeColor : inactiveColor,
                      ),
                      onPressed: () => selectedPageNotifier.value = 2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
