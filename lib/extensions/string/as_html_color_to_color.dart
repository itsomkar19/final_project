import 'dart:ui';

import 'package:credbud/extensions/string/remove_all.dart';

extension AsHtmlColorToColor on String {
  Color asHtmlColorToColor() =>
      Color(int.parse(removeAll(['0x', '#']).padLeft(8, 'ff'), radix: 16));
}
