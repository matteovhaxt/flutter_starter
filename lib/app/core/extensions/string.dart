extension EmailValidator on String {
  String? validateEmail() {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final isValid = RegExp(pattern).hasMatch(this);
    if (!isValid) {
      return 'Invalid Email';
    }
    return null;
  }

  bool isEmailValid() => validateEmail() == null;
}

extension PasswordValidator on String {
  String? validatePassword() {
    final patterns = {
      r'^(?=.*[A-Z])': 'Should contain at least one uppercase letter',
      r'^(?=.*[a-z])': 'Should contain at least one lowercase letter',
      r'^(?=.*?[0-9])': 'Should contain at least one digit',
      r'^(?=.*?[!@#\$&*~])': 'Should contain at least one special character',
      r'^.{8,}': 'Must be at least 8 characters in length'
    };

    for (var i in patterns.keys) {
      final isValid = RegExp(i).hasMatch(this);
      if (!isValid) {
        return patterns[i];
      }
    }
    return null;
  }

  bool isPasswordValid() => validatePassword() == null;
}
