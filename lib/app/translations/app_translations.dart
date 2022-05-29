import 'package:get/get.dart';

import '../../app/translations/ar_YE/ar_ye_translations.dart';
import '../../app/translations/en_US/en_us_translations.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'ar_YE': arYe};
}
