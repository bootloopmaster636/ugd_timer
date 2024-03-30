import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/ui/overlay.dart';
import 'package:ugd_timer/screen/overlay/settings_content.dart';

class SettingsOverlay extends HookConsumerWidget {
  const SettingsOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: <Widget>[
        if (ref.watch(overlayStateLogicProvider).isTimerSettingsShown)
          GestureDetector(
            onTap: () => ref.read(overlayStateLogicProvider.notifier).toggleTimerSettings(),
            child: Container(
              height: 100.h - titleBarHeight,
              width: 100.w,
              color: Colors.transparent,
            ),
          )
        else
          const SizedBox(),
        Acrylic(
          elevation: 8,
          child: Container(
            height: 100.h - titleBarHeight,
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Gap(8),
                  Text(AppLocalizations.of(context)!.timerSettings, style: FluentTheme.of(context).typography.title),
                  Text(
                    AppLocalizations.of(context)!.timerSettingsDescription,
                    style: FluentTheme.of(context).typography.body,
                  ),
                  const SettingsContent(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
