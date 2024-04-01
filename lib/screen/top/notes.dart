import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ugd_timer/constants.dart';
import 'package:ugd_timer/logic/timerEtc/timer_notes.dart';
import 'package:ugd_timer/screen/general_components.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        blendMode: BlendMode.luminosity,
        child: ColoredBox(
          color: FluentTheme.of(context).menuColor.withOpacity(0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Flexible(child: NotesDisplay()),
              HoverRevealer(
                child: Container(
                  height: 40,
                  color: FluentTheme.of(context).menuColor.withOpacity(0.8),
                  padding: const EdgeInsets.all(4),
                  child: const NotesControlBar(),
                ),
              ),
            ],
          ),
        ),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(ref.watch(notesLogicProvider).textScale)),
            child: TextBox(
              controller: inputCtl,
              maxLines: null,
              onChanged: (String val) {
                ref.read(notesLogicProvider.notifier).setNotes(val);
              },
            ),
          ),
        ),
        Row(
          children: <Widget>[
            const Gap(8),
            const Icon(
              FluentIcons.mark_down_language,
              size: 16,
            ),
            const Gap(4),
            Text(
              AppLocalizations.of(context)!.markdownSupported,
              style: FluentTheme.of(context).typography.caption,
            ),
            const Spacer(),
            HyperlinkButton(
              child: Text(
                AppLocalizations.of(context)!.learnMore,
                style: FluentTheme.of(context).typography.caption,
              ),
              onPressed: () async {
                final Uri url =
                    Uri.parse('https://guides.github.com/features/mastering-markdown/#GitHub-flavored-markdown');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
          ],
        ),
      ],
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
        onTapLink: (String text, String? href, String title) async {
          if (href != null) {
            final Uri url = Uri.parse(href);
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          }
        },
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
