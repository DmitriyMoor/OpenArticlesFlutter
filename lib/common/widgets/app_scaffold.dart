import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/settings/settings_cubit.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.body});

  final Widget body;

  static const double maxContentWidth = 760;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = context.read<SettingsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          TextButton(
            onPressed: settings.toggleLocale,
            child: Tooltip(
              message: l10n.actionToggleLanguage,
              child: Text(l10n.languageButton),
            ),
          ),
          IconButton(
            tooltip: l10n.actionToggleTheme,
            onPressed: settings.toggleTheme,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: body,
        ),
      ),
    );
  }
}
