class UserModel {
  final String uid;
  final String email;

  UserModel({this.email, this.uid});
}

class StudentModel {
  final String name;
  final String uid;
  StudentModel({this.uid, this.name});
}

class AnnouncementModel {
  final String subject;
  final String announcement;

  AnnouncementModel({this.subject, this.announcement});
}
