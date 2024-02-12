import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerEtc/timerNotes.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: FluentTheme.of(context).menuColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 36,
            color: FluentTheme.of(context).menuColor.toAccentColor().darker,
            padding: const EdgeInsets.all(4),
            child: const NotesControlBar(),
          ),
          const Expanded(child: NotesDisplay()),
        ],
      ),
    );
  }
}

class NotesDisplay extends ConsumerWidget {
  const NotesDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget display =
        ref.watch(notesLogicProvider).showMode == NotesShowMode.edit ? const NotesEdit() : const NotesRender();
    return display;
  }
}

class NotesEdit extends HookConsumerWidget {
  const NotesEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController inputCtl = useTextEditingController(text: ref.read(notesLogicProvider).data);
    return MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(ref.watch(notesLogicProvider).textScale)),
      child: TextBox(
        controller: inputCtl,
        maxLines: null,
        onChanged: (String val) {
          ref.read(notesLogicProvider.notifier).setNotes(val);
          inputCtl.text = val;
        },
      ),
    );
  }
}

class NotesRender extends ConsumerWidget {
  const NotesRender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(ref.watch(notesLogicProvider).textScale)),
      child: Markdown(
        data: ref.watch(notesLogicProvider).data,
      ),
    );
  }
}

class NotesControlBar extends ConsumerWidget {
  const NotesControlBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Button(
          child: Row(
            children: <Widget>[
              const Icon(FluentIcons.text_field),
              const Gap(4),
              Text(AppLocalizations.of(context)!.editMode),
            ],
          ),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).setShowMode(NotesShowMode.edit);
          },
        ),
        const Gap(4),
        Button(
          child: Row(
            children: <Widget>[
              const Icon(FluentIcons.mark_down_language),
              const Gap(4),
              Text(AppLocalizations.of(context)!.renderedMode),
            ],
          ),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).setShowMode(NotesShowMode.rendered);
          },
        ),
        const Spacer(),
        Button(
          child: Text('${(ref.watch(notesLogicProvider).textScale * 100).round()}%'),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).resetTextSize();
          },
        ),
        const Gap(4),
        IconButton(
          icon: const Icon(FluentIcons.font_decrease),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).decreaseTextSize();
          },
          onLongPress: () {
            ref.read(notesLogicProvider.notifier).decreaseTextSize(jump: true);
          },
        ),
        IconButton(
          icon: const Icon(FluentIcons.font_increase),
          onPressed: () {
            ref.read(notesLogicProvider.notifier).increaseTextSize();
          },
          onLongPress: () {
            ref.read(notesLogicProvider.notifier).increaseTextSize(jump: true);
          },
        ),
      ],
    );
  }
}
