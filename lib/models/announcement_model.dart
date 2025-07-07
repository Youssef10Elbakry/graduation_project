class AnnouncementModel{
  String id;
  String parent;
  String title;
  String message;
  DateTime createdAt;
  AnnouncementModel({required this.id, required this.title, required this.message, required this.parent, required this.createdAt});

  factory AnnouncementModel.fromJson(Map json){
    return AnnouncementModel(
        id: json['_id'],
        parent: json['parent'],
        title: json['title'],
        message: json['message'],
        createdAt: DateTime.parse(json['createdAt']).toLocal().add(const Duration(hours: 1)),
    );
  }
}