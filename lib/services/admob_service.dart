import 'dart:io';

class AdmobService {
  String getAddMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6532924093541388~9391147666';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6532924093541388~9332325962';
    }
    return null;
  }

  String getBannerAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-6532924093541388/2002831982';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-6532924093541388/4063972823';
    }
    return null;
  }

}