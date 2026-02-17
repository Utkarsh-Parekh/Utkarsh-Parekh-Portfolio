import 'package:flutter/material.dart';
import 'dart:async';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration startDelay;
  final bool showCursor;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 80),
    this.startDelay = const Duration(milliseconds: 500),
    this.showCursor = true,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  int _charIndex = 0;
  Timer? _typingTimer;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.startDelay, _startTyping);
    if (widget.showCursor) {
      _startCursorBlink();
    }
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(widget.typingSpeed, (timer) {
      if (_charIndex < widget.text.length) {
        setState(() {
          _displayText = widget.text.substring(0, _charIndex + 1);
          _charIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _displayText,
            style: widget.style,
          ),
          if (widget.showCursor && _charIndex < widget.text.length)
            TextSpan(
              text: _showCursor ? '|' : ' ',
              style: widget.style?.copyWith(
                fontWeight: FontWeight.w100,
              ),
            ),
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    required this.colors,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: widget.colors,
              begin: Alignment.lerp(
                Alignment.centerLeft,
                Alignment.centerRight,
                _controller.value,
              )!,
              end: Alignment.lerp(
                Alignment.centerRight,
                Alignment.centerLeft,
                _controller.value,
              )!,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
          ),
        );
      },
    );
  }
}

class LoopingTypewriterGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final Duration typingSpeed;
  final Duration pauseDuration;
  final Duration eraseSpeed;
  final bool showCursor;

  const LoopingTypewriterGradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(seconds: 2),
    this.eraseSpeed = const Duration(milliseconds: 50),
    this.showCursor = true,
  });

  @override
  State<LoopingTypewriterGradientText> createState() =>
      _LoopingTypewriterGradientTextState();
}

class _LoopingTypewriterGradientTextState
    extends State<LoopingTypewriterGradientText> {
  String _displayText = '';
  int _charIndex = 0;
  Timer? _animationTimer;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
    if (widget.showCursor) {
      _startCursorBlink();
    }
  }

  void _startTyping() {
    _charIndex = 0;
    _displayText = '';

    _animationTimer = Timer.periodic(widget.typingSpeed, (timer) {
      if (_charIndex < widget.text.length) {
        setState(() {
          _displayText = widget.text.substring(0, _charIndex + 1);
          _charIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(widget.pauseDuration, () {
          if (mounted) {
            _startErasing();
          }
        });
      }
    });
  }

  void _startErasing() {
    _charIndex = widget.text.length;

    _animationTimer = Timer.periodic(widget.eraseSpeed, (timer) {
      if (_charIndex > 0) {
        setState(() {
          _charIndex--;
          _displayText = widget.text.substring(0, _charIndex);
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _startTyping();
          }
        });
      }
    });
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _showCursor = !_showCursor;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => widget.gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: _displayText,
              style: widget.style,
            ),
            if (widget.showCursor)
              TextSpan(
                text: _showCursor ? '|' : ' ',
                style: widget.style?.copyWith(
                  fontWeight: FontWeight.w100,
                ),
              ),
          ],
        ),
      ),
    );
  }
}


