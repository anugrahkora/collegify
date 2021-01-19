class UserModel {
  final String uid;

  UserModel({this.uid});
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
