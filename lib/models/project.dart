class Project {
  final String title;
  final String description;
  final String? tagline;
  final List<String> technologies;
  final String? imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final bool isAssetImage;
  final List<String> screenshotPaths;
  final String? playStoreUrl;
  final List<String> keyFeatures;

  const Project({
    required this.title,
    required this.description,
    this.tagline,
    required this.technologies,
    this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.isAssetImage = true,
    this.screenshotPaths = const [],
    this.playStoreUrl,
    this.keyFeatures = const [],
  });
}
