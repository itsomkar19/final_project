import 'package:flutter/foundation.dart';

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;
  const LinkText({required super.text, required this.onTapped, super.style});
}
