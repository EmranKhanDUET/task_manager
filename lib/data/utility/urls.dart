class Urls{
  static const String _baseUrls='https://task.teamrabbil.com/api/v1';
  static const String registration='$_baseUrls/registration';
  static const String login='$_baseUrls/login';
  static const String createTask='$_baseUrls/createTask';
  static const String _listTaskByStatus='$_baseUrls/listTaskByStatus';
  static const String newTask='$_listTaskByStatus/New';
  static const String completedTask='$_listTaskByStatus/Completed';
  static const String inProgressTask='$_listTaskByStatus/InProgress';
  static const String cancelledTask='$_listTaskByStatus/Cancelled';
  static const String taskStatusCount='$_baseUrls/taskStatusCount';


}