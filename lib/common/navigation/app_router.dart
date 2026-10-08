import 'package:go_router/go_router.dart';
import '../../features/article/presentation/view/article_list_screen.dart';
import '../../features/article/presentation/view/article_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ArticleListScreen(),
    ),
    GoRoute(
      path: '/article/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ArticleDetailScreen(id: id);
      },
    ),
  ],
);