class AppConstants {
  static final RegExp emailRegEx = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

// static final RegExp mobileRegEx=RegExp(r'/^(?:\+?88|0088)?01[13-9]\d{8}$/');
  static final RegExp mobileRegEx = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');
}
