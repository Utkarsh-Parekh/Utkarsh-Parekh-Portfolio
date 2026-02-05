import 'package:flutter/material.dart';

class SkillCategoryModel {
  final String categoryName;
  final IconData categoryIcon;
  final Color categoryColor;
  final List<String> skills;

  const SkillCategoryModel({
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
    required this.skills,
  });
}

