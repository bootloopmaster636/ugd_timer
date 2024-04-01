import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ugd_timer/screen/general_components.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Gap(16),
        Text(
          title,
          style: FluentTheme.of(context).typography.subtitle,
        ),
        Text(
          subtitle,
          style: FluentTheme.of(context).typography.body,
        ),
        const Gap(8),
        ...children.map(
          (Widget e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: e,
          ),
        ),
      ],
    );
  }
}

class SettingsTileSwitch extends StatelessWidget {
  const SettingsTileSwitch({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final bool value;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Acrylic(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        title: Text(title),
        trailing: ToggleSwitch(
          checked: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class SettingsTileTimeSelect extends StatelessWidget {
  const SettingsTileTimeSelect({
    required this.title,
    required this.selectedTime,
    required this.isEnabled,
    required this.onPressed,
    super.key,
  });

  final String title;
  final Duration selectedTime;
  final bool isEnabled;
  final void Function(DateTime time) onPressed;

  @override
  Widget build(BuildContext context) {
    return Acrylic(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: HideableWidget(
        isShown: isEnabled,
        child: ListTile(
          title: Text(title),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TimePicker(
              selected: DateTime(0, 0, 0, selectedTime.inHours, selectedTime.inMinutes.remainder(60)),
              hourFormat: HourFormat.HH,
              onChanged: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsTileTextfield extends HookConsumerWidget {
  const SettingsTileTextfield({
    required this.title,
    required this.hint,
    required this.isEnabled,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String hint;
  final bool isEnabled;
  final String value;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController inputCtl = useTextEditingController(text: value);
    return Acrylic(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: HideableWidget(
        isShown: isEnabled,
        child: ListTile(
          title: Text(title),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: TextBox(
              controller: inputCtl,
              placeholder: hint,
              onChanged: (String value) {
                inputCtl.text = value;
                onChanged(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
