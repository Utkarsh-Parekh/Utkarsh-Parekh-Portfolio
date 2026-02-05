import 'package:flutter/material.dart';

class ExperienceModel {
  final String company;
  final String position;
  final String duration;
  final String description;
  final Color companyColor;
  final bool isCurrent;

  const ExperienceModel({
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.companyColor,
    this.isCurrent = false,
  });
}


