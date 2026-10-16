class StatusData {
  final String id;
  final String name;
  final String videoUrl;
  final String description;
  final String createdAt;
  final String updatedAt;

  StatusData({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
      id: json['id'],
      name: json['name'],
      videoUrl: json['video_url'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
