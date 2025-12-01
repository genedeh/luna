import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/pages/tabs/calendar_page.dart';
import 'package:luna/pages/tabs/notes_page.dart';
import 'package:luna/pages/tabs/take_note_page.dart';
import 'package:luna/widgets/navbar_widget.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  List<Widget> pages = [NotesPage(), TakeNotePage(), CalendarPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        highlightElevation: 12,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 40, color: Colors.white),
        onPressed: () {
          selectedPageNotifier.value = 1;
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
