class Network {
  /// 定义
  /// [_api]正式服 api 接口地址【尽量不要使用(http://192.168.1.115:3000)做测试】
  /// [_githubApi]正式服 api 接口备用地址
  /// [_tfApi]正式服 tf 线路
  /// [_tfGithubApi]正式服 tf 备用线路
  /// [_imageHost]图片的域名
  /// [_uploadImageKey]上传图片 key
  /// [_uploadImageUrl]上传图片地址
  /// [_uploadVideoKey]上传视频 key
  /// [_uploadVideoUrl]上传视频地址
  static List<String> _api = [
    'http://127.0.0.1:3000',
    // 'http://192.168.1.114:3001',
    // 'http://192.168.1.114:3002',
    // 'http://192.168.1.114:3003',
  ];
  static String _githubApi =
      'https://raw.githubusercontent.com/zhangtanlin/zhong/1.0.0/github-prod-api.text?t=${DateTime.now().millisecondsSinceEpoch}';
  static String _tfApi = '';
  static String _tfGithubApi = '';
  static String _imageHost = 'http://192.168.1.114:3000';
  static String _uploadImageKey = '';
  static String _uploadImageUrl = '';
  static String _uploadVideoKey = '';
  static String _uploadVideoUrl = '';

  /// 获取
  static List<String> get api => _api;
  static String get githubApi => _githubApi;
  static String get tfApi => _tfApi;
  static String get tfGithubApi => _tfGithubApi;
  static String get imageHost => _imageHost;
  static String get uploadImageKey => _uploadImageKey;
  static String get uploadImageUrl => _uploadImageUrl;
  static String get uploadVideoKey => _uploadVideoKey;
  static String get uploadVideoUrl => _uploadVideoUrl;

  /// 设置
  static void setApi(List<String> param) {
    _api = param;
  }

  static void setGithubApi(String param) {
    _githubApi = param;
  }

  static void setTfApi(String param) {
    _tfApi = param;
  }

  static void setTfGithubApi(String param) {
    _tfGithubApi = param;
  }

  static void setImageHost(String param) {
    _imageHost = param;
  }

  static void setUploadImageKey(String param) {
    _uploadImageKey = param;
  }

  static void setUploadImageUrl(String param) {
    _uploadImageUrl = param;
  }

  static void setUploadVideoKey(String param) {
    _uploadVideoKey = param;
  }

  static void setUploadVideoUrl(String param) {
    _uploadVideoUrl = param;
  }
}
