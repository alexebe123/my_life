class Habit {
  String id;
  String title;
  String description;
  String color;
  String reason;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
      'reason': reason,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      color: json['color'],
      reason: json['reason'],
    );
  }
}
