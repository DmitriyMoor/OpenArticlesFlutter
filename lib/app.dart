import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'common/navigation/app_router.dart';
import 'common/settings/settings_cubit.dart';
import 'common/theme/app_theme.dart';
import 'features/article/data/article_repository.dart';
import 'features/article/domain/i_article_repository.dart';
import 'features/article/presentation/bloc/list/article_list_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IArticleRepository>(
      create: (context) => ArticleRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SettingsCubit()),
          BlocProvider(create: (context) => ArticleListCubit(context.read<IArticleRepository>())),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Open Articles',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: state.themeMode,
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}