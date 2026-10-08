import '../domain/article_model.dart';
import '../domain/i_article_repository.dart';

class ArticleRepository implements IArticleRepository {
  final List<ArticleModel> _mockArticles = List.generate(25, (index) {
    return ArticleModel(
      id: 'id_$index',
      title: 'Mock Article Title $index about Flutter and Dart',
      abstractText: 'This is a long abstract for mock article $index. It contains very interesting findings about software engineering and open access publishing.',
      authors: ['Author A$index', 'Author B$index'],
      publishedDate: '2023-10-${(index % 28) + 1}',
      journalTitle: 'Journal of Mock Sciences $index',
      url: 'https://doaj.org',
    );
  });

  @override
  Future<List<ArticleModel>> search(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      return _mockArticles;
    }
    return _mockArticles.where((a) => a.title.toLowerCase().contains(q) || a.abstractText.toLowerCase().contains(q)).toList();
  }

  @override
  Future<ArticleModel?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockArticles.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}