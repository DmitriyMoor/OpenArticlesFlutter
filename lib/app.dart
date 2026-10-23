import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/navigation/app_router.dart';
import 'package:open_articles_flutter/common/network/dio_client.dart';
import 'package:open_articles_flutter/common/settings/settings_cubit.dart';
import 'package:open_articles_flutter/common/settings/settings_state.dart';
import 'package:open_articles_flutter/common/theme/app_theme.dart';
import 'package:open_articles_flutter/features/article/data/api/article_api.dart';
import 'package:open_articles_flutter/features/article/data/article_repository.dart';
import 'package:open_articles_flutter/features/article/data/data_sources/network_article_data_source.dart';
import 'package:open_articles_flutter/features/article/domain/i_article_repository.dart';
import 'package:open_articles_flutter/features/article/presentation/bloc/list/article_list_cubit.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IArticleRepository>(
      create: (_) => ArticleRepository(
        NetworkArticleDataSource(ArticleApi(DioClient.create())),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ArticleListCubit(context.read<IArticleRepository>())..load(),
          ),
          BlocProvider(create: (_) => SettingsCubit()),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) => MaterialApp.router(
            routerConfig: AppRouter.router,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: settings.themeMode,
            locale: settings.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}
