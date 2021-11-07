class User {
  late String _emailAddress;
  late String _hostel;

  User._();
  static User user = User._();

  static User get instance {
    return user;
  }

  String getEmailAddress() => _emailAddress;
  String getHostel() => _hostel;

  void setEmailAddress(String emailAddress) {
    _emailAddress = emailAddress;
  }

  void setHostel(String hostel) {
    _hostel = hostel;
  }
}
