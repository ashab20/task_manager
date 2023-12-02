class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";

  // Task
  static const String createTask = "$_baseUrl/createTask";
  static const String updateTaskStatus = "$_baseUrl/createTask";
  static const String deleteTask = "$_baseUrl/deleteTask/id";
  static const String taskListStatus = "$_baseUrl/listTaskByStatus";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";

}
