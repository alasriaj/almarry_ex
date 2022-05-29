import 'CurrencyInfo.dart';

class ToWord {
  /// Group Levels: 987,654,321.234
  /// 234 : Group Level -1
  /// 321 : Group Level 0
  /// 654 : Group Level 1
  /// 987 : Group Level 2

  /// <summary>
  /// integer part
  /// </summary>
  double? _intergerValue;

  /// <summary>
  /// Decimal Part
  /// </summary>
  int? _decimalValue;

  /// <summary>
  /// Number to be converted
  /// </summary>
  double? Number;

  /// <summary>
  /// Currency to use
  /// </summary>
  CurrencyInfo? Currency;

  /// <summary>
  /// English text to be placed before the generated text
  /// </summary>
  String? EnglishPrefixText;

  /// <summary>
  /// English text to be placed after the generated text
  /// </summary>
  String? EnglishSuffixText;

  /// <summary>
  /// Arabic text to be placed before the generated text
  /// </summary>
  String? ArabicPrefixText;

  /// <summary>
  /// Arabic text to be placed after the generated text
  /// </summary>
  String? ArabicSuffixText;

  // #endregion
  //
  // #region General

  // ToWord(this.number, this.currencyv);

  /// <summary>
  /// Constructor: short version
  /// </summary>
  /// <param name="number">Number to be converted</param>
  /// <param name="currency">Currency to use</param>
  ///
  ToWord(double number, CurrencyInfo currency) {
    InitializeClass(number, currency, '', "only.", "", "");
  }

  /// <summary>
  /// Constructor: Full Version
  /// </summary>
  /// <param name="number">Number to be converted</param>
  /// <param name="currency">Currency to use</param>
  /// <param name="englishPrefixText">English text to be placed before the generated text</param>
  /// <param name="englishSuffixText">English text to be placed after the generated text</param>
  /// <param name="arabicPrefixText">Arabic text to be placed before the generated text</param>
  /// <param name="arabicSuffixText">Arabic text to be placed after the generated text</param>
  ///
  // ToWord(double number, CurrencyInfo currency, String englishPrefixText,
  //     String englishSuffixText, String arabicPrefixText,
  //     String arabicSuffixText) {
  //   InitializeClass(number, currency, englishPrefixText, englishSuffixText,
  //       arabicPrefixText, arabicSuffixText);
  // }

  /// <summary>
  /// Initialize Class Varaibles
  /// </summary>
  /// <param name="number">Number to be converted</param>
  /// <param name="currency">Currency to use</param>
  /// <param name="englishPrefixText">English text to be placed before the generated text</param>
  /// <param name="englishSuffixText">English text to be placed after the generated text</param>
  /// <param name="arabicPrefixText">Arabic text to be placed before the generated text</param>
  /// <param name="arabicSuffixText">Arabic text to be placed after the generated text</param>

  void InitializeClass(
      double number,
      CurrencyInfo currency,
      String englishPrefixText,
      String englishSuffixText,
      String arabicPrefixText,
      String arabicSuffixText) {
    Number = number;
    Currency = currency;
    EnglishPrefixText = englishPrefixText;
    EnglishSuffixText = englishSuffixText;
    ArabicPrefixText = arabicPrefixText;
    ArabicSuffixText = arabicSuffixText;

    ExtractIntegerAndDecimalParts();
  }

  /// <summary>
  /// Get Proper Decimal Value
  /// </summary>
  /// <param name="decimalPart">Decimal Part as a String</param>
  /// <returns></returns>
  // private string

  GetDecimalValue(String decimalPart) {
    String result = '';

    if (Currency!.PartPrecision != decimalPart.length) {
      int decimalPartLength = decimalPart.length;

      for (int i = 0; i < Currency!.PartPrecision! - decimalPartLength; i++) {
        decimalPart +=
            "0"; //Fix for 1 number after decimal ( 10.5 , 1442.2 , 375.4 )
      }

      result = decimalPart;
      // "${decimalPart.substring(0, Currency!.PartPrecision)}.${decimalPart.substring(Currency?.PartPrecision??0,
      //     (decimalPart.length>0?decimalPart.length:0) - (Currency?.PartPrecision??0))}";

      result = (double.parse(result).round()).toString();
    } else {
      result = decimalPart;
    }

    for (int i = 0; i < Currency!.PartPrecision! - result.length; i++) {
      result += "0";
    }

    return result;
  }

  /// <summary>
  /// Eextract Interger and Decimal parts
  /// </summary>
  // private

