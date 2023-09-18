


class MyUtils {
  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  static int sum(int a, int b) {
    return a + b;
  }

  String processPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("+2540") && phoneNumber.length > 13) {
      return phoneNumber.replaceFirst("+2540", "+254");
    } else if (phoneNumber.startsWith("0") && phoneNumber.length > 9) {
      return phoneNumber.substring(1);
    }
    return phoneNumber;
  }

  String isStrongPassword(String password) {
    // Check the length of the password
    if (password.length < 4) {
      return 'Password should be at least 4 characters long.';
    }

    // // Check for uppercase letters
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password should contain at least one uppercase letter.';
    // }

    // // Check for lowercase letters
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return 'Password should contain at least one lowercase letter.';
    // }

    // // Check for numbers
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return 'Password should contain at least one number.';
    // }

    // // Check for special characters
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Password should contain at least one special character.';
    // }

    // The password is strong
    return '';
  }

}
