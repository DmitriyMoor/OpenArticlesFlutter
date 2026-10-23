sealed class ArticleDetailEvent {
  const ArticleDetailEvent(this.id);

  final String id;
}

final class ArticleDetailOpened extends ArticleDetailEvent {
  const ArticleDetailOpened(super.id);
}
