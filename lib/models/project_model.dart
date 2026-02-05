import 'package:flutter/material.dart';

class ProjectModel {
  final String name;
  final String description;
  final List<String> techStack;
  final String githubUrl;
  final String language;
  final Color languageColor;
  final IconData icon;

  const ProjectModel({
    required this.name,
    required this.description,
    required this.techStack,
    required this.githubUrl,
    required this.language,
    required this.languageColor,
    required this.icon,
  });
}


