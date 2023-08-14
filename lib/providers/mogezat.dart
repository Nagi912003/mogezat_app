import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Mogezat with ChangeNotifier {

  Box box = Hive.box('box');
  String type = '';

  void setType(String type){
    this.type = type;
    box.put('type', type);
    notifyListeners();
  }

  final _items = [
    'assets/images/IMG-20230805-WA0001.jpg',
    'assets/images/IMG-20230805-WA0002.jpg',
    'assets/images/IMG-20230805-WA0003.jpg',
    'assets/images/IMG-20230805-WA0004.jpg',
    'assets/images/IMG-20230805-WA0006.jpg',
    'assets/images/IMG-20230805-WA0007.jpg',
    'assets/images/IMG-20230805-WA0008.jpg',
    'assets/images/IMG-20230805-WA0009.jpg',
    'assets/images/IMG-20230805-WA0010.jpg',
    'assets/images/IMG-20230805-WA0011.jpg',
    'assets/images/IMG-20230805-WA0012.jpg',
    'assets/images/IMG-20230805-WA0013.jpg',
    'assets/images/IMG-20230805-WA0014.jpg',
    'assets/images/IMG-20230805-WA0015.jpg',
    'assets/images/IMG-20230805-WA0016.jpg',
    'assets/images/IMG-20230805-WA0017.jpg',
    'assets/images/IMG-20230805-WA0018.jpg',
    'assets/images/IMG-20230805-WA0019.jpg',
    'assets/images/IMG-20230805-WA0020.jpg',
    'assets/images/IMG-20230805-WA0021.jpg',
    'assets/images/IMG-20230805-WA0022.jpg',
    'assets/images/IMG-20230805-WA0023.jpg',
    'assets/images/IMG-20230805-WA0024.jpg',
    'assets/images/IMG-20230805-WA0025.jpg',
    'assets/images/IMG-20230805-WA0026.jpg',
    'assets/images/IMG-20230805-WA0027.jpg',
    'assets/images/IMG-20230805-WA0028.jpg',
    'assets/images/IMG-20230805-WA0029.jpg',
    'assets/images/IMG-20230805-WA0030.jpg',
    'assets/images/IMG-20230805-WA0031.jpg',
    'assets/images/IMG-20230805-WA0032.jpg',
    'assets/images/IMG-20230805-WA0033.jpg',
    'assets/images/IMG-20230805-WA0034.jpg',
    'assets/images/IMG-20230805-WA0035.jpg',
    'assets/images/IMG-20230805-WA0036.jpg',
    'assets/images/IMG-20230805-WA0038.jpg',
    'assets/images/IMG-20230805-WA0039.jpg',
    'assets/images/IMG-20230805-WA0040.jpg',
    'assets/images/IMG-20230805-WA0041.jpg',
    'assets/images/IMG-20230805-WA0042.jpg',
    'assets/images/IMG-20230805-WA0043.jpg',
    'assets/images/IMG-20230805-WA0044.jpg',
    'assets/images/IMG-20230805-WA0045.jpg',
    'assets/images/IMG-20230805-WA0046.jpg',
    'assets/images/IMG-20230805-WA0047.jpg',
    'assets/images/IMG-20230805-WA0048.jpg',
    'assets/images/IMG-20230805-WA0049.jpg',
    'assets/images/IMG-20230805-WA0050.jpg',
    'assets/images/IMG-20230805-WA0051.jpg',
    'assets/images/IMG-20230805-WA0052.jpg',
    'assets/images/IMG-20230805-WA0053.jpg',
    'assets/images/IMG-20230805-WA0054.jpg',
    'assets/images/IMG-20230805-WA0055.jpg',
    'assets/images/IMG-20230805-WA0056.jpg',
    'assets/images/IMG-20230805-WA0057.jpg',
    'assets/images/IMG-20230805-WA0058.jpg',
    'assets/images/IMG-20230805-WA0059.jpg',
    'assets/images/IMG-20230805-WA0060.jpg',
    'assets/images/IMG-20230805-WA0061.jpg',
    'assets/images/IMG-20230805-WA0062.jpg',
    'assets/images/IMG-20230805-WA0063.jpg',
    'assets/images/IMG-20230805-WA0064.jpg',
    'assets/images/IMG-20230805-WA0065.jpg',
    'assets/images/IMG-20230805-WA0066.jpg',
    'assets/images/IMG-20230805-WA0067.jpg',
    'assets/images/IMG-20230805-WA0068.jpg',
    'assets/images/IMG-20230805-WA0069.jpg',
    'assets/images/IMG-20230805-WA0070.jpg',
    'assets/images/IMG-20230805-WA0071.jpg',
    'assets/images/IMG-20230805-WA0072.jpg',
    'assets/images/IMG-20230805-WA0073.jpg',
    'assets/images/IMG-20230805-WA0074.jpg',
    'assets/images/IMG-20230805-WA0075.jpg',
    'assets/images/IMG-20230805-WA0076.jpg',
    'assets/images/IMG-20230805-WA0077.jpg',
    'assets/images/IMG-20230805-WA0078.jpg',
    'assets/images/IMG-20230805-WA0079.jpg',
    'assets/images/IMG-20230805-WA0080.jpg',
    'assets/images/IMG-20230805-WA0081.jpg',
    'assets/images/IMG-20230805-WA0082.jpg',
    'assets/images/IMG-20230805-WA0083.jpg',
    'assets/images/IMG-20230805-WA0084.jpg',
    'assets/images/IMG-20230805-WA0085.jpg',
    'assets/images/IMG-20230805-WA0086.jpg',
    'assets/images/IMG-20230805-WA0087.jpg',
    'assets/images/IMG-20230805-WA0088.jpg',
    'assets/images/IMG-20230805-WA0089.jpg',
    'assets/images/IMG-20230805-WA0090.jpg',
    'assets/images/IMG-20230805-WA0091.jpg',
    'assets/images/IMG-20230805-WA0092.jpg',
    'assets/images/IMG-20230805-WA0093.jpg',
    'assets/images/IMG-20230805-WA0094.jpg',
    'assets/images/IMG-20230805-WA0095.jpg',
    'assets/images/IMG-20230805-WA0096.jpg',
    'assets/images/IMG-20230805-WA0097.jpg',
    'assets/images/IMG-20230805-WA0098.jpg',
    'assets/images/IMG-20230805-WA0099.jpg',
    'assets/images/IMG-20230805-WA0100.jpg',
    'assets/images/IMG-20230805-WA0102.jpg',
    'assets/images/IMG-20230805-WA0104.jpg',
  ];

  get items => [..._items];

  List getItems (){
    type = box.get('type', defaultValue: '');
    if(type == 'English  عربي'){
      return ar_en;
    }
    if(type == 'chinese'){
      return chinese;
    }
    if(type == 'english'){
      return english;
    }
    if(type == 'french'){
      return french;
    }
    if(type == 'german'){
      return german;
    }
    if(type == 'italy'){
      return italy;
    }
    if(type == 'indonesian'){
      return indonesian;
    }
    if(type == 'russian'){
      return russian;
    }
    if(type == 'filipino'){
      return tagalog;
    }
    if(type == 'turkish'){
      return turkish;
    }
    return [..._items];
  }

  String getAppName() {
    Map<String, String> appNames = {
      'العربية': 'لمحـــة',
      'English  عربي': 'Lamha',
      'chinese': 'Lánhù',
      'english': 'Lamha',
      'french': 'Lamha',
      'german': 'Lamha',
      'italy': 'Lamha',
      'indonesian': 'Lamha',
      'russian': 'Lamha',
      'filipino': 'Lamha',
      'turkish': 'Lamha',
    };

    return appNames[type] ?? 'لمحـــة';
  }
  String getLangsButtonTitle() {
    Map<String, String> appNames = {
      'العربية': 'لغات',
      'English  عربي': 'languages',
      'chinese': 'languages',
      'english': 'languages',
      'french': 'languages',
      'german': 'languages',
      'italy': 'languages',
      'indonesian': 'languages',
      'russian': 'languages',
      'filipino': 'languages',
      'turkish': 'languages',
    };

    return appNames[type] ?? 'لغات';
  }


  String getSharePhotoButtonTitle() {
    Map<String, String> buttonTitles = {
      'العربية': 'مشاركة الصورة',
      'English  عربي': 'Share the photo',
      'chinese': '分享照片',
      'english': 'Share the photo',
      'french': 'Partagez la photo',
      'german': 'Teilen Sie das Foto',
      'italy': 'Condividi la foto',
      'indonesian': 'Bagikan fotonya',
      'russian': 'Поделитесь фото',
      'filipino': 'Ibahagi ang larawan',
      'turkish': 'fotoğrafı paylaş',
    };

    return buttonTitles[type] ?? 'مشاركة الصورة';
  }
  String getShareAppButtonTitle() {
    Map<String, String> buttonTitles = {
      'العربية': 'مشاركة التطبيق',
      'English  عربي': 'Share the app',
      'chinese': '分享应用程序',
      'english': 'Share the app',
      'french': 'Partager l\'application',
      'german': 'Teilen Sie die App',
      'italy': 'Condividi l\'app',
      'indonesian': 'Bagikan aplikasi',
      'russian': 'Поделитесь приложением',
      'filipino': 'Ibahagi ang app',
      'turkish': 'uygulamayı paylaş',
    };

    return buttonTitles[type] ?? 'مشاركة التطبيق';
  }


  final ar_en = [
    'assets/images/the_10_langs/ar_en/ar_en_1.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_2.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_3.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_4.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_5.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_6.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_7.jpg',
    'assets/images/the_10_langs/ar_en/ar_en_8.jpg',
  ];

  final chinese = [
    'assets/images/the_10_langs/chinese/chinese_1.jpg',
    'assets/images/the_10_langs/chinese/chinese_2.jpg',
    'assets/images/the_10_langs/chinese/chinese_3.jpg',
    'assets/images/the_10_langs/chinese/chinese_4.jpg',
    'assets/images/the_10_langs/chinese/chinese_5.jpg',
    'assets/images/the_10_langs/chinese/chinese_6.jpg',
    'assets/images/the_10_langs/chinese/chinese_7.jpg',
    'assets/images/the_10_langs/chinese/chinese_8.jpg',
  ];

  final english = [
    'assets/images/the_10_langs/english/english_1.jpg',
    'assets/images/the_10_langs/english/english_2.jpg',
    'assets/images/the_10_langs/english/english_3.jpg',
    'assets/images/the_10_langs/english/english_4.jpg',
    'assets/images/the_10_langs/english/english_5.jpg',
    'assets/images/the_10_langs/english/english_6.jpg',
    'assets/images/the_10_langs/english/english_7.jpg',
    'assets/images/the_10_langs/english/english_8.jpg',
  ];

  final french = [
    'assets/images/the_10_langs/french/french_1.jpg',
    'assets/images/the_10_langs/french/french_2.jpg',
    'assets/images/the_10_langs/french/french_3.jpg',
    'assets/images/the_10_langs/french/french_4.jpg',
    'assets/images/the_10_langs/french/french_5.jpg',
    'assets/images/the_10_langs/french/french_6.jpg',
    'assets/images/the_10_langs/french/french_7.jpg',
    'assets/images/the_10_langs/french/french_8.jpg',
  ];

  final german = [
    'assets/images/the_10_langs/german/german_1.jpg',
    'assets/images/the_10_langs/german/german_2.jpg',
    'assets/images/the_10_langs/german/german_3.jpg',
    'assets/images/the_10_langs/german/german_4.jpg',
    'assets/images/the_10_langs/german/german_5.jpg',
    'assets/images/the_10_langs/german/german_6.jpg',
    'assets/images/the_10_langs/german/german_7.jpg',
    'assets/images/the_10_langs/german/german_8.jpg',
  ];

  final indonesian = [
    'assets/images/the_10_langs/indonesian/indonesian_1.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_2.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_3.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_4.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_5.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_6.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_7.jpg',
    'assets/images/the_10_langs/indonesian/indonesian_8.jpg',
  ];

  final italy = [
    'assets/images/the_10_langs/italy/italy_1.jpg',
    'assets/images/the_10_langs/italy/italy_2.jpg',
    'assets/images/the_10_langs/italy/italy_3.jpg',
    'assets/images/the_10_langs/italy/italy_4.jpg',
    'assets/images/the_10_langs/italy/italy_5.jpg',
    'assets/images/the_10_langs/italy/italy_6.jpg',
    'assets/images/the_10_langs/italy/italy_7.jpg',
    'assets/images/the_10_langs/italy/italy_8.jpg',
  ];

  final russian = [
    'assets/images/the_10_langs/russian/russian_1.jpg',
    'assets/images/the_10_langs/russian/russian_2.jpg',
    'assets/images/the_10_langs/russian/russian_3.jpg',
    'assets/images/the_10_langs/russian/russian_4.jpg',
    'assets/images/the_10_langs/russian/russian_5.jpg',
    'assets/images/the_10_langs/russian/russian_6.jpg',
    'assets/images/the_10_langs/russian/russian_7.jpg',
    'assets/images/the_10_langs/russian/russian_8.jpg',
  ];

  final tagalog = [
    'assets/images/the_10_langs/tagalog/tagalog_1.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_2.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_3.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_4.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_5.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_6.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_7.jpg',
    'assets/images/the_10_langs/tagalog/tagalog_8.jpg',
  ];

  final turkish = [
    'assets/images/the_10_langs/turkish/turkish_1.jpg',
    'assets/images/the_10_langs/turkish/turkish_2.jpg',
    'assets/images/the_10_langs/turkish/turkish_3.jpg',
    'assets/images/the_10_langs/turkish/turkish_4.jpg',
    'assets/images/the_10_langs/turkish/turkish_5.jpg',
    'assets/images/the_10_langs/turkish/turkish_6.jpg',
    'assets/images/the_10_langs/turkish/turkish_7.jpg',
    'assets/images/the_10_langs/turkish/turkish_8.jpg',
  ];
}
