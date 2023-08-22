class SessionStorage {
  static String userId = "";
  static String username = "";
  static String userEmail = "";
  static String userImage = "";

  void setUserInformation(String userId, String username, String userEmail, String userImage) {
    SessionStorage.userId = userId;
    SessionStorage.username = username;
    SessionStorage.userEmail = userEmail;
    SessionStorage.userImage = userImage;
  }
}
