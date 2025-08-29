class Habit {
  String id = "";
  String title = "";
  String description = "";
  String color = "";
  String reason = "";
  DateTime dateCreated = DateTime.now();
  bool state = false;

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
    try {
      dateCreated = DateTime.fromMillisecondsSinceEpoch(
        json['createdAt'] as int,
      );
    } catch (e) {}
    try {
      state = json['state'];
    } catch (e) {}
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['color'] = color;
    data['reason'] = reason;
    data['dateCreated'] = dateCreated.millisecondsSinceEpoch;
    data['state'] = state;
    return data;
  }
}
