import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_timer/screen/background.dart';
import 'package:ugd_timer/screen/top.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutter_acrylic.Window.initialize();

  if (defaultTargetPlatform == TargetPlatform.windows) {}

  if (defaultTargetPlatform == TargetPlatform.linux) {
    await Window.setEffect(
      effect: WindowEffect.transparent,
    );
  }

  await WindowManager.instance.ensureInitialized();
  if (kIsWeb == false) {
    runApp(const ProviderScope(child: MainApp()));
    doWhenWindowReady(() {
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return FluentApp(
          title: 'UGD Timer',
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.blue,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            brightness: Brightness.light,
            accentColor: Colors.blue,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          themeMode: ThemeMode.dark,
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
          locale: const Locale('en'),
          home: const Column(
            children: <Widget>[
              TitleBar(),
              Stack(
                children: <Widget>[
                  Background(),
                  TopLayer(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TitleBar extends HookWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isFullscreen = useState(false);

    return Container(
      height: 32,
      color: FluentTheme.of(context).accentColor.normal,
      child: Row(
        children: <Widget>[
          const Gap(4),
          const Menu(),
          const Gap(4),
          Text(
            'UGD Timer',
            style: TextStyle(color: FluentTheme.of(context).activeColor),
          ),
          const Spacer(),
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
    final menuController = FlyoutController();
    return FlyoutTarget(
      controller: menuController,
      child: IconButton(
        icon: Icon(FluentIcons.collapse_menu, color: FluentTheme.of(context).activeColor),
        onPressed: () {
          menuController.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.bottomRight,
            ),
            barrierDismissible: true,
            barrierColor: Colors.transparent,
            dismissWithEsc: true,
            margin: 4,
            builder: (BuildContext context) {
              return MenuFlyout(
                items: [
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.play),
                    text: Text(AppLocalizations.of(context)!.startTimer),
                    trailing: Text(
                      'Ctrl+S',
                      style: FluentTheme.of(context).typography.caption,
                    ),
                    onPressed: Flyout.of(context).close,
                  ),
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.reset),
                    text: Text(AppLocalizations.of(context)!.stopAndResetTimer),
                    trailing: Text(
                      'Ctrl+R',
                      style: FluentTheme.of(context).typography.caption,
                    ),
                    onPressed: Flyout.of(context).close,
                  ),
                  const MenuFlyoutSeparator(),
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.timer),
                    text: Text(AppLocalizations.of(context)!.timerSettings),
                    trailing: Text(
                      'Ctrl+T',
                      style: FluentTheme.of(context).typography.caption,
                    ),
                    onPressed: Flyout.of(context).close,
                  ),
                  MenuFlyoutItem(
                    leading: const Icon(FluentIcons.settings),
                    text: Text(AppLocalizations.of(context)!.appSettings),
                    trailing: Text(
                      'Ctrl+O',
                      style: FluentTheme.of(context).typography.caption,
                    ),
                    onPressed: Flyout.of(context).close,
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