  void ExtractIntegerAndDecimalParts() {
    List<String> splits = Number.toString().split('.');

    _intergerValue = double.parse(splits[0]);

    if (splits.length > 1) {
      _decimalValue = int.parse(GetDecimalValue(splits[1]));
    }
  }

  List<String> englishOnes = [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "Nine",
    "Ten",
    "Eleven",
    "Twelve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "Sixteen",
    "Seventeen",
    "Eighteen",
    "Nineteen"
  ];

  List<String> englishTens = [
    "Twenty",
    "Thirty",
    "Forty",
    "Fifty",
    "Sixty",
    "Seventy",
    "Eighty",
    "Ninety"
  ];

  List<String> englishGroup = [
    "Hundred",
    "Thousand",
    "Million",
    "Billion",
    "Trillion",
    "Quadrillion",
    "Quintillion",
    "Sextillian",
    "Septillion",
    "Octillion",
    "Nonillion",
    "Decillion",
    "Undecillion",
    "Duodecillion",
    "Tredecillion",
    "Quattuordecillion",
    "Quindecillion",
    "Sexdecillion",
    "Septendecillion",
    "Octodecillion",
    "Novemdecillion",
    "Vigintillion",
    "Unvigintillion",
    "Duovigintillion",
    "10^72",
    "10^75",
    "10^78",
    "10^81",
    "10^84",
    "10^87",
    "Vigintinonillion",
    "10^93",
    "10^96",
    "Duotrigintillion",
    "Trestrigintillion"
  ];

  // #endregion

  /// <summary>
  /// Process a group of 3 digits
  /// </summary>
  /// <param name="groupNumber">The group number to process</param>
  /// <returns></returns>
  String ProcessGroup(int groupNumber) {
    int tens = groupNumber % 100;

    int hundreds = groupNumber / 100 as int;

    String retVal = '';

    if (hundreds > 0) {
      retVal = "${englishOnes[hundreds]} ${englishGroup[0]}";
    }
    if (tens > 0) {
      if (tens < 20) {
        retVal += ((retVal != '') ? " " : '') + englishOnes[tens];
      } else {
        int ones = tens % 10;

        tens = ((tens / 10) - 2) as int; // 20's offset

        retVal += ((retVal != '') ? " " : '') + englishTens[tens];

        if (ones > 0) {
          retVal += ((retVal != '') ? " " : '') + englishOnes[ones];
        }
      }
    }

    return retVal;
  }

  /// <summary>
  /// Convert stored number to words using selected currency
  /// </summary>
  /// <returns></returns>
  String ConvertToEnglish() {
    double tempNumber = Number!;

    if (tempNumber == 0) {
      return "Zero";
    }

    String decimalString = ProcessGroup(_decimalValue!);

    String retVal = '';

    int group = 0;

    if (tempNumber < 1) {
      retVal = englishOnes[0];
    } else {
      while (tempNumber >= 1) {
        int numberToProcess = tempNumber % 1000 as int;

        tempNumber = tempNumber / 1000;

        String groupDescription = ProcessGroup(numberToProcess);

        if (groupDescription != '') {
          if (group > 0) {
            retVal = "${englishGroup[group]} $retVal";
          }

          retVal = "$groupDescription $retVal";
        }

        group++;
      }
    }

    String formattedNumber = '';
    formattedNumber += (EnglishPrefixText != '') ? "$EnglishPrefixText " : '';
    formattedNumber += (retVal != '') ? retVal : '';
    formattedNumber += ((retVal != '')
        ? (_intergerValue == 1
            ? Currency!.EnglishCurrencyName
            : Currency!.EnglishPluralCurrencyName)
        : '')!;
    formattedNumber += (decimalString != '') ? " and " : '';
    formattedNumber += (decimalString != '') ? decimalString : '';
    formattedNumber += (decimalString != '')
        ? " " +
            (_decimalValue == 1
                ? Currency!.EnglishCurrencyPartName!
                : Currency!.EnglishPluralCurrencyPartName!)
        : '';
    formattedNumber += (EnglishSuffixText != '') ? " $EnglishSuffixText" : '';

    return formattedNumber;
  }

  List<String> arabicOnes = [
    '',
    "واحد",
    "اثنان",
    "ثلاثة",
    "أربعة",
    "خمسة",
    "ستة",
    "سبعة",
    "ثمانية",
    "تسعة",
    "عشرة",
    "أحد عشر",
    "اثنا عشر",
    "ثلاثة عشر",
    "أربعة عشر",
    "خمسة عشر",
    "ستة عشر",
    "سبعة عشر",
    "ثمانية عشر",
    "تسعة عشر"
  ];

