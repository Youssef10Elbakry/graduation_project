class ChildModel{
  String profilePictureLink;
  String username;
  // String email;
  String id;

  factory ChildModel.fromJson(Map json){
    return ChildModel(
      profilePictureLink: json["profilePicture"],
      username: json['username'],
      // email: json['email'],
      id: json['_id']
    );
  }

  ChildModel({
      required this.profilePictureLink, required this.username, required this.id});
}