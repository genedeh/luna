import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/utils/show_toast.dart';
import 'package:luna/widgets/toast_widget.dart';

class TakeNotePage extends StatefulWidget {
  const TakeNotePage({super.key});

  @override
  State<TakeNotePage> createState() => _TakeNotePageState();
}

class _TextStyleOption {
  final String name;
  final Attribute attribute;
  _TextStyleOption(this.name, this.attribute);
}

class _TakeNotePageState extends State<TakeNotePage>
    with WidgetsBindingObserver {
  late final QuillController _controller;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _noteTitleController = TextEditingController();
  bool _keyboardVisible = false;
  bool _noteTitleSet = false;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    WidgetsBinding.instance.addObserver(this);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _isAttributeActive(Attribute attribute) {
    final style = _controller.getSelectionStyle();

    if (attribute.key == Attribute.header.key) {
      return style.attributes[Attribute.header.key]?.value == attribute.value;
    }

    return style.containsKey(attribute.key);
  }

  Widget formatIcon({required IconData icon, required Attribute attribute}) {
    final isActive = _isAttributeActive(attribute);

    return IconButton(
      icon: Icon(
        icon,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).appBarTheme.foregroundColor,
        size: isActive ? 30 : 22,
      ),
      onPressed: () async {
        _focusNode.requestFocus();

        if (attribute.key == Attribute.link.key) {
          final url = await showDialog<String>(
            context: context,
            builder: (context) {
              final controller = TextEditingController();
              return AlertDialog(
                title: Text("Enter link URL"),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "https://example.com",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 20,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(controller.text),
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );

          if (url != null && url.isNotEmpty) {
            _controller.formatSelection(LinkAttribute(url));
          } else if (isActive) {
            _controller.formatSelection(Attribute.clone(attribute, null));
          }
        } else {
          if (isActive) {
            _controller.formatSelection(Attribute.clone(attribute, null));
          } else {
            _controller.formatSelection(attribute);
          }
        }

        Future.microtask(() => setState(() {}));
      },
    );
  }

  PopupMenuItem<_TextStyleOption> _styledTextItem(
    String label,
    Attribute attribute,
  ) {
    final isActive = _isAttributeActive(attribute);

    return PopupMenuItem(
      value: _TextStyleOption(label, attribute),
      child: Text(
        label,
        style: TextStyle(
          fontSize: _isAttributeActive(attribute) ? 26 : 22,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }

  PopupMenuItem<_TextStyleOption> _styledIconItem(
    String label,
    Attribute attribute,
    IconData icon,
  ) {
    final isActive = _isAttributeActive(attribute);

    return PopupMenuItem(
      value: _TextStyleOption(label, attribute),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeMetrics() {
    if (!mounted) return;

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final newValue = bottomInset > 0;
    if (newValue != _keyboardVisible) {
      setState(() => _keyboardVisible = newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (_, isDarkMode, _) {
        final iconColor = isDarkMode ? Colors.white : Colors.black87;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          controller: _noteTitleController,
                          decoration: InputDecoration(
                            hintText: "Note Title",
                            focusColor: Theme.of(context).colorScheme.primary,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[500],
                              fontSize: 24,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _noteTitleController.text.isNotEmpty
                            ? Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: Container(
                                    width: 48, // Fixed circular size
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: iconColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Icons.check_rounded,
                                        color: _noteTitleSet
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Theme.of(context).hintColor,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _noteTitleSet = true;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 115,
                  right: 0,
                  left: 0,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Divider(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.4),
                    ),
                  ),
                ),

                Positioned(
                  top: 121,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: QuillEditor(
                      controller: _controller,
                      focusNode: _focusNode,
                      scrollController: _scrollController,
                      key: Key('quill_note'),
                      config: QuillEditorConfig(
                        placeholder: "Start typing...",
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 12,
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.black.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              splashRadius: 22,
                              icon: Icon(Icons.close_rounded, color: iconColor),
                              onPressed: () => selectedPageNotifier.value = 0,
                            ),
                            IconButton(
                              splashRadius: 22,
                              icon: Icon(Icons.done_rounded, color: iconColor),
                              onPressed: () {
                                if (_noteTitleController.text.isNotEmpty &&
                                    _controller.getPlainText().isNotEmpty) {
                                  showToast(
                                    context,
                                    title: "Saved!",
                                    description:
                                        "Your note has been stored successfully.",
                                    type: 0,
                                    isDarkMode: isDarkModeNotifier.value,
                                  );
                                  selectedPageNotifier.value = 0;
                                } else {
                                  showToast(
                                    context,
                                    title: "Take a note",
                                    description: "Write Something",
                                    type: 1,
                                    isDarkMode: isDarkModeNotifier.value,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: const EdgeInsets.all(7.0),
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 300,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.black.withValues(alpha: 0.9)
                              : Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PopupMenuButton<_TextStyleOption>(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                                elevation: 10,
                                tooltip: "Text Style",
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    "Text",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                onSelected: (option) {
                                  final isActive = _isAttributeActive(
                                    option.attribute,
                                  );
                                  if (isActive) {
                                    _controller.formatSelection(
                                      Attribute.clone(option.attribute, null),
                                    );
                                  } else {
                                    _controller.formatSelection(
                                      option.attribute,
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  _styledTextItem("Header 1", Attribute.h1),
                                  _styledTextItem("Header 2", Attribute.h2),
                                  _styledTextItem("Subtitle", Attribute.h3),
                                  _styledTextItem(
                                    "Paragraph",
                                    Attribute.header,
                                  ),
                                  _styledTextItem("Caption", Attribute.small),

                                  const PopupMenuDivider(),

                                  _styledIconItem(
                                    "Quote",
                                    Attribute.blockQuote,
                                    Icons.format_quote_rounded,
                                  ),
                                  _styledIconItem(
                                    "Code Block",
                                    Attribute.codeBlock,
                                    Icons.code_rounded,
                                  ),
                                ],
                              ),
                              formatIcon(
                                icon: Icons.format_bold_rounded,
                                attribute: Attribute.bold,
                              ),
                              formatIcon(
                                icon: Icons.format_underline_rounded,
                                attribute: Attribute.underline,
                              ),
                              formatIcon(
                                icon: Icons.format_italic_rounded,
                                attribute: Attribute.italic,
                              ),
                              formatIcon(
                                icon: Icons.format_list_bulleted_rounded,
                                attribute: Attribute.ul,
                              ),
                              formatIcon(
                                icon: Icons.format_list_numbered_rounded,
                                attribute: Attribute.ol,
                              ),
                              formatIcon(
                                icon: Icons.format_align_left_rounded,
                                attribute: Attribute.leftAlignment,
                              ),
                              formatIcon(
                                icon: Icons.format_align_center_rounded,
                                attribute: Attribute.centerAlignment,
                              ),
                              formatIcon(
                                icon: Icons.format_align_right_rounded,
                                attribute: Attribute.rightAlignment,
                              ),
                              formatIcon(
                                icon: Icons.link_rounded,
                                attribute: Attribute.link,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
