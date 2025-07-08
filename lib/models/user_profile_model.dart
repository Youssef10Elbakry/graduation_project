class UserProfile {
  final String fullName;
  final String age;
  final String numberOfChildren;
  final String phoneNumber;
  final String email;
  final String profilePhoto; // Add this field


  UserProfile({
    required this.fullName,
    required this.age,
    required this.numberOfChildren,
    required this.phoneNumber,
    required this.email,
    required this.profilePhoto, // Initialize it
  });

  // Factory constructor to create an instance of UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserProfile(
      fullName: json["parent"]['username'] ?? '',
      age: json["parent"]['age'].toString() ?? '',
      numberOfChildren: json["parent"]['numberOfChildren'].toString() ?? '',
      phoneNumber: json["parent"]['phoneNumber'] ?? '',
      email: json["parent"]['email'] ?? '',
      profilePhoto: json["parent"]['profilePicture'] ?? '', // Parse the photo link
    );
  }
}