  List<String> arabicFeminineOnes = [
    '',
    "إحدى",
    "اثنتان",
    "ثلاث",
    "أربع",
    "خمس",
    "ست",
    "سبع",
    "ثمان",
    "تسع",
    "عشر",
    "إحدى عشرة",
    "اثنتا عشرة",
    "ثلاث عشرة",
    "أربع عشرة",
    "خمس عشرة",
    "ست عشرة",
    "سبع عشرة",
    "ثماني عشرة",
    "تسع عشرة"
  ];

  List<String> arabicTens = [
    "عشرون",
    "ثلاثون",
    "أربعون",
    "خمسون",
    "ستون",
    "سبعون",
    "ثمانون",
    "تسعون"
  ];

  List<String> arabicHundreds = [
    "",
    "مائة",
    "مئتان",
    "ثلاثمائة",
    "أربعمائة",
    "خمسمائة",
    "ستمائة",
    "سبعمائة",
    "ثمانمائة",
    "تسعمائة"
  ];

  List<String> arabicAppendedTwos = [
    "مئتا",
    "ألفا",
    "مليونا",
    "مليارا",
    "تريليونا",
    "كوادريليونا",
    "كوينتليونا",
    "سكستيليونا"
  ];

  List<String> arabicTwos = [
    "مئتان",
    "ألفان",
    "مليونان",
    "ملياران",
    "تريليونان",
    "كوادريليونان",
    "كوينتليونان",
    "سكستيليونان"
  ];

  List<String> arabicGroup = [
    "مائة",
    "ألف",
    "مليون",
    "مليار",
    "تريليون",
    "كوادريليون",
    "كوينتليون",
    "سكستيليون"
  ];

  List<String> arabicAppendedGroup = [
    "",
    "ألفاً",
    "مليوناً",
    "ملياراً",
    "تريليوناً",
    "كوادريليوناً",
    "كوينتليوناً",
    "سكستيليوناً"
  ];

  List<String> arabicPluralGroups = [
    "",
    "آلاف",
    "ملايين",
    "مليارات",
    "تريليونات",
    "كوادريليونات",
    "كوينتليونات",
    "سكستيليونات"
  ];

  /// <summary>
  /// Get Feminine Status of one digit
  /// </summary>
  /// <param name="digit">The Digit to check its Feminine status</param>
  /// <param name="groupLevel">Group Level</param>
  /// <returns></returns>
  String GetDigitFeminineStatus(int digit, int groupLevel) {
    if (groupLevel == -1) {
      // if it is in the decimal part
      if (Currency!.IsCurrencyPartNameFeminine!) {
        return arabicFeminineOnes[digit]; // use feminine field
      } else {
        return arabicOnes[digit];
      }
    } else if (groupLevel == 0) {
      if (Currency!.IsCurrencyNameFeminine!) {
        return arabicFeminineOnes[digit]; // use feminine field
      } else {
        return arabicOnes[digit];
      }
    } else {
      return arabicOnes[digit];
    }
  }

  /// <summary>
  /// Process a group of 3 digits
  /// </summary>
  /// <param name="groupNumber">The group number to process</param>
  /// <returns></returns>
  String ProcessArabicGroup(
      int groupNumber, int groupLevel, double remainingNumber) {
    int tens = groupNumber % 100;

    int hundreds = groupNumber ~/ 100;

    String retVal = '';

    if (hundreds > 0) {
      if (tens == 0 && hundreds == 2) // حالة المضاف
      {
        retVal = "${arabicAppendedTwos[0]}";
      } else //  الحالة العادية
      {
        retVal = "${arabicHundreds[hundreds]}";
      }
    }

    if (tens > 0) {
      if (tens < 20) {
        // if we are processing under 20 numbers
        if (tens == 2 && hundreds == 0 && groupLevel > 0) {
          // This is special case for number 2 when it comes alone in the group
          if (_intergerValue == 2000 ||
              _intergerValue == 2000000 ||
              _intergerValue == 2000000000 ||
              _intergerValue == 2000000000000 ||
              _intergerValue == 2000000000000000 ||
              _intergerValue == 2000000000000000000) {
            retVal = "${arabicAppendedTwos[groupLevel]}"; // في حالة الاضافة
          } else {
            retVal = "${arabicTwos[groupLevel]}"; //  في حالة الافراد
          }
        } else {
          // General case
          if (retVal != '') {
            retVal += " و ";
          }

          if (tens == 1 && groupLevel > 0 && hundreds == 0) {
            retVal += " ";
          } else if ((tens == 1 || tens == 2) &&
              (groupLevel == 0 || groupLevel == -1) &&
              hundreds == 0 &&
              remainingNumber == 0) {
            retVal +=
                ''; // Special case for 1 and 2 numbers like: ليرة سورية و ليرتان سوريتان
          } else {
            retVal += GetDigitFeminineStatus(
                tens, groupLevel); // Get Feminine status for this digit
          }
        }
      } else {
        int ones = tens % 10;
        tens = ((tens / 10) - 2).toInt(); // 20's offset

        if (ones > 0) {
          if (retVal != '') {
            retVal += " و ";
          }

          // Get Feminine status for this digit
          retVal += GetDigitFeminineStatus(ones, groupLevel);
        }

        if (retVal != '') {
          retVal += " و ";
        }

        // Get Tens text
        retVal += arabicTens[tens];
      }
    }

    return retVal;
  }

