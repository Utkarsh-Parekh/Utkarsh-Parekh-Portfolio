import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants/color_constants.dart';

class SocialLinkButton extends StatefulWidget {
  final IconData icon;
  final String name;
  final String url;
  final Color color;
  final int index;
  final bool isMobile;

  const SocialLinkButton({
    super.key,
    required this.icon,
    required this.name,
    required this.url,
    required this.color,
    required this.index,
    required this.isMobile,
  });

  @override
  State<SocialLinkButton> createState() => SocialLinkButtonState();
}

class SocialLinkButtonState extends State<SocialLinkButton> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(widget.url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Fallback: try with platform default
      try {
        await launchUrl(uri);
      } catch (_) {
        debugPrint('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _launchUrl,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: widget.isMobile ? 16 : 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: _isHovered
                    ? widget.color.withValues(alpha:   0.2)
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered
                      ? widget.color.withValues(alpha: 0.5)
                      : AppColors.primaryPurple.withValues(alpha:   0.2),
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: widget.color.withValues(alpha:  0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: _isHovered ? widget.color : AppColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: _isHovered
                          ? widget.color
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: 500.ms,
          delay: Duration(milliseconds: 1100 + (widget.index * 100)),
        )
        .slideY(begin: 0.3, end: 0);
  }
}
