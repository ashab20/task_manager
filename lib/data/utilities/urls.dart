

class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";

  // Task
  static const String createTask = "$_baseUrl/createTask";
  static const String taskListStatus = "$_baseUrl/listTaskByStatus";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static String deleteTask(id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskStatus(String id, String status) =>
      '$_baseUrl/updateTaskStatus/$id/$status';

  static String verifyEmail(String mail) =>
      '$_baseUrl/RecoverVerifyEmail/$mail';

  static String verifyPin(mail,pin) =>
      '$_baseUrl/RecoverVerifyOTP/$mail/$pin';
  static const String resetPass = '$_baseUrl/RecoverResetPass';

}
