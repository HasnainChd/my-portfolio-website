import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/skill_group.dart';

class AppData {
  static const String githubProfile = 'https://github.com/muhammadhasnain';

  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      title: '📱 Mobile',
      skills: [
        Skill(name: 'Flutter', icon: Icons.flutter_dash),
        Skill(name: 'Dart', icon: Icons.bolt_rounded),
      ],
    ),
    SkillGroup(
      title: '🔥 Backend',
      skills: [
        Skill(name: 'Firebase', icon: Icons.local_fire_department_outlined),
        Skill(name: 'Supabase', icon: Icons.storage_rounded),
        Skill(name: 'REST APIs', icon: Icons.api_rounded),
      ],
    ),
    SkillGroup(
      title: '🧠 State Management',
      skills: [
        Skill(name: 'Provider', icon: Icons.layers_outlined),
        Skill(name: 'GetX', icon: Icons.swap_horiz_rounded),
        Skill(name: 'Riverpod', icon: Icons.water_drop_outlined),
      ],
    ),
    SkillGroup(
      title: '🧪 Testing',
      skills: [
        Skill(name: 'Unit Tests', icon: Icons.science_outlined),
        Skill(name: 'Golden Tests', icon: Icons.photo_library_outlined),
      ],
    ),
    SkillGroup(
      title: '🚀 Deployment',
      skills: [
        Skill(name: 'Play Store', icon: Icons.shop_2_outlined),
        Skill(name: 'Flutter Web', icon: Icons.web_rounded),
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Tealpot',
      description:
          'A cross-platform mobile application with real-time features, built using Flutter and Firebase.',
      tagline: 'A cross-platform mobile app with real-time features',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST APIs',
      ],
      screenshotPaths: [
        'assets/images/projects/tealpot/screen1.jpeg',
        'assets/images/projects/tealpot/screen2.jpeg',
        'assets/images/projects/tealpot/screen3.jpeg',
        'assets/images/projects/tealpot/screen4.jpeg',
        'assets/images/projects/tealpot/screen5.jpeg',
        'assets/images/projects/tealpot/screen6.jpeg',
        'assets/images/projects/tealpot/screen7.jpeg',
      ],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.tealpot.tealpot&pcampaignid=web_share',
      githubUrl: null,
      keyFeatures: [
        'Real-time features with Firebase integration',
        'Clean and responsive UI across iOS & Android',
        'REST API integration',
        'Smooth user experience with Flutter animations',
      ],
    ),
    Project(
      title: 'ServicePro360',
      description:
          'A service management cross-platform mobile app built with Flutter, featuring clean architecture and REST API integration.',
      tagline: 'A service management solution built with Flutter',
      technologies: [
        'Flutter',
        'Dart',
        'REST APIs',
        'GetX',
      ],
      screenshotPaths: [
        'assets/images/projects/servicepro/screen1.jpeg',
        'assets/images/projects/servicepro/screen2.jpeg',
        'assets/images/projects/servicepro/screen3.jpeg',
        'assets/images/projects/servicepro/screen4.jpeg',
        'assets/images/projects/servicepro/screen5.jpeg',
      ],
      playStoreUrl: null,
      githubUrl: null,
      keyFeatures: [
        'Service management workflow for businesses',
        'Job and invoice tracking system',
        'Built with GetX state management',
        'REST API integration with clean architecture',
      ],
    ),
    Project(
      title: 'New Leaf',
      description:
          'A habit-tracking mobile app to help users leave marijuana, featuring progress tracking and motivational UI built with Flutter and Supabase.',
      tagline: 'A habit-tracking app for personal growth',
      technologies: [
        'Flutter',
        'Dart',
        'Supabase',
        'Provider',
      ],
      screenshotPaths: [
        'assets/images/projects/newleaf/screen1.jpeg',
        'assets/images/projects/newleaf/screen2.jpeg',
        'assets/images/projects/newleaf/screen3.jpeg',
        'assets/images/projects/newleaf/screen4.jpeg',
      ],
      playStoreUrl: null,
      githubUrl: null,
      keyFeatures: [
        'Habit tracking and progress monitoring',
        'Daily control center with journal and craving tracker',
        'Built with Supabase backend',
        'Motivational UI to support personal growth',
      ],
    ),
  ];
}
