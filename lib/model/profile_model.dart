class ProfileModel {
  String id = "";
  String fullname = "";
  String imageUrl = "";
  DateTime createdTime = DateTime.fromMillisecondsSinceEpoch(0);

  ProfileModel.empty();

  ProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['\$id'];
    } catch (e) {}
    try {
      fullname = json['fullname'];
    } catch (e) {}
    try {
      createdTime = DateTime.fromMillisecondsSinceEpoch(json['createdTime']);
    } catch (e) {}
    try {
      imageUrl = json['imageUrl'];
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullname'] = fullname;
    data['createdTime'] = createdTime.millisecondsSinceEpoch;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
