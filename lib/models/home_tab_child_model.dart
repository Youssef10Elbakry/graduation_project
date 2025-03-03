class HomeTabChildModel{
  String profilePictureLink;
  String username;
  String email;
  String id;

  factory HomeTabChildModel.fromJson(Map json){
    return HomeTabChildModel(
      profilePictureLink: json["profilePicture"],
      username: json['username'],
      email: json['email'],
      id: json['_id']
    );
  }

  HomeTabChildModel({
      required this.profilePictureLink, required this.username, required this.email, required this.id});
}