import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/space_constants.dart';
import '../widgets/hero_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showButton = _scrollController.offset > 500;
    if (showButton != _showScrollToTop) {
      setState(() {
        _showScrollToTop = showButton;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToProjects() {
    final context = _projectsSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToContact() {
    final context = _contactSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Section
              SliverToBoxAdapter(
                child: HeroSection(
                  onViewProjectsPressed: _scrollToProjects,
                  onContactPressed: _scrollToContact,
                ),
              ),
              
              // Experience Section
              SliverToBoxAdapter(
                child: const ExperienceSection(),
              ),
              
              // Skills Section
              SliverToBoxAdapter(
                child: const SkillsSection(),
              ),
              
              // Projects Section
              SliverToBoxAdapter(
                child: ProjectsSection(key: _projectsSectionKey),
              ),
              
              // Contact Section
              SliverToBoxAdapter(
                child: ContactSection(key: _contactSectionKey),
              ),
            ],
          ),
          
          // Scroll to top button
          Positioned(
            right: 24,
            bottom: 24,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showScrollToTop ? 1.0 : 0.0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: _showScrollToTop ? 1.0 : 0.0,
                child: _buildScrollToTopButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _scrollToTop,
          borderRadius: BorderRadius.circular(30),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    )
        .animate(target: _showScrollToTop ? 1 : 0)
        .scale(duration: 300.ms);
  }
}

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onSkillsPressed;
  final VoidCallback? onProjectsPressed;
  final VoidCallback? onContactPressed;

  const CustomNavBar({
    super.key,
    this.onHomePressed,
    this.onAboutPressed,
    this.onSkillsPressed,
    this.onProjectsPressed,
    this.onContactPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.mobile;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primaryPurple.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Name
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              'UP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          
          // Navigation links (desktop only)
          if (!isMobile)
            Row(
              children: [
                _NavLink(text: 'Home', onPressed: onHomePressed),
                _NavLink(text: 'About', onPressed: onAboutPressed),
                _NavLink(text: 'Skills', onPressed: onSkillsPressed),
                _NavLink(text: 'Projects', onPressed: onProjectsPressed),
                _NavLink(text: 'Contact', onPressed: onContactPressed),
              ],
            ),
          
          // Mobile menu button
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              onPressed: () {
                // Show mobile menu
              },
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const _NavLink({
    required this.text,
    this.onPressed,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? AppColors.primaryBlue
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

