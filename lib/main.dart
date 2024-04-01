import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/data/appSettings/app_settings_persistence.dart';
import 'package:ugd_timer/data/timerProfile/profile_io.dart';
import 'package:ugd_timer/logic/settings/app_settings.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/timerMain/timer_conf.dart';
import 'package:ugd_timer/logic/ui/accent_color.dart';
import 'package:ugd_timer/logic/ui/navigation.dart';
import 'package:ugd_timer/logic/ui/overlay.dart';
import 'package:ugd_timer/screen/etc/apps_settings.dart';
import 'package:ugd_timer/screen/etc/autostart_wizard.dart';
import 'package:ugd_timer/screen/stack.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();

  if (defaultTargetPlatform == TargetPlatform.windows) {}

  runApp(const ProviderScope(child: MainApp()));
}

final GlobalKey widgetKey = GlobalKey();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Init(
      child: ResponsiveSizer(
        builder: (BuildContext context, Orientation orientation, ScreenType screenType) {
          return FluentApp(
            title: 'UGD Timer',
            darkTheme: FluentThemeData(
              brightness: Brightness.dark,
              accentColor: ref.watch(accentColorStateProvider).accentColor.toAccentColor(),
              visualDensity: VisualDensity.standard,
            ),
            theme: FluentThemeData(
              brightness: Brightness.light,
              accentColor: ref.watch(accentColorStateProvider).accentColor.toAccentColor(),
              visualDensity: VisualDensity.standard,
            ),
            localizationsDelegates: const <LocalizationsDelegate>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('en'), // English
              Locale('id'), // Indonesia
            ],
            locale: Locale(ref.watch(appSettingsLogicProvider).languageCode),
            themeMode: ref.watch(appSettingsLogicProvider).themeMode,
            home: Column(
              key: widgetKey,
              children: const <Widget>[
                TitleBar(),
                ScreenStackManager(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Init extends ConsumerWidget {
  const Init({required this.child, super.key});

  final Widget child;

  // see https://riverpod.dev/docs/essentials/eager_initialization for more info.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..watch(timerBeatProvider)
      ..watch(appSettingsLogicProvider);
    final AsyncValue<void> appSettings = ref.watch(appSettingsPersistenceProvider);

    if (appSettings.isLoading) {
      return FluentTheme(
        data: FluentThemeData(
          brightness: Brightness.light,
          accentColor: Colors.blue,
        ),
        child: const Center(child: ProgressBar()),
      );
    } else {
      return child;
    }
  }
}

class TitleBar extends HookConsumerWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isFullscreen = useState(false);

    return Container(
      height: titleBarHeight,
      color: FluentTheme.of(context).accentColor.normal,
      child: Row(
        children: <Widget>[
          const Gap(4),
          const Menu(),
          const Gap(4),
          Text(
            'UGD Timer | ${ref.watch(timerConfLogicProvider).title}',
            style: TextStyle(color: FluentTheme.of(context).activeColor),
          ),
          Expanded(child: MoveWindow()),
          IconButton(
            icon: Icon(FluentIcons.full_screen, color: FluentTheme.of(context).activeColor),
            onPressed: () {
              isFullscreen.value = !isFullscreen.value;
              WindowManager.instance.setFullScreen(isFullscreen.value);
            },
          ),
          MinimizeWindowButton(
            colors: WindowButtonColors(iconNormal: FluentTheme.of(context).activeColor),
          ),
          MaximizeWindowButton(
            colors: WindowButtonColors(iconNormal: FluentTheme.of(context).activeColor),
          ),
          CloseWindowButton(
            colors: WindowButtonColors(iconNormal: FluentTheme.of(context).activeColor),
          ),
        ],
      ),
    );
  }
}

class Menu extends HookConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FlyoutController menuController = FlyoutController();
    return FlyoutTarget(
      controller: menuController,
      child: IconButton(
        icon: Icon(FluentIcons.collapse_menu, color: FluentTheme.of(context).activeColor),
        onPressed: () async {
          await menuController.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.bottomRight,
            ),
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            dismissWithEsc: true,
            margin: 4,
            builder: (BuildContext context) {
              return MenuFlyout(
                items: <MenuFlyoutItemBase>[
                  // TODO(bootloopmaster636): readd keyboard shortcut once shortcut system become stable
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.timer),
                    text: Text(AppLocalizations.of(context)!.timerSettings),
                    // trailing: Text(
                    //   'Ctrl+T',
                    //   style: FluentTheme.of(context).typography.caption,
                    // ),
                    onPressed: () {
                      ref.read(overlayStateLogicProvider.notifier).toggleTimerSettings();
                      Flyout.of(context).close();
                    },
                  ),
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.settings),
                    text: Text(AppLocalizations.of(context)!.appSettings),
                    // trailing: Text(
                    //   'Ctrl+O',
                    //   style: FluentTheme.of(context).typography.caption,
                    // ),
                    onPressed: () {
                      ref.read(topWidgetLogicProvider.notifier).setCurrentlyShown(const ApplicationSettingsPage());
                      Flyout.of(context).close();
                    },
                  ),
                  const MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                    text: Text(AppLocalizations.of(context)!.autoStartWizard),
                    // trailing: Text(
                    //   'Ctrl+Q',
                    //   style: FluentTheme.of(context).typography.caption,
                    // ),
                    onPressed: () {
                      ref.read(topWidgetLogicProvider.notifier).setCurrentlyShown(const AutoStartSetupPage());
                    },
                  ),
                  MenuFlyoutItem(
                    text: Text(AppLocalizations.of(context)!.importProfile),
                    onPressed: () async {
                      await importTimerConfig(ref);
                    },
                  ),
                  MenuFlyoutItem(
                    text: Text(AppLocalizations.of(context)!.exportProfile),
                    onPressed: () async {
                      await exportTimerConfig(ref);
                    },
                  ),
                  const MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                    text: Text(AppLocalizations.of(context)!.exit),
                    // trailing: Text(
                    //   'Ctrl+Q',
                    //   style: FluentTheme.of(context).typography.caption,
                    // ),
                    onPressed: () {
                      exit(0);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
