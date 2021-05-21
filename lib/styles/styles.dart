import 'package:flutter/material.dart';
import 'package:incident_report/utils/size_config.dart';

// const Color kPrimaryColor = Color(0xFF1FCC79);
const Color kPrimaryColor = Color(0xFF438DFF);
const Color kSecondaryColor = Color(0xFFA95EFA);
const Color kDarkBlue = Color(0xFF26323E);
const Color kCyanBlue = Color(0xFF1FECC7);
const Color kPurple = Color(0xFFC41EDF);

///red color of theme
const Color PrimaryRed = Color(0xFFF44040);

///yellow color for reviews
const Color StarYellow = Color(0xFFF6CC34);

///grey color for input fields
const Color InputFieldGrey = Color(0xFFf4f4f4);

///green color to show sucess
const Color SuccessGreen = Color(0xFF04CC6C);

///status bar color, set as white rn
const Color StatusBarColor = Color(0xFFFFFFFF);

Color inactiveIconGrey = Colors.black.withOpacity(0.3);

Color mutedTextGrey = Colors.black.withOpacity(0.4);

///bold lora headings for page titles
const TextStyle BigBoldHeading = TextStyle(
  fontFamily: 'Lora',
  fontWeight: FontWeight.bold,
  fontSize: 30,
);

final TextStyle BigBoldFormHeading = TextStyle(
  fontFamily: 'Lora',
  fontWeight: FontWeight.bold,
  fontSize: 4.3 * SizeConfig.textMultiplier,
  color: Colors.white,
);

///generic lora headings with fontsize 18
const TextStyle SerifHeading = TextStyle(
  fontFamily: 'Lora',
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const TextStyle WhiteSerifHeading = TextStyle(
  fontFamily: 'Lora',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);

///generic open sans headings with fontsize 18
final TextStyle SansHeading = TextStyle(
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.bold,
  fontSize: 2.7 * SizeConfig.textMultiplier,
);

final TextStyle WhiteAboutHeading = TextStyle(
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.bold,
  fontSize: 2.7 * SizeConfig.textMultiplier,
  color: Colors.white,
);

const TextStyle WhiteSansHeading = TextStyle(
  fontFamily: 'Open Sans',
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);

///subtitle text, grey and sans-serif typeface, fontsize 13
const TextStyle GreySubtitle = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 13,
  color: Colors.grey,
);

final TextStyle FormGreySubtitle = TextStyle(
  fontFamily: 'Open Sans',
  color: Color(0xffBAB7B7),
  fontSize: 3.2 * SizeConfig.textMultiplier,
);

const TextStyle WhiteSubtitle = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 13,
  color: Colors.white,
);

const TextStyle MediumGreyText = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 16,
  color: Colors.grey,
);

///Red, bold text used for small, navigation buttons, fontsize 12
const TextStyle SmallBoldRedText = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: PrimaryRed,
);
const TextStyle SmallBoldBlackText = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

///circular border radius with value 10
final buttonBorderRadius = BorderRadius.circular(10);

///cicular border radius with value 12
final imageBorderRadius = BorderRadius.circular(12);
