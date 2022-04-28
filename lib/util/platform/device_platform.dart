import 'dart:io';

class DevicePlatform {
   /// If the app is being ran on Android, this is set to 'Google Fit'.
  /// Otherwise, this is set to 'Health App'.
  static final platformHealthName = Platform.isAndroid ? 'Google Fit' : 'Health App';

  /// The user is shown this set of instructions based on their platform.
  static final settingsPath = Platform.isAndroid
      ? 'To allow or remove access, go to:\n\nSettings -> Privacy -> Permission manager -> Physical activity -> myAPFP\n'
      : 'To allow or remove access, go to: \n\nSettings -> Privacy -> Health -> myAPFP\n';

  /// The user is shown this image based on their platform .   
  static final imagePath = Platform.isAndroid
      ? 'assets/images/sync_health_app.png'
      : 'assets/images/iosHealthPermissions.png';
}