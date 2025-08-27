class Habit {
  String id = "";
  String title = "";
  String description = "";
  String color = "";
  String reason = "";

  Habit.empty();

  Habit.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      title = json['title'];
    } catch (e) {}
    try {
      description = json['description'];
    } catch (e) {}
    try {
      color = json['color'];
    } catch (e) {}
    try {
      reason = json['reason'];
    } catch (e) {}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['color'] = color;
    data['reason'] = reason;
    return data;
  }
}
