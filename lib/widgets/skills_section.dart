import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill_category_model.dart';
import '../data/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 32 : 48,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F1A),
      ),
      child: Column(
        children: [
          // Section Title
          _buildSectionTitle(isMobile),
          
          SizedBox(height: isMobile ? 32 : 48),
          
          // Skills Categories
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: _buildSkillCategories(isMobile),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isMobile) {
    return Column(
      children: [
        Text(
          'Skills & Technologies',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
            gradient: const LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFF00D2FF)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .scaleX(begin: 0, end: 1),
      ],
    );
  }

  Widget _buildSkillCategories(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillCategoriesData.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        return _SkillCategoryWidget(
          category: category,
          index: index,
          isMobile: isMobile,
        );
      }).toList(),
    );
  }
}

class _SkillCategoryWidget extends StatelessWidget {
  final SkillCategoryModel category;
  final int index;
  final bool isMobile;

  const _SkillCategoryWidget({
    required this.category,
    required this.index,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: category.categoryColor.withValues(alpha:  0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  category.categoryIcon,
                  color: category.categoryColor,
                  size: isMobile ? 18 : 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                category.categoryName,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w600,
                  color: category.categoryColor,
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(
                duration: 500.ms,
                delay: Duration(milliseconds: 200 + (index * 100)),
              )
              .slideX(begin: -0.2, end: 0),
          
          SizedBox(height: isMobile ? 12 : 16),
          
          // Skills chips
          Wrap(
            spacing: isMobile ? 8 : 12,
            runSpacing: isMobile ? 8 : 12,
            children: category.skills.asMap().entries.map((skillEntry) {
              final skillIndex = skillEntry.key;
              final skill = skillEntry.value;
              return _SkillChip(
                skill: skill,
                categoryIndex: index,
                skillIndex: skillIndex,
                isMobile: isMobile,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skill;
  final int categoryIndex;
  final int skillIndex;
  final bool isMobile;

  const _SkillChip({
    required this.skill,
    required this.categoryIndex,
    required this.skillIndex,
    required this.isMobile,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 14 : 18,
          vertical: widget.isMobile ? 8 : 10,
        ),
        decoration: BoxDecoration(
          color: _isHovered 
              ? const Color(0xFF2196F3).withValues(alpha:   0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: _isHovered 
                ? const Color(0xFF2196F3).withValues(alpha:  0.5)
                : const Color(0xFF3A3A5C),
            width: 1.5,
          ),
        ),
        child: Text(
          widget.skill,
          style: GoogleFonts.poppins(
            fontSize: widget.isMobile ? 13 : 14,
            fontWeight: FontWeight.w500,
            color: _isHovered ? const Color(0xFF2196F3) : const Color(0xFFB0B0C3),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 400.ms,
          delay: Duration(
            milliseconds: 300 + (widget.categoryIndex * 100) + (widget.skillIndex * 50),
          ),
        )
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}
