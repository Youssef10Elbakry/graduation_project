class RecentTransaction{
  String avatarPath;
  String studentName;
  DateTime date;
  int amount;

  RecentTransaction({required this.avatarPath, required this.studentName, required this.date, required this.amount});


  factory RecentTransaction.fromJson(Map json){
    return RecentTransaction(avatarPath : json["student"]["profilePicture"],
      studentName: json["student"]["username"],
      date: DateTime.now(),
      amount: json["amount"]
    );


  }


}