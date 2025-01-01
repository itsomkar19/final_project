import 'package:credbud/views/components/rich_text/base_text.dart';
import 'package:credbud/views/components/rich_text/rich_text_widget.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/constants/strings.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class WelcomeScreenPrivacyPolicyLinks extends StatelessWidget {
  const WelcomeScreenPrivacyPolicyLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
        texts: [
          BaseText.plain(text: Strings.byContinuing),
          BaseText.link(
              text: Strings.termsOfService,
              style: const TextStyle(color: AppColors.urlColor),
              onTapped: () {
                launchUrl(Uri.parse(Strings.termsOfServiceUrl));
              }),
          BaseText.plain(text: Strings.and),
          BaseText.link(
              text: Strings.privacyPolicy,
              style: const TextStyle(color: AppColors.urlColor),
              onTapped: () {
                launchUrl(Uri.parse(Strings.privacyPolicyUrl));
              }),
          BaseText.plain(text: Strings.fullStop),
        ],
        styleForAll:
            Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5));
  }
}
