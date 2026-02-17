import 'package:flutter/material.dart';
import '../config/constants/color_constants.dart';
import '../config/constants/env_keys.dart';
import '../models/project_model.dart';
import '../models/skill_category_model.dart';
import '../models/experience_model.dart';

class ProfileData {
  static const String name = 'Utkarsh Parekh';
  static const String title = 'Software Engineer(Mobile)';

  static const String email = String.fromEnvironment(
    EnvKeys.profileEmail,
    defaultValue: '',
  );

  static const String bio = '''Mobile Engineer with 3+ years of experience in building scalable, high-performance mobile applications across Flutter and native Android. Skilled in Dart, Kotlin, Java, REST API integration, state management, and clean architecture, with a strong focus on UI/UX best practices, performance optimization, and maintainable code.''';

  static const String githubUrl = String.fromEnvironment(
    EnvKeys.profileGithubUrl,
    defaultValue: '',
  );
  static const String linkedinUrl = String.fromEnvironment(
    EnvKeys.profileLinkedinUrl,
    defaultValue: '',
  );
  static const String instagramUrl = String.fromEnvironment(
    EnvKeys.profileInstagramUrl,
    defaultValue: '',
  );
  static const String resumeUrl = String.fromEnvironment(
    EnvKeys.profileResumeUrl,
    defaultValue: '',
  );
}

// ==================== SKILL CATEGORIES DATA ====================

final List<SkillCategoryModel> skillCategoriesData = [
  const SkillCategoryModel(
    categoryName: 'Mobile Development',
    categoryIcon: Icons.phone_android,
    categoryColor: Color(0xFF2196F3),
    skills: [
      'Flutter',
      'Dart',
      'Android',
      'Kotlin',
      'Java',
      'UI/UX Design',
      'Responsive Layouts',
    ],
  ),
  const SkillCategoryModel(
    categoryName: 'Architecture & Patterns',
    categoryIcon: Icons.architecture,
    categoryColor: Color(0xFF2196F3),
    skills: [
      'MVVM',
      'MVC',
      'BLoC',
      'Provider',
      'Clean Architecture',
      'State Management',
      'TDD',
      'OOP',
    ],
  ),
  const SkillCategoryModel(
    categoryName: 'Backend & Database',
    categoryIcon: Icons.cloud,
    categoryColor: Color(0xFF2196F3),
    skills: [
      'Node.js',
      'Express.js',
      'MongoDB',
      'Firebase',
      'REST API',
      'JWT Auth',
      'AWS',
    ],
  ),
  const SkillCategoryModel(
    categoryName: 'Tools & Libraries',
    categoryIcon: Icons.build,
    categoryColor: Color(0xFF2196F3),
    skills: [
      'Google Maps',
      'Payment Gateway',
      'Postman',
      'Git',
      'JIRA',
      'Android Studio',
      'VS Code',
    ],
  ),
  const SkillCategoryModel(
    categoryName: 'Software Engineering',
    categoryIcon: Icons.engineering,
    categoryColor: Color(0xFF2196F3),
    skills: [
      'Agile Methodology',
      'CI/CD',
      'GitHub Actions',
      'Modular Codebase',
    ],
  ),
];

// ==================== EXPERIENCE DATA ====================

final List<ExperienceModel> experienceData = [
  ExperienceModel(
    company: 'Tata Consultancy Services (TCS)',
    position: 'System Engineer',
    duration: '2022 - 2025',
    description: '',
    highlights: [
      'Delivered high-quality mobile applications using Flutter & Dart for government and client projects, ensuring cross-platform scalability and maintainability.',
      'Implemented secure RESTful API integrations for login, signup, and user management, including advanced features like biometric authentication.',
      'Improved software stability and performance for the MEDIAUSB feature in Nissan IVI Automotive systems by resolving critical bugs efficiently.',
      'Enhanced code quality and reliability by designing and refining UI test cases with Espresso, boosting module coverage by 5–10%.',
      'Collaborated effectively with onsite teams to implement feature enhancements, optimize processes, and ensure timely project delivery.',
    ],
    companyColor: Color(0xFF0076CE),
    isCurrent: false,
  ),
  ExperienceModel(
    company: '10X Export',
    position: 'Full Stack Mobile Developer',
    duration: '2025 - Present',
    description: '',
    highlights: [
      'Independently developed a robust Import-Export application using Flutter + BLoC with clean architecture, ensuring scalability and maintainability.',
      'Implemented secure user authentication and management leveraging Node.js, Express.js, MongoDB, and JWT, prioritizing data protection.',
      'Designed and integrated RESTful APIs, tested thoroughly with Postman to guarantee reliable and seamless backend communication.',
      'Managed the full project lifecycle, including requirement analysis, backend & frontend development, API integration, and testing.',
      'Delivered high-quality, scalable, and efficient cross-platform solutions, focusing on maintainable code and optimal performance.',
    ],
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
    techStack: ['Flutter', 'Dart', 'Gemini API', 'BLoC'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectGeminiBotGithubUrl,
      defaultValue: '',
    ),
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.smart_toy,
  ),
  const ProjectModel(
    name: 'Tasks-App-Flutter',
    description:
        'A beautiful and functional task management application with intuitive UI, local storage, and smooth animations.',
    techStack: ['Flutter', 'Dart', 'SQLite', 'Provider'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectTasksGithubUrl,
      defaultValue: '',
    ),
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.check_circle,
  ),
  const ProjectModel(
    name: 'Grocery-Shopping-App',
    description:
        'Complete grocery shopping solution with product catalog, cart management, and seamless checkout experience.',
    techStack: ['Flutter', 'Dart', 'Stripe', 'Provider'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectGroceryGithubUrl,
      defaultValue: '',
    ),
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.shopping_cart,
  ),
  const ProjectModel(
    name: 'EV-Charging-App',
    description:
        'Developed a modern, responsive EV Charging app in Flutter by converting a professional Figma design into dynamic, pixel-perfect screens. Integrated Google Sign-In, Light & Dark theme switching, and implemented clean, maintainable code for scalable cross-platform performance.',
    techStack: ['Flutter', 'Dart', 'Responsive', 'Firebase'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectEVsGithubUrl,
      defaultValue: '',
    ),
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.ev_station,
  ),
  const ProjectModel(
    name: 'Google Maps Integration',
    description:
        'Comprehensive Google Maps implementation showcasing markers, routes, location tracking, and custom styling.',
    techStack: ['Flutter', 'Dart', 'Google Maps SDK', 'Geolocator'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectGoogleMapGithubUrl,
      defaultValue: '',
    ),
    language: 'Dart',
    languageColor: AppColors.dartColor,
    icon: Icons.map,
  ),
  const ProjectModel(
    name: 'Authentication Backend',
    description:
        'Secure backend authentication system with JWT tokens, user management, and RESTful API endpoints.',
    techStack: ['Node.js', 'Express', 'JWT', 'MongoDB'],
    githubUrl: String.fromEnvironment(
      EnvKeys.projectAuthBackendGithubUrl,
      defaultValue: '',
    ),
    language: 'JavaScript',
    languageColor: AppColors.javascriptColor,
    icon: Icons.security,
  ),
];
