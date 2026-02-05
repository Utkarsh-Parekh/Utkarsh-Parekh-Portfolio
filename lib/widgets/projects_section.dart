import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/space_constants.dart';
import '../data/constants.dart';
import '../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.mobile;
    final isTablet = screenWidth < AppBreakpoints.tablet;

    return Container(
      width: double.infinity,
      padding: isMobile
          ? AppSpacing.sectionPaddingMobile
          : AppSpacing.sectionPadding,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
      ),
      child: Column(
        children: [
          // Section Title
          _buildSectionTitle(isMobile),
          
          SizedBox(height: isMobile ? 32 : 48),
          
          // Projects Grid
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: _buildProjectsGrid(isMobile, isTablet),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isMobile) {
    return Column(
      children: [
        Text(
          'Featured Projects',
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
          'Some of my recent work',
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

  Widget _buildProjectsGrid(bool isMobile, bool isTablet) {
    final crossAxisCount = isMobile ? 1 : isTablet ? 2 : 3;
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.2 : 0.95,
      ),
      itemCount: projectsData.length,
      itemBuilder: (context, index) {
        return _ProjectCard(
          project: projectsData[index],
          index: index,
          isMobile: isMobile,
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final int index;
  final bool isMobile;

  const _ProjectCard({
    required this.project,
    required this.index,
    required this.isMobile,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _launchUrl(widget.project.githubUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryPurple.withOpacity(0.5)
                  : AppColors.primaryPurple.withOpacity(0.15),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Background gradient accent
                Positioned(
                  top: -50,
                  right: -50,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isHovered ? 180 : 150,
                    height: _isHovered ? 180 : 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          widget.project.languageColor.withOpacity(
                            _isHovered ? 0.3 : 0.15,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon and language
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: widget.project.languageColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              widget.project.icon,
                              color: widget.project.languageColor,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.project.languageColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: widget.project.languageColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.project.language,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Project name
                      Text(
                        widget.project.name,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Description
                      Expanded(
                        child: Text(
                          widget.project.description,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tech stack
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.techStack
                            .take(4)
                            .map((tech) => _buildTechChip(tech))
                            .toList(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // View on GitHub
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          children: [
                            Text(
                              'View on GitHub',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: _isHovered
                                    ? AppColors.primaryBlue
                                    : AppColors.textMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              transform: Matrix4.identity()
                                ..translate(_isHovered ? 4.0 : 0.0, 0.0),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: _isHovered
                                    ? AppColors.primaryBlue
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: 300 + (widget.index * 150)),
        )
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryPurple.withOpacity(0.2),
        ),
      ),
      child: Text(
        tech,
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

