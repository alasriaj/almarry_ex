class CurrencyInfo {
  final int currency;

  CurrencyInfo(this.currency) {
    switch (this.currency) {
      case 5:
        CurrencyID = 5;
        CurrencyCode = "SYP";
        IsCurrencyNameFeminine = true;
        EnglishCurrencyName = "Syrian Pound";
        EnglishPluralCurrencyName = "Syrian Pounds";
        EnglishCurrencyPartName = "Piaster";
        EnglishPluralCurrencyPartName = "Piasteres";
        Arabic1CurrencyName = "ليرة سورية";
        Arabic2CurrencyName = "ليرتان سوريتان";
        Arabic310CurrencyName = "ليرات سورية";
        Arabic1199CurrencyName = "ليرة سورية";
        Arabic1CurrencyPartName = "قرش";
        Arabic2CurrencyPartName = "قرشان";
        Arabic310CurrencyPartName = "قروش";
        Arabic1199CurrencyPartName = "قرشاً";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = false;
        break;
      case 4:
        CurrencyID = 4;
        CurrencyCode = "AED";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "AED Dirham";
        EnglishPluralCurrencyName = "AED Dirhams";
        EnglishCurrencyPartName = "Fils";
        EnglishPluralCurrencyPartName = "Fils";
        Arabic1CurrencyName = "درهم إماراتي";
        Arabic2CurrencyName = "درهمان إماراتيان";
        Arabic310CurrencyName = "دراهم إماراتية";
        Arabic1199CurrencyName = "درهماً إماراتياً";
        Arabic1CurrencyPartName = "فلس";
        Arabic2CurrencyPartName = "فلسان";
        Arabic310CurrencyPartName = "فلوس";
        Arabic1199CurrencyPartName = "فلساً";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = false;
        break;

      case 2:
        CurrencyID = 2;
        CurrencyCode = "SAR";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "Saudi Riyal";
        EnglishPluralCurrencyName = "Saudi Riyals";
        EnglishCurrencyPartName = "Halala";
        EnglishPluralCurrencyPartName = "Halalas";
        Arabic1CurrencyName = "ريال سعودي";
        Arabic2CurrencyName = "ريالان سعوديان";
        Arabic310CurrencyName = "ريالات سعودية";
        Arabic1199CurrencyName = "ريالاً سعودياً";
        Arabic1CurrencyPartName = "هللة";
        Arabic2CurrencyPartName = "هللتان";
        Arabic310CurrencyPartName = "هللات";
        Arabic1199CurrencyPartName = "هللة";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = true;
        break;
      case 1:
        CurrencyID = 1;
        CurrencyCode = "YER";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "Yemen Riyal";
        EnglishPluralCurrencyName = "Yemeni Riyals";
        EnglishCurrencyPartName = "Felce";
        EnglishPluralCurrencyPartName = "Floos";
        Arabic1CurrencyName = "ريال يمني";
        Arabic2CurrencyName = "ريالان يمني";
        Arabic310CurrencyName = "ريالات يمني";
        Arabic1199CurrencyName = "ريالاً يمني";
        Arabic1CurrencyPartName = "فلس";
        Arabic2CurrencyPartName = "فلسان";
        Arabic310CurrencyPartName = "فلوس";
        Arabic1199CurrencyPartName = "فلس";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = true;
        break;
      case 3:
        CurrencyID = 3;
        CurrencyCode = "USD";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "American Dollar";
        EnglishPluralCurrencyName = "American Dollars";
        EnglishCurrencyPartName = "Cent";
        EnglishPluralCurrencyPartName = "Money";
        Arabic1CurrencyName = "دولار امريكي";
        Arabic2CurrencyName = "دولاران امريكي";
        Arabic310CurrencyName = "دولارات امريكي";
        Arabic1199CurrencyName = "دولاراً امريكي";
        Arabic1CurrencyPartName = "سنت";
        Arabic2CurrencyPartName = "سنتان";
        Arabic310CurrencyPartName = "سنتات";
        Arabic1199CurrencyPartName = "سنت";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = true;
        break;
      case 0:
        CurrencyID = 0;
        CurrencyCode = "";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "";
        EnglishPluralCurrencyName = "";
        EnglishCurrencyPartName = "";
        EnglishPluralCurrencyPartName = "";
        Arabic1CurrencyName = "";
        Arabic2CurrencyName = "";
        Arabic310CurrencyName = "";
        Arabic1199CurrencyName = "";
        Arabic1CurrencyPartName = "";
        Arabic2CurrencyPartName = "";
        Arabic310CurrencyPartName = "";
        Arabic1199CurrencyPartName = "";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = true;
        break;

      case 6:
        CurrencyID = 6;
        CurrencyCode = "TND";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "Tunisian Dinar";
        EnglishPluralCurrencyName = "Tunisian Dinars";
        EnglishCurrencyPartName = "milim";
        EnglishPluralCurrencyPartName = "millimes";
        Arabic1CurrencyName = "دينار تونسي";
        Arabic2CurrencyName = "ديناران تونسيان";
        Arabic310CurrencyName = "دنانير تونسية";
        Arabic1199CurrencyName = "ديناراً تونسياً";
        Arabic1CurrencyPartName = "مليم";
        Arabic2CurrencyPartName = "مليمان";
        Arabic310CurrencyPartName = "ملاليم";
        Arabic1199CurrencyPartName = "مليماً";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = false;
        break;
      case 7:
        CurrencyID = 7;
        CurrencyCode = "XAU";
        IsCurrencyNameFeminine = false;
        EnglishCurrencyName = "Gram";
        EnglishPluralCurrencyName = "Grams";
        EnglishCurrencyPartName = "Milligram";
        EnglishPluralCurrencyPartName = "Milligrams";
        Arabic1CurrencyName = "جرام";
        Arabic2CurrencyName = "جرامان";
        Arabic310CurrencyName = "جرامات";
        Arabic1199CurrencyName = "جراماً";
        Arabic1CurrencyPartName = "ملجرام";
        Arabic2CurrencyPartName = "ملجرامان";
        Arabic310CurrencyPartName = "ملجرامات";
        Arabic1199CurrencyPartName = "ملجراماً";
        PartPrecision = 3;
        IsCurrencyPartNameFeminine = false;
        break;
    }
  }

  /// <summary>
  /// Currency ID
  /// </summary>
  int? CurrencyID;

  /// <summary>
  /// Standard Code
  /// Syrian Pound: SYP
  /// UAE Dirham: AED
  /// </summary>
  String? CurrencyCode;

  /// <summary>
  /// Is the currency name feminine ( Mua'anath مؤنث)
  /// ليرة سورية : مؤنث = true
  /// درهم : مذكر = false
  /// </summary>
  bool? IsCurrencyNameFeminine;

  /// <summary>
  /// English Currency Name for single use
  /// Syrian Pound
  /// UAE Dirham
  /// </summary>
  String? EnglishCurrencyName;

  /// <summary>
  /// English Plural Currency Name for Numbers over 1
  /// Syrian Pounds
  /// UAE Dirhams
  /// </summary>
  String? EnglishPluralCurrencyName;

  /// <summary>
  /// Arabic Currency Name for 1 unit only
  /// ليرة سورية
  /// درهم إماراتي
  /// </summary>
  String? Arabic1CurrencyName;

  /// <summary>
  /// Arabic Currency Name for 2 units only
  /// ليرتان سوريتان
  /// درهمان إماراتيان
  /// </summary>
  String? Arabic2CurrencyName;

  /// <summary>
  /// Arabic Currency Name for 3 to 10 units
  /// خمس ليرات سورية
  /// خمسة دراهم إماراتية
  /// </summary>
  String? Arabic310CurrencyName;

  /// <summary>
  /// Arabic Currency Name for 11 to 99 units
  /// خمس و سبعون ليرةً سوريةً
  /// خمسة و سبعون درهماً إماراتياً
  /// </summary>
  String? Arabic1199CurrencyName;

  /// <summary>
  /// Decimal Part Precision
  /// for Syrian Pounds: 2 ( 1 SP = 100 parts)
  /// for Tunisian Dinars: 3 ( 1 TND = 1000 parts)
  /// </summary>
  int? PartPrecision;

  /// <summary>
  /// Is the currency part name feminine ( Mua'anath مؤنث)
  /// هللة : مؤنث = true
  /// قرش : مذكر = false
  /// </summary>
  bool? IsCurrencyPartNameFeminine;

  /// <summary>
  /// English Currency Part Name for single use
  /// Piaster
  /// Fils
  /// </summary>
  String? EnglishCurrencyPartName;

  /// <summary>
  /// English Currency Part Name for Plural
  /// Piasters
  /// Fils
  /// </summary>
  String? EnglishPluralCurrencyPartName;

  /// <summary>
  /// Arabic Currency Part Name for 1 unit only
  /// قرش
  /// هللة
  /// </summary>
  String? Arabic1CurrencyPartName;

  /// <summary>
  /// Arabic Currency Part Name for 2 unit only
  /// قرشان
  /// هللتان
  /// </summary>
  String? Arabic2CurrencyPartName;

  /// <summary>
  /// Arabic Currency Part Name for 3 to 10 units
  /// قروش
  /// هللات
  /// </summary>
  String? Arabic310CurrencyPartName;

  /// <summary>
  /// Arabic Currency Part Name for 11 to 99 units
  /// قرشاً
  /// هللةً
  /// </summary>
  String? Arabic1199CurrencyPartName;
}
