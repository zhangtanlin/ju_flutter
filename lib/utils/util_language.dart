/// 语言枚举
enum Language {
  hans, // 简体
  hant, // 繁体
}

/// 语言文字
///
/// 字体：[hans]表示简体，[hant]表示繁体
class LanguageText {
  static const Map<String, String> hant = {
    /// 公共文本
    'weixin': '微信',
    'tips': '提示',
    'weibo': '微博',
    'qq': 'QQ',
    'another': '其他',
    'send': '發送',
    'noData': '沒有數據～',
    'loadingData': '數據加載中',
    'noMsg': '沒有消息～',
    'netError': '獲取數據失敗',
    'pageJumpError': '你可能穿越到火星上了吧～',
    'entryApp': '進入app',
    'updateSuccess': '更新成功',
    'updateFailed': '更新失敗',
    'appName': 'pilipili',
    'pingLines': '探測線路中',
    'againRequest': '再次獲取',
    'noMsgData': '沒有反饋信息～',
    'photoLock': '相冊權限沒有打開～',
    'known': '知道了',
    'close': '關閉',
    'jumpError': '跳轉失敗',
    'followFailed': '關注失敗',

    /// 底部导航
    'home': '首頁',
    'find': '發現',
    'mine': '我的',

    /// 视频播放器
    'videoError': '錯誤',
  };

  static const Map<String, String> hans = {
    /// 公共文本
    'weixin': '微信',
    'tips': '提示',
    'weibo': '微博',
    'qq': 'QQ',
    'another': '其他',
    'send': '发送',
    'noData': '没有数据～',
    'loadingData': '数据加载中',
    'noMsg': '没有消息～',
    'netError': '获取数据失败',
    'pageJumpError': '你可能穿越到火星上了吧～',
    'entryApp': '进入app',
    'updateSuccess': '更新成功',
    'updateFailed': '更新失败',
    'appName': 'pilipili',
    'pingLines': '探测线路中',
    'againRequest': '再次获取',
    'noMsgData': '沒有反馈信息～',
    'photoLock': '相册权限没有打开～',
    'known': '知道了',
    'close': '关闭',
    'jumpError': '跳转失败',
    'followFailed': '关注失败',

    /// 底部导航
    'home': '首页',
    'find': '发现',
    'mine': '我的',

    /// 视频播放器
    'videoError': '错误',
  };
}

/// 语言
class UtilLanguage {
  /// 定义
  static Language _language = Language.hans; // 默认语言-中文简体
  static Map<String, String> _localeLanguage = LanguageText.hans; // 默认语言文字-中文简体

  /// 设置
  static void setLocalLanguage(Language localeLanguage) {
    switch (localeLanguage) {
      case Language.hant:
        _localeLanguage = LanguageText.hant;
        _language = Language.hant;
        break;
      case Language.hans:
        _localeLanguage = LanguageText.hans;
        _language = Language.hans;
        break;
      default:
        _localeLanguage = LanguageText.hans;
        _language = Language.hans;
        break;
    }
  }

  /// 公用文字获取
  static Map<String, String> get localeLanguage => _localeLanguage;
  static Language get language => _language;
  static String get weixin => _localeLanguage['weixin'];
  static String get tips => _localeLanguage['tips'];
  static String get weibo => _localeLanguage['weibo'];
  static String get qq => _localeLanguage['qq'];
  static String get another => _localeLanguage['another'];
  static String get send => _localeLanguage['send'];
  static String get noData => _localeLanguage['noData'];
  static String get loadingData => _localeLanguage['loadingData'];
  static String get netError => _localeLanguage['netError'];
  static String get noMsg => _localeLanguage['noMsg'];
  static String get pageJumpError => _localeLanguage['pageJumpError'];
  static String get entryApp => _localeLanguage['entryApp'];
  static String get updateSuccess => _localeLanguage['updateSuccess'];
  static String get updateFailed => _localeLanguage['updateFailed'];
  static String get appName => _localeLanguage['appName'];
  static String get pingLines => _localeLanguage['pingLines'];
  static String get againRequest => _localeLanguage['againRequest'];
  static String get noMsgData => _localeLanguage['noMsgData'];
  static String get photoLock => _localeLanguage['photoLock'];
  static String get known => _localeLanguage['known'];
  static String get close => _localeLanguage['close'];
  static String get jumpError => _localeLanguage['jumpError'];
  static String get followFailed => _localeLanguage['followFailed'];

  /// 底部导航
  static String get home => _localeLanguage['home'];
  static String get find => _localeLanguage['find'];
  static String get mine => _localeLanguage['mine'];

  /// 视频播放器
  static String get videoError => _localeLanguage['videoError']; // video
}
