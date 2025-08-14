class TaskModel {
  String id;
  String userId;
  String title;
  String description;
  String category;
  int date;
  bool isFav;

  TaskModel({
    this.id = '',
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.isFav = false,
  });

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    String? category,
    int? date,
    bool? isFav,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      isFav: isFav ?? this.isFav,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'isFav': isFav,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      date: json['date'],
      isFav: json['isFav'] ?? false,
    );
  }
}
