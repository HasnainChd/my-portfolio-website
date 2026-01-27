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
  ];

  static const List<Project> projects = [
    Project(
      title: 'Chat App',
      description:
          'A simple real-time chat application that allows users to register, view other users, and exchange messages using Firebase backend.',
      technologies: ['Flutter', 'Firebase', 'Firestore', 'Firebase Storage'],
      imageUrl: null, // ✅ Change to null or use actual asset path
      isAssetImage: true,
      githubUrl: 'https://github.com/yourusername/chat-app',
    ),
    Project(
      title: 'E-Commerce App',
      description:
          'A full-featured e-commerce mobile application with product browsing, cart management, and payment integration.',
      technologies: ['Flutter', 'Provider', 'REST API', 'Stripe'],
      imageUrl: null, // ✅ Change to null
      isAssetImage: true,
      githubUrl: 'https://github.com/yourusername/ecommerce-app',
    ),
    Project(
      title: 'Weather App',
      description:
          'Real-time weather application with location-based forecasts and interactive maps.',
      technologies: ['Flutter', 'REST API', 'Geolocator', 'Dio'],
      imageUrl: null, // ✅ Change to null
      isAssetImage: true,
      githubUrl: 'https://github.com/yourusername/weather-app',
    ),
  ];
}
