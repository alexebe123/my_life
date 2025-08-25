class Habit {
  String id;
  String title;
  String description;
  String color;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color,
    };
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      color: json['color'],
    );
  }
}
