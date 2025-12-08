import 'package:flutter/material.dart';

class RightSlideIn extends StatefulWidget {
  final Widget child;

  const RightSlideIn({super.key, required this.child});

  @override
  State<RightSlideIn> createState() => _RightSlideInState();
}

class _RightSlideInState extends State<RightSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offset = Tween<Offset>(
      begin: const Offset(1.0, 0), // start off-screen RIGHT
      end: Offset.zero, // end in place
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offset, child: widget.child);
  }
}
