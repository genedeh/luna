import 'package:flutter/material.dart';
import 'package:luna/widgets/note_card_widget.dart';

class NotesLayout extends StatefulWidget {
  const NotesLayout({super.key});

  @override
  State<NotesLayout> createState() => _NotesLayoutState();
}

class _NotesLayoutState extends State<NotesLayout> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Notes',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              IconButton.filled(
                onPressed: () {
                  setState(() {
                    isGrid = !isGrid;
                  });
                },
                icon: Icon(
                  isGrid ? Icons.grid_view_rounded : Icons.menu_rounded,
                  size: 32,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Flexible(
            child: isGrid
                ? GridView.builder(
                    padding: EdgeInsets.only(top: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return NoteCardWidget(
                        title: 'How to write thank you note',
                        shortDescPreview:
                            'Generate Lorem dummy placeholder text here',
                      );
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: NoteCardWidget(
                          title: 'How to write thank you note',
                          shortDescPreview:
                              'Generate Lorem dummy placeholder text here',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