  /// <summary>
  /// Convert stored number to words using selected currency
  /// </summary>
  /// <returns></returns>
  String ConvertToArabic() {
    double tempNumber = Number!;

    if (tempNumber == 0) {
      return "صفر";
    }

    // Get Text for the decimal part
    String decimalString = ProcessArabicGroup(_decimalValue!, -1, 0);

    String retVal = '';
    int group = 0;
    while (tempNumber >= 1) {
      // seperate number into groups
      int numberToProcess = (tempNumber % 1000).toInt();

      tempNumber = tempNumber / 1000;

      // convert group into its text
      String groupDescription = ProcessArabicGroup(
          numberToProcess, group, tempNumber.floorToDouble());

      if (groupDescription != '') {
        // here we add the new converted group to the previous concatenated text
        if (group > 0) {
          if (retVal != '') {
            retVal = "و $retVal";
          }

          if (numberToProcess != 2) {
            if (numberToProcess % 100 != 1) {
              if (numberToProcess >= 3 &&
                  numberToProcess <=
                      10) // for numbers between 3 and 9 we use plural name
              {
                retVal = "${arabicPluralGroups[group]} $retVal";
              } else {
                if (retVal != '') // use appending case
                {
                  retVal = "${arabicAppendedGroup[group]} $retVal";
                } else {
                  retVal = "${arabicGroup[group]} $retVal";
                }
              }
            } else {
              retVal = "${arabicGroup[group]} $retVal";
            }
          }
        }

        retVal = "$groupDescription $retVal";
      }

      group++;
    }

    String formattedNumber = '';
    formattedNumber += (ArabicPrefixText != '') ? "$ArabicPrefixText " : '';
    formattedNumber += (retVal != '') ? retVal : '';
    if (_intergerValue != 0) {
      // here we add currency name depending on _intergerValue : 1 ,2 , 3--->10 , 11--->99
      int remaining100 = _intergerValue!.toInt() % 100;

      if (remaining100 == 0) {
        formattedNumber += Currency!.Arabic1CurrencyName!;
      } else if (remaining100 == 1) {
        formattedNumber += Currency!.Arabic1CurrencyName!;
      } else if (remaining100 == 2) {
        if (_intergerValue == 2) {
          formattedNumber += Currency!.Arabic2CurrencyName!;
        } else {
          formattedNumber += Currency!.Arabic1CurrencyName!;
        }
      } else if (remaining100 >= 3 && remaining100 <= 10) {
        formattedNumber += Currency!.Arabic310CurrencyName!;
      } else if (remaining100 >= 11 && remaining100 <= 99) {
        formattedNumber += Currency!.Arabic1199CurrencyName!;
      }
    }
    formattedNumber += (_decimalValue != 0) ? " و " : '';
    formattedNumber += (_decimalValue != 0) ? decimalString : '';
    if (_decimalValue != 0) {
      // here we add currency part name depending on _intergerValue : 1 ,2 , 3--->10 , 11--->99
      formattedNumber += " ";

      int remaining100 = _decimalValue! % 100;

      if (remaining100 == 0) {
        formattedNumber += Currency!.Arabic1CurrencyPartName!;
      } else if (remaining100 == 1) {
        formattedNumber += Currency!.Arabic1CurrencyPartName!;
      } else if (remaining100 == 2) {
        formattedNumber += Currency!.Arabic2CurrencyPartName!;
      } else if (remaining100 >= 3 && remaining100 <= 10) {
        formattedNumber += Currency!.Arabic310CurrencyPartName!;
      } else if (remaining100 >= 11 && remaining100 <= 99) {
        formattedNumber += Currency!.Arabic1199CurrencyPartName!;
      }
    }
    formattedNumber += (ArabicSuffixText != '') ? ' $ArabicSuffixText' : '';

    return formattedNumber;
  }
}
