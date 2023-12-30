class AppValidators {
  static RegExp emailValidator =
      RegExp(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$');
  static RegExp emailHeadValidator = RegExp(r'^(?=.*[a-zA-Z])\d*.*');
  static RegExp nameValidator = RegExp(r'^(?!\s)[a-zA-Z\s]+$');
}
