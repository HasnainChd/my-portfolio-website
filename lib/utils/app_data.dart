import '../models/project.dart';
import '../models/skill.dart';

class AppData {
  static const List<Skill> skills = [
    Skill(name: 'Flutter'),
    Skill(name: 'Dart'),
    Skill(name: 'Firebase'),
    Skill(name: 'REST APIs'),
    Skill(name: 'Git & GitHub'),
    Skill(name: 'Provider'),
    Skill(name: 'SQLite'),
    Skill(name: 'Responsive Design'),
    Skill(name: 'Material Design'),
    Skill(name: 'Android Studio'),
    Skill(name: 'VS Code'),
    Skill(name: 'Figma'),
  ];

  static const List<Project> projects = [
    Project(
      title: 'E-Commerce App',
      description:
          'A full-featured e-commerce mobile application with product browsing, cart management, and payment integration.',
      technologies: ['Flutter', 'Firebase', 'Provider', 'Stripe'],
      githubUrl: 'https://github.com/yourusername/project1',
    ),
    Project(
      title: 'Weather App',
      description:
          'Real-time weather application with location-based forecasts, interactive maps, and weather alerts.',
      technologies: ['Flutter', 'REST API', 'Geolocator', 'Dio'],
      githubUrl: 'https://github.com/yourusername/project2',
    ),
    Project(
      title: 'Task Manager',
      description:
          'Productivity app for managing tasks and projects with categories, priorities, and deadline reminders.',
      technologies: ['Flutter', 'SQLite', 'Local Notifications'],
      githubUrl: 'https://github.com/yourusername/project3',
    ),
  ];
}
