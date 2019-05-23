import 'package:flutter/material.dart';

/// COMMON STYLES
///
/// Styles that are commonly used throughout the app.

/* COLORS */

// Shades of Grays
//
// Color name is based on https://www.color-hex.com/color-names.html.
// If the color has no reference than use the closest.
const Color colorGray20 = Color(0xFF333333);
const Color colorGray29 = Color(0xFF4b4b4b);
const Color colorGray46 = Color(0xFF757575);
const Color colorGray68 = Color(0xFFadadad);
const Color colorGray79 = Color(0xFFc9c9c9);
const Color colorGray88 = Color(0xFFe0e0e0);
const Color colorGray95 = Color(0xFFf2f4f5);

// Main Colors
const Color colorCyan = Color(0xFF00BCD4);

// Additional Colors
const Color colorRed = Color(0xFFba1818);
const Color colorYellow = Color(0xFFffb100);
const Color colorGreen = Color(0xFF67d970);

/// IMPORTANT!
/// The colors above should never be used outside styles.dart directly. Rather,
/// it should be assigned to a variable that relates to its application
/// (eg. buttonColor for buttons).

/// Basic Color Applications

// Brand Colors
const Color colorPrimary = colorCyan;
const Color colorBlack = colorGray20;

// Indicator Colors
const Color colorError = colorRed;
const Color colorDisabled = colorGray79;
const Color colorInactive = colorGray95;
const Color colorSuccess = colorGreen;
const Color colorFailed = colorGray46;
const Color colorPending = colorYellow;

// Shimmering Color
const Color shimmeringColor = colorGray88;
const Color shiningShimmeringColor = colorGray95;

/* FONTS */

const String fontFamilyPrimary = 'Roboto';

/// Font Colors

const Color fontColorPrimary = colorGray29;
const Color fontColorSecondary = colorGray46;
const Color fontColorLight = colorGray88;
const Color fontColorBlack = colorBlack;
const Color fontColorOnDark = Colors.white;

/// Font Sizes

const double fontSizePrimary = 14.0;
const double fontSizeHeading = 16.0;
const double fontSizeHeadingBig = 20.0;
const double fontSizeSmall = 12.0;
const double fontSizeSmallest = 10.0;

const FontWeight fontWeightBold = FontWeight.w700;
const FontWeight fontWeightMedium = FontWeight.w500;

// Paragraph Line Height
const double textParagraphHeight = 1.15;

/* MEASUREMENTS */

/// Paddings/Margins

const double paddingPrimary = 16.0;
const double paddingSecondary = 20.0;
const double paddingSmall = 8.0;
const double paddingVariant1 = 14.0;
const double paddingVariant2 = 12.0;

// Padding between stacking texts
const double paddingText = 4.0;

/* BASIC APPEARANCES */

/// Text Styles

const TextStyle textPrimary = TextStyle(
  color: fontColorPrimary,
  fontSize: fontSizePrimary,
);

const TextStyle textSecondary = TextStyle(color: fontColorSecondary);

const TextStyle textSmall = TextStyle(fontSize: fontSizeSmall);

const TextStyle textBold = TextStyle(fontWeight: fontWeightBold);

const TextStyle textError = TextStyle(color: colorRed);

const TextStyle textHeading = TextStyle(fontSize: fontSizeHeading);

const TextStyle textHeadingBold = TextStyle(
  fontSize: fontSizeHeading,
  fontWeight: fontWeightBold,
);

const TextStyle textHeadingBigBold = TextStyle(
  fontSize: fontSizeHeadingBig,
  fontWeight: fontWeightBold,
);

const TextStyle textNote = TextStyle(
  color: fontColorSecondary,
  fontSize: fontSizeSmall,
);

const TextStyle textSmallNote = TextStyle(
  color: fontColorSecondary,
  fontSize: fontSizeSmallest,
);

// Text highlight
const TextStyle textHilite = TextStyle(color: colorPrimary);

// Text hyperlink
const TextStyle textLink = TextStyle(
  color: colorPrimary,
  fontWeight: fontWeightBold,
);

/// Backgrounds

const Color bgColorBase = colorGray95;
const Color bgColorCanvas = Colors.white;
const Color bgColorDisabled = colorDisabled;

/// Borders

// Border Radius
const double borderRadiusSize = 4.0;
const double borderRadiusSizeLarge = 8.0;

BorderRadius borderRadius = BorderRadius.circular(borderRadiusSize);
BorderRadius borderRadiusLarge = BorderRadius.circular(borderRadiusSizeLarge);

// Border Colors
const Color borderColor = colorGray88;

// Border Sides
const BorderSide borderSide = BorderSide(
  color: borderColor,
);

// Border - All Sides
Border borders = Border.all(
  color: borderSide.color,
);

// Dividers
const Color dividerColor = borderColor;

/// Shadows

const double shadowElevation = 3;

const BoxShadow shadowItem = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, .2),
  offset: Offset(0, 3),
  blurRadius: 2,
);

const List<BoxShadow> shadowList = <BoxShadow>[
  shadowItem,
];

/// WIDGET STYLES
///
/// Default styles that are only used on specific widgets.

/// Icon

const double iconSize = 24;
const double iconSizeLarge = 32;

// Minimum size for tappable objects
const double iconTappableSize = 48;

const Color iconColorPrimary = colorBlack;
const Color iconColorSecondary = colorGray68;
const Color iconColorOnDark = Colors.white;
const Color iconColorHilite = colorPrimary;

/// Header Bar

// The height of the main section of the [HeaderBar]
const double headerBarHeight = 64;
const double headerBarHeightVariant = 76;

const TextStyle headerBarTitleStyle = TextStyle(
  color: fontColorPrimary,
  fontSize: fontSizeHeadingBig,
  fontWeight: fontWeightMedium,
);

const double headerBarIconMargin = paddingPrimary;

// The default maximum size for the icons in the header bar
const double headerBarIconSize = iconSizeLarge + (headerBarIconMargin * 2);

const double headerBarTitleMargin = paddingPrimary;
const double headerBarElevation = shadowElevation;
const Color headerBarColor = bgColorCanvas;
const Brightness headerBarBrightness = Brightness.light;
const IconThemeData headerBarIconTheme = IconThemeData(
  color: iconColorPrimary,
  size: iconSizeLarge,
);
const TextTheme headerBarTextTheme = TextTheme(
  title: headerBarTitleStyle,
);

const String headerbarBackIcon =
    'assets/vectors/icon_navigation_arrow_left.svg';

/// Button

const EdgeInsets buttonPadding = EdgeInsets.all(paddingPrimary);

const double buttonRadiusSize = 100;

BorderRadius buttonRadius = BorderRadius.circular(buttonRadiusSize);

ShapeBorder buttonShape = RoundedRectangleBorder(
  borderRadius: buttonRadius,
);

const Color buttonDisabledColor = bgColorDisabled;
