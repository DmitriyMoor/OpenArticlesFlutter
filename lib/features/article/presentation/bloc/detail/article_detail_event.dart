sealed class ArticleDetailEvent {
  const ArticleDetailEvent(this.id);

  final String id;
}

final class ArticleDetailOpened extends ArticleDetailEvent {
  const ArticleDetailOpened(super.id);
}

final class ArticleDetailRetried extends ArticleDetailEvent {
  const ArticleDetailRetried(super.id);
}
