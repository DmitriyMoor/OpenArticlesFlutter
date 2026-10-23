import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_articles_flutter/common/widgets/app_scaffold.dart';
import 'package:open_articles_flutter/features/article/presentation/view/article_detail_screen.dart';
import 'package:open_articles_flutter/features/article/presentation/view/article_list_screen.dart';
import 'package:open_articles_flutter/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';

  static String detail(String id) => '/article/$id';
}

abstract final class AppRouter {
  static final GoRouter router = _create();

  static GoRouter _create() {
    // без этого push не меняет адрес во вкладке браузера
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          builder: (context, state) => const ArticleListScreen(),
          routes: [
            GoRoute(
              path: 'article/:id',
              builder: (context, state) =>
                  ArticleDetailScreen(id: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    );
  }
}
