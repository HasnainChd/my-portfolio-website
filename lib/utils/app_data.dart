import 'package:flutter/material.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/skill_group.dart';

class AppData {
  static const String githubProfile = 'https://github.com/Muhammad-Hasnain67';

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
      title: 'Equally',
      description:
          'A smart bill-splitting & group expense tracking app built to settle expenses easily among friends and roommates.',
      tagline: 'Split bills & expenses effortlessly with friends',
      technologies: [
        'Flutter',
        'Dart',
        'Supabase',
        'Riverpod',
        'ML Kit',
      ],
      screenshotPaths: [
        'assets/images/projects/equally/screen1.png',
        'assets/images/projects/equally/screen2.png',
        'assets/images/projects/equally/screen3.png',
        'assets/images/projects/equally/screen4.png',
        'assets/images/projects/equally/screen5.png',
        'assets/images/projects/equally/screen6.png',
      ],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.devorastudios.equally&pcampaignid=web_share',
      githubUrl: null,
      keyFeatures: [
        'Group creation and seamless bill expense splitting',
        'Smart OCR receipt scanning with Google ML Kit',
        'Real-time balance tracking and settlement calculations',
        'PDF expense report generation & export',
        'Deep link join flows for easy group invites',
        'Flutter UI with Supabase backend and Riverpod state management',
      ],
    ),
    Project(
      title: 'StudyCoach AI',
      description:
          'An AI-powered study companion designed to optimize student learning with personalized coaching and study tools.',
      tagline: 'Your AI-powered personal study tutor & learning assistant',
      technologies: [
        'Flutter',
        'Dart',
        'AI / LLM',
        'REST APIs',
        'Provider',
      ],
      screenshotPaths: [
        'assets/images/projects/studycoach/screen1.png',
        'assets/images/projects/studycoach/screen2.png',
        'assets/images/projects/studycoach/screen3.png',
        'assets/images/projects/studycoach/screen4.png',
        'assets/images/projects/studycoach/screen5.png',
      ],
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.devorastudios.studycoach&pcampaignid=web_share',
      githubUrl: null,
      keyFeatures: [
        'AI-driven personalized study coaching & learning plans',
        'Interactive topic breakdown and study quizzes',
        'Smart flashcard and note summary generation',
        'Progress tracking and performance analytics',
        'Built with Flutter, AI/LLM integration, and REST APIs',
      ],
    ),
    Project(
      title: 'Tealpot',
      description:
          'A platform connecting businesses with vetted blue-collar professionals on demand, built with Flutter.',
      tagline: 'Connecting businesses with skilled blue-collar workers',
      technologies: [
        'Flutter',
        'Dart',
        'Provider',
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
        'Business and worker matching platform',
        'Background-checked and vetted professional profiles',
        'Real-time job posting and application system',
        'Responsive UI across iOS and Android',
        'Firebase integration for real-time data',
        'REST API integration with clean architecture',
      ],
    ),
    Project(
      title: 'ServicePro360',
      description:
          'A field service management app for managing jobs, quotes, invoices and field workers — similar to Jobber.',
      tagline: 'Complete field service management in your pocket',
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
        'Job and work order management',
        'Quote and invoice generation and tracking',
        'Field worker assignment and scheduling',
        'Workflow overview dashboard with real-time stats',
        'Requests, approvals and status tracking',
        'Built with Flutter, GetX and REST API integration',
      ],
    ),
    Project(
      title: 'New Leaf',
      description:
          'A habit-tracking app to help users quit marijuana, with mood tracking, journaling, and daily progress tools.',
      tagline: 'Your gentle guide to a marijuana-free lifestyle',
      technologies: [
        'Flutter',
        'Dart',
        'Supabase',
        'GetX',
      ],
      screenshotPaths: [
        'assets/images/projects/newleaf/screen1.jpeg',
        'assets/images/projects/newleaf/screen2.jpeg',
        'assets/images/projects/newleaf/screen3.jpeg',
        'assets/images/projects/newleaf/screen4.jpeg',
        'assets/images/projects/newleaf/screen5.jpeg',
        'assets/images/projects/newleaf/screen6.jpeg',
      ],
      playStoreUrl: null,
      githubUrl: null,
      keyFeatures: [
        'Daily progress tracker with streak and percentage',
        'Mood tracking to monitor emotional patterns',
        'Journal & Reflect — daily motivational journaling',
        'Craving tracker to identify and manage triggers',
        'Workbook with guided exercises (Why I smoke, Why I want to quit)',
        'Daily control center — Journal, Craving, Consumption tracking',
        'Built with Flutter and Supabase backend',
      ],
    ),
  ];
}
