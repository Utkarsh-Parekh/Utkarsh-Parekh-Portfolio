import 'package:flutter/material.dart';
import '../config/constants/color_constants.dart';
import '../models/project_model.dart';
import '../models/skill_category_model.dart';
import '../models/experience_model.dart';


class ProfileData {
  static const String name = 'Utkarsh Parekh';
  static const String title = 'Flutter Developer';
  static const String subtitle =
      'A passionate & result oriented Android/Flutter developer';
  static const String email = 'parekhutkarsh024@gmail.com';

  static const String bio = '''
  Flutter Developer with 3+ years of experience in building scalable, high-performance cross-platform mobile applications. Proficient in Flutter (Dart), Android development using Kotlin and Java, REST API integration, state management, and clean architecture. Strong focus on UI/UX best practices, performance optimization, and maintainable code.
''';

  static const String githubUrl = 'https://github.com/Utkarsh-Parekh';
  static const String linkedinUrl = 'https://linkedin.com/in/parekhutkarsh';
  static const String instagramUrl =
      'https://www.instagram.com/flutter_devverse/?hl=en';
  static const String resumeUrl =
  'https://drive.google.com/file/d/1xlcP2QWtL5Blxag-Wb-7RkFDwLvTC0cC/view?usp=sharing';
}


// ==================== SKILL CATEGORIES DATA ====================

final List<SkillCategoryModel> skillCategoriesData = [
  const SkillCategoryModel(
    categoryName: 'Mobile Development',
    categoryIcon: Icons.phone_android,
    categoryColor: Color(0xFF2196F3),
    skills: ['Flutter', 'Dart', 'Android', 'Kotlin', 'Java', 'UI/UX Design', 'Responsive Layouts'],
  ),
  const SkillCategoryModel(
    categoryName: 'Architecture & Patterns',
    categoryIcon: Icons.architecture,
    categoryColor: Color(0xFF2196F3),
    skills: ['MVVM', 'MVC', 'BLoC', 'Provider', 'Clean Architecture', 'State Management', 'TDD','OOP'],
  ),
  const SkillCategoryModel(
    categoryName: 'Backend & Database',
    categoryIcon: Icons.cloud,
    categoryColor: Color(0xFF2196F3),
    skills: ['Node.js', 'Express.js', 'MongoDB', 'Firebase', 'REST API', 'JWT Auth','AWS'],
  ),
  const SkillCategoryModel(
    categoryName: 'Tools & Libraries',
    categoryIcon: Icons.build,
    categoryColor: Color(0xFF2196F3),
    skills: ['Google Maps', 'Payment Gateway', 'Postman', 'Git', 'JIRA', 'Android Studio', 'VS Code'],
  ),
  const SkillCategoryModel(
    categoryName: 'Software Engineering',
    categoryIcon: Icons.engineering,
    categoryColor: Color(0xFF2196F3),
    skills: ['Agile Methodology', 'CI/CD', 'GitHub Actions', 'Modular Codebase'],
  ),
];

// ==================== EXPERIENCE DATA ====================

final List<ExperienceModel> experienceData = [
  ExperienceModel(
    company: 'Tata Consultancy Services (TCS)',
    position: 'System Engineer',
    duration: '2022 - 2025',
    description:
        'Software Engineer specializing in Flutter development for enterprise-grade mobile applications. Leading cross-functional feature development and ensuring scalable architecture.',
    companyColor: Color(0xFF0076CE),
    isCurrent: false,
  ),
  ExperienceModel(
    company: '10X Export',
    position: 'Full-Stack Flutter Developer',
    duration: '2025 - Present',
    description: 'Description of your role...',
    companyColor: Color(0xFF00A67E),
    isCurrent: true,
  ),
];

// ==================== PROJECTS DATA ====================

final List<ProjectModel> projectsData = [
  const ProjectModel(
    name: 'Gemini-ChatBot',
    description:
        'AI-powered chatbot application built with Flutter, integrating Google\'s Gemini API for intelligent conversations and responses.',
    techStack: ['Flutter', 'Dart', 'Gemini API', 'AI/ML'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/Gemini-ChatBot',
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.smart_toy,
  ),
  const ProjectModel(
    name: 'Tasks-App-Flutter',
    description:
        'A beautiful and functional task management application with intuitive UI, local storage, and smooth animations.',
    techStack: ['Flutter', 'Dart', 'SQLite', 'Provider'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/Tasks-App-Flutter',
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.check_circle,
  ),
  const ProjectModel(
    name: 'Grocery-Shopping-App',
    description:
        'Complete grocery shopping solution with product catalog, cart management, and seamless checkout experience.',
    techStack: ['Flutter', 'Dart', 'Firebase', 'Provider'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/Grocery-Shopping-App-Flutter',
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.shopping_cart,
  ),
  const ProjectModel(
    name: 'EV-Charging-App',
    description:
        'Electric vehicle charging station finder app with map integration, station details, and booking functionality.',
    techStack: ['Flutter', 'Dart', 'Google Maps', 'REST API'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/EV-Charging-App',
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.ev_station,
  ),
  const ProjectModel(
    name: 'Google Maps Integration',
    description:
        'Comprehensive Google Maps implementation showcasing markers, routes, location tracking, and custom styling.',
    techStack: ['Flutter', 'Dart', 'Google Maps SDK', 'Geolocator'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/google-maps-integration',
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.map,
  ),
  const ProjectModel(
    name: 'Authentication Backend',
    description:
        'Secure backend authentication system with JWT tokens, user management, and RESTful API endpoints.',
    techStack: ['Node.js', 'Express', 'JWT', 'MongoDB'],
    githubUrl: 'https://github.com/Utkarsh-Parekh/authentication-backend',
    language: 'JavaScript',
    languageColor: AppColors.javascriptColor,
    icon: Icons.security,
  ),
];
