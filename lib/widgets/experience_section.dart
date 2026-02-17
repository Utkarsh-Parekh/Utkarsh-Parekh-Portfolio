import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/space_constants.dart';
import '../data/constants.dart';
import '../models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.mobile;

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
          
          // Experience Timeline
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: _buildExperienceTimeline(isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isMobile) {
    return Column(
      children: [
        Text(
          'Work Experience',
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
          'My professional journey',
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

  Widget _buildExperienceTimeline(bool isMobile) {
    final sortedExperience = List<ExperienceModel>.from(experienceData)
      ..sort((a, b) {
        if (a.isCurrent) return -1;
        if (b.isCurrent) return 1;
        return 0;
      });

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedExperience.length,
      itemBuilder: (context, index) {
        return _ExperienceCard(
          experience: sortedExperience[index],
          index: index,
          isMobile: isMobile,
          isLast: index == sortedExperience.length - 1,
        );
      },
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  final ExperienceModel experience;
  final int index;
  final bool isMobile;
  final bool isLast;

  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isMobile,
    required this.isLast,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Start collapsed by default
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        _buildTimelineIndicator(),
        
        const SizedBox(width: 16),
        
        // Card content
        Expanded(
          child: _buildCard(),
        ),
      ],
    )
        .animate()
        .fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: 300 + (widget.index * 200)),
        )
        .slideX(begin: -0.2, end: 0);
  }

  Widget _buildTimelineIndicator() {
    return Column(
      children: [
        // Dot
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.experience.isCurrent
                ? AppColors.accentGreen
                : AppColors.primaryPurple,
            boxShadow: [
              BoxShadow(
                color: (widget.experience.isCurrent
                        ? AppColors.accentGreen
                        : AppColors.primaryPurple)
                    .withValues(alpha:  0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        
        // Line
        if (!widget.isLast)
          Container(
            width: 2,
            height: _isExpanded ? 160 : 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryPurple,
                  AppColors.primaryPurple.withValues(alpha:   0.3),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(bottom: widget.isMobile ? 16 : 24),
          padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered || _isExpanded
                  ? widget.experience.companyColor.withValues(alpha:   0.5)
                  : AppColors.primaryPurple.withValues(alpha:  0.2),
              width: _isHovered || _isExpanded ? 2 : 1,
            ),
            boxShadow: _isHovered || _isExpanded
                ? [
                    BoxShadow(
                      color: widget.experience.companyColor.withValues(alpha:  0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              
              const SizedBox(height: 12),
              
              // Position and duration
              _buildPositionInfo(),
              
              // Expandable content (description + highlights)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: _buildExpandedContent(),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              
              const SizedBox(height: 12),
              
              // Expand/Collapse indicator
              _buildExpandIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Company icon
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.experience.companyColor.withValues(alpha:  0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.business,
            color: widget.experience.companyColor,
            size: widget.isMobile ? 20 : 24,
          ),
        ),
        
        const SizedBox(width: 12),
        
        // Company name
        Expanded(
          child: Text(
            widget.experience.company,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: widget.experience.companyColor,
            ),
          ),
        ),
        
        // Expand icon
        AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionInfo() {
    return widget.isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Position
              Row(
                children: [
                  Icon(
                    Icons.work_outline,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.experience.position,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Duration
              _buildDurationBadge(),
            ],
          )
        : Row(
            children: [
              // Position
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 16,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        widget.experience.position,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Duration
              _buildDurationBadge(),
            ],
          );
  }

  Widget _buildDurationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: widget.experience.isCurrent
            ? AppColors.accentGreen.withValues(alpha:   0.15)
            : AppColors.primaryPurple.withValues(alpha:  0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 12,
            color: widget.experience.isCurrent
                ? AppColors.accentGreen
                : AppColors.primaryBlue,
          ),
          const SizedBox(width: 4),
          Text(
            widget.experience.duration,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: widget.experience.isCurrent
                  ? AppColors.accentGreen
                  : AppColors.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (widget.experience.isCurrent) ...[
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    final hasDescription = widget.experience.description.isNotEmpty;
    final hasHighlights = widget.experience.highlights.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        if (hasDescription)
          Text(
            widget.experience.description,
            style: GoogleFonts.poppins(
              fontSize: widget.isMobile ? 13 : 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        if (hasDescription && hasHighlights) const SizedBox(height: 12),
        if (hasHighlights)
          ...widget.experience.highlights.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: GoogleFonts.poppins(
                      fontSize: widget.isMobile ? 13 : 14,
                      color: AppColors.primaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.poppins(
                        fontSize: widget.isMobile ? 13 : 14,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExpandIndicator() {
    return Center(
      child: Text(
        _isExpanded ? 'Click to collapse' : 'Click to expand',
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: AppColors.textMuted,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

