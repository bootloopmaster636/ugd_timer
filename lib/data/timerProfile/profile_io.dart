import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerMain/timer.dart';
import 'package:ugd_timer/logic/timerMain/timer_conf.dart';

import '../../main.dart';

Future<void> exportTimerConfig(WidgetRef ref) async {
  try {
    // prepare directory, file, and configurations
    final Directory tempDirPath = await getTemporaryDirectory();
    final File timerMainFile = File('${tempDirPath.path}/timerMain.json');
    final File timerConfFile = File('${tempDirPath.path}/timerConf.json');

    final Clock? timerMain = ref.read(timerLogicProvider).asData?.value;
    final TimerConf? timerConf = ref.read(timerConfLogicProvider);

    // write data to file
    await timerMainFile.writeAsString(jsonEncode(timerMain));
    await timerConfFile.writeAsString(jsonEncode(timerConf));

    // select path for zip file
    final String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select where to save configuration file',
      fileName: 'Timer Profile.utconf',
    );

    if (outputFile == null) return;

    //add file to zip
    final ZipFileEncoder encoder = ZipFileEncoder()..create(outputFile);
    await encoder.addFile(timerMainFile);
    await encoder.addFile(timerConfFile);
    encoder.close();

    //notify user
    await displayInfoBar(
      widgetKey.currentContext!,
      builder: (BuildContext context, void Function() close) {
        return InfoBar(
          title: Text(AppLocalizations.of(widgetKey.currentContext!)!.exportProfileSuccess),
          severity: InfoBarSeverity.success,
        );
      },
    );
  } catch (e) {
    await displayInfoBar(
      widgetKey.currentContext!,
      builder: (BuildContext context, void Function() close) {
        return InfoBar(
          title: Text(AppLocalizations.of(widgetKey.currentContext!)!.somethingWrong),
          content: Text(e.toString()),
          severity: InfoBarSeverity.error,
        );
      },
    );
  }
}

Future<void> importTimerConfig(WidgetRef ref) async {
  try {
    final Directory tempDirPath = await getTemporaryDirectory();

    //Pick the config file
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    File file;
    if (result != null) {
      file = File(result.files.single.path!);
    } else {
      return;
    }

    //extract the file
    final Archive archive = ZipDecoder().decodeBytes(file.readAsBytesSync());
    for (final ArchiveFile file in archive) {
      final String filename = file.name;
      final List<int> data = file.content as List<int>;
      if (file.isFile) {
        File('${tempDirPath.path}/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
    }

    // read the file
    final File timerMainFile = File('${tempDirPath.path}/timerMain.json');
    final File timerConfFile = File('${tempDirPath.path}/timerConf.json');

    // parse the data to a variable
    final Clock timerMain = Clock.fromJson(jsonDecode(await timerMainFile.readAsString()) as Map<String, dynamic>);
    final TimerConf timerConf =
        TimerConf.fromJson(jsonDecode(await timerConfFile.readAsString()) as Map<String, dynamic>);

    // load the variable to the state
    await ref.read(timerLogicProvider.notifier).setTimer(TimerType.main, timerMain.mainTimer);
    await ref.read(timerLogicProvider.notifier).setTimer(TimerType.assist, timerMain.assistTimer);
    await ref.read(timerLogicProvider.notifier).setTimer(TimerType.bonus, timerMain.bonusTimer);

    ref.read(timerConfLogicProvider.notifier).setTitle(timerConf.title);
    ref.read(timerConfLogicProvider.notifier).setAssistTimerEnabled(assistTimerEnabled: timerConf.assistTimerEnabled);
    ref.read(timerConfLogicProvider.notifier).setBonusTimerEnabled(bonusTimerEnabled: timerConf.bonusTimerEnabled);
    ref.read(timerConfLogicProvider.notifier).setWarningAudioPath(timerConf.warningAudioPath);
    ref.read(timerConfLogicProvider.notifier).setEndAudioPath(timerConf.endAudioPath);
    ref.read(timerConfLogicProvider.notifier).setStartCutoffAudioPath(timerConf.startCutoffAudioPath);

    //notify user
    await displayInfoBar(
      widgetKey.currentContext!,
      builder: (BuildContext context, void Function() close) {
        return InfoBar(
          title: Text(AppLocalizations.of(widgetKey.currentContext!)!.importProfileSuccess),
          severity: InfoBarSeverity.success,
        );
      },
    );
  } catch (e) {
    await displayInfoBar(
      widgetKey.currentContext!,
      builder: (BuildContext context, void Function() close) {
        return InfoBar(
          title: Text(AppLocalizations.of(widgetKey.currentContext!)!.somethingWrong),
          content: Text(e.toString()),
          severity: InfoBarSeverity.error,
        );
      },
    );
  }
}
