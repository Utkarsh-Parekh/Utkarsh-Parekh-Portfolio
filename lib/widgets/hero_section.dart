import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/social_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/space_constants.dart';
import '../data/constants.dart';
import 'animated_text.dart';
import 'gradient_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjectsPressed;
  final VoidCallback? onContactPressed;
  
  const HeroSection({super.key, this.onViewProjectsPressed, this.onContactPressed});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // Fallback: try with platform default
      try {
        await launchUrl(uri);
      } catch (_) {
        debugPrint('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < AppBreakpoints.mobile;
    final isTablet = screenWidth < AppBreakpoints.tablet;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.9,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F0F1A),
            Color(0xFF1A1A2E),
            Color(0xFF0F0F1A),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background animated circles
          ..._buildBackgroundElements(screenWidth, screenHeight),
          
          // Main content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText(
                    text: ProfileData.name,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 36 : isTablet ? 52 : 64,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                    gradient: AppColors.primaryGradient,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 12),
                  
                  // Title
                  Text(
                    ProfileData.title,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 18 : 24,
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms),
                  
                  const SizedBox(height: 24),
                  
                  // Bio description
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? screenWidth * 0.9 : 800,
                    ),
                    child: Text(
                      ProfileData.bio.trim(),
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
                        color: AppColors.textSecondary,
                        height: 1.7,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms),
                  
                  const SizedBox(height: 40),
                  
                  // CTA Buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      GradientButton(
                        text: 'View Projects',
                        icon: Icons.work_outline,
                        onPressed: onViewProjectsPressed ?? () {},
                        width: isMobile ? 150 : 170,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 600.ms)
                          .slideX(begin: -0.3, end: 0),
                      
                      GradientButton(
                        text: 'Resume',
                        icon: Icons.description_outlined,
                        onPressed: () => _launchUrl(ProfileData.resumeUrl),
                        width: isMobile ? 150 : 170,
                        gradient: AppColors.accentGradient,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 700.ms)
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                      
                      GradientButton(
                        text: 'Contact Me',
                        icon: Icons.email_outlined,
                        onPressed: onContactPressed ?? () {},
                        width: isMobile ? 150 : 170,
                        isOutlined: true,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 800.ms)
                          .slideX(begin: 0.3, end: 0),
                    ],
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Social Links
                  _buildSocialLinks(isMobile),
                  
                  const SizedBox(height: 32),
                  
                  // Scroll Down (below social links)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Scroll Down',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.textMuted,
                        size: 24,
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(reverse: true),
                          )
                          .moveY(begin: 0, end: 8, duration: 1000.ms),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 1200.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    IconData icon,
    String tooltip,
    String url,
    int index,
  ) {
    return IconGradientButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: () => _launchUrl(url),
      size: 48,
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: Duration(milliseconds: 800 + (index * 100)))
        .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1));
  }

  List<Widget> _buildBackgroundElements(double width, double height) {
    return [
      // Top right gradient circle
      Positioned(
        top: -100,
        right: -100,
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primaryPurple.withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.2, 1.2),
              duration: 4000.ms,
            ),
      ),
      
      // Bottom left gradient circle
      Positioned(
        bottom: -150,
        left: -150,
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primaryBlue.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .scale(
              begin: const Offset(1.2, 1.2),
              end: const Offset(1, 1),
              duration: 5000.ms,
            ),
      ),
      
      // Center accent
      Positioned(
        top: height * 0.3,
        left: width * 0.1,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accentOrange.withOpacity(0.08),
                Colors.transparent,
              ],
            ),
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .moveY(begin: 0, end: 20, duration: 3000.ms),
      ),
    ];
  }

  Widget _buildSocialLinks(bool isMobile) {
    final socialLinks = [
      {
        'icon': Icons.code,
        'name': 'GitHub',
        'url': ProfileData.githubUrl,
        'color': Colors.white,
      },
      {
        'icon': Icons.work,
        'name': 'LinkedIn',
        'url': ProfileData.linkedinUrl,
        'color': const Color(0xFF0A66C2),
      },
      {
        'icon': Icons.photo_camera_outlined,
        'name': 'Instagram',
        'url': ProfileData.instagramUrl,
        'color': const Color(0xFFE4405F),
      },
    ];

    return Column(
      children: [
        Wrap(
          spacing: isMobile ? 12 : 20,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return SocialLinkButton(
              icon: link['icon'] as IconData,
              name: link['name'] as String,
              url: link['url'] as String,
              color: link['color'] as Color,
              index: index,
              isMobile: isMobile,
            );
          }).toList(),
        ),
      ],
    );
  }
}

