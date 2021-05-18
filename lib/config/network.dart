class Network {
  /// 测试服api接口请求地址【尽量不要使用(http://192.168.1.115:3000)做测试】
  static const List devApi = ['http://192.168.1.115:3000'];

  /// 正式服 api 接口地址
  static const List prodApi = ['http://192.168.1.115:3000'];

  /// 正式服 api 接口备用地址
  static const List prodGithubApi = ['http://192.168.1.115:3000'];

  /// TF 线路
  static String prodTFApi = '';

  /// TF 备用线路
  static String prodTFGithubApi = '';

  /// 图片拼接的域名
  static String pingImageHost = '';

  /// 上传图片 key
  static String uploadImageKey = '';

  /// 上传图片地址
  static String uploadImageUrl = '';

  /// 上传视频 key
  static String uploadVideoKey = '';

  /// 上传视频地址
  static String uploadVideoUrl = '';
}
