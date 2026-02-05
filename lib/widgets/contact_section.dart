import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/space_constants.dart';
import '../data/constants.dart';
import 'gradient_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
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
    final isMobile = screenWidth < AppBreakpoints.mobile;

    return Container(
      width: double.infinity,
      padding: isMobile
          ? AppSpacing.sectionPaddingMobile
          : AppSpacing.sectionPadding,
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.darkBackground,
            AppColors.primaryPurple.withOpacity(0.05),
            AppColors.darkBackground,
          ],
        ),
      ),
      child: Column(
        children: [
          // Section Title
          _buildSectionTitle(isMobile),
          
          SizedBox(height: isMobile ? 32 : 48),
          
          // Contact Content
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // CTA Card
                _buildCtaCard(context, isMobile),
                
                SizedBox(height: isMobile ? 48 : 64),
                
                // Footer
                _buildFooter(isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isMobile) {
    return Column(
      children: [
        Text(
          'Get In Touch',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        
        const SizedBox(height: 12),
        
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .scaleX(begin: 0, end: 1),
        
        const SizedBox(height: 16),
        
        Text(
          "Let's work together!",
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14 : 16,
            color: AppColors.textSecondary,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 300.ms),
      ],
    );
  }

  Widget _buildCtaCard(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryPurple.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Email icon
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.email_outlined,
              color: Colors.white,
              size: 32,
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
          
          const SizedBox(height: 24),
          
          Text(
            'Have a project in mind?',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 20 : 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 500.ms),
          
          const SizedBox(height: 12),
          
          Text(
            "I'm always interested in hearing about new projects and opportunities. Feel free to reach out!",
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 14 : 16,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms),
          
          const SizedBox(height: 32),
          
          // Contact buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              GradientButton(
                text: 'Send Email',
                icon: Icons.send,
                onPressed: () => _launchUrl('mailto:${ProfileData.email}'),
                width: isMobile ? double.infinity : 180,
              )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 700.ms)
                  .slideY(begin: 0.3, end: 0),
            ],
          ),

        ],
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 300.ms)
        .slideY(begin: 0.2, end: 0);
  }

  Widget _buildFooter(bool isMobile) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.primaryPurple.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flutter_dash,
              color: AppColors.primaryBlue,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Built with Flutter',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Text(
          '© 2026 ${ProfileData.name}. All rights reserved.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 1200.ms);
  }
}



