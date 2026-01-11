import '../models/project.dart';
import '../models/skill.dart';

class AppData {
  static const List<Skill> skills = [
    Skill(name: 'Flutter'),
    Skill(name: 'Dart'),
    Skill(name: 'Firebase Authentication'),
    Skill(name: 'Cloud Firestore'),
    Skill(name: 'Firebase Storage'),
    Skill(name: 'API Integration'),
    Skill(name: 'State Management (Provider)'),
    Skill(name: 'State Management (GetX)'),
    Skill(name: 'MVC / Clean Architecture'),
    Skill(name: 'Responsive UI Design'),
    Skill(name: 'Custom Widgets'),
    Skill(name: 'Material Design'),
    Skill(name: 'Git & GitHub'),
    Skill(name: 'Debugging & Error Handling'),
    Skill(name: 'Android Studio'),
    Skill(name: 'VS Code'),
    Skill(name: 'Postman'),
    // Skill(name: 'Figma (UI Implementation)'),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Chat App',
      description:
          'A simple real-time chat application that allows users to register, view other users, and exchange messages using Firebase backend.',
      technologies: ['Flutter', 'Firebase', 'Firestore', 'Firebase Storage'],
      imageUrl: 'https://picsum.photos/800/600?random=1',
      isAssetImage: true,
      githubUrl:
          'https://github.com/HasnainChd/chat-app-with-push-notfications',
    ),
    Project(
      title: 'E-Commerce App',
      description:
          'A full-featured e-commerce mobile application with product browsing, cart management, and payment integration.',
      technologies: ['Flutter', 'Provider', 'REST API', 'Stripe'],
      // imageUrl: 'assets/images/projects/project2.png',
      isAssetImage: true,
      githubUrl: 'https://github.com/HasnainChd/News-App',
    ),
    Project(
      title: 'Calculator App',
      description:
          'A simple calculator application for performing basic arithmetic operations with a clean and functional interface.',
      technologies: ['Flutter', 'Dart'],
      isAssetImage: true,
      githubUrl: 'https://github.com/HasnainChd/Calculator',
    ),
  ];
}
