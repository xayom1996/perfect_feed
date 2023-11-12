String googleMapKey = 'AIzaSyDMbQZxtmIVjHRJxW2pmPyh2SkhZMwmpsI';

class Instagram {
  /// [clientID], [appSecret], [redirectUri] from your facebook developer basic display panel.
  /// [scope] choose what kind of data you're wishing to get.
  /// [responseType] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  /// [url] simply the url used to communicate with Instagram API at the beginning.
  static const String clientID = '1034121444402758';

  static const String appSecret = 'f3ecc163bdc61a536e0d2b4be15cfd04';

  static const String redirectUri = 'https://www.google.com/';
  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';
  static const String url = 'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=$scope&response_type=$responseType';

  /// Presets your required fields on each call api.
  /// Please refers to https://developers.facebook.com/docs/instagram-basic-display-api/reference .
  List<String> userFields = ['id', 'username', 'media_count'];
  List<String> mediasListFields = ['id', 'caption'];
  List<String> mediaFields = [
    // 'id',
    // 'caption',
    'media_type',
    'media_url',
    'thumbnail_url',
    'is_shared_to_feed',
    // 'username',
    'timestamp'
  ];

  String getUrl() {
    return 'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=$scope&response_type=$responseType';
  }

  String getRedirectUrl() {
    return redirectUri;
  }

  String getClientID() {
    return clientID;
  }

  String getAppSecret() {
    return appSecret;
  }
}