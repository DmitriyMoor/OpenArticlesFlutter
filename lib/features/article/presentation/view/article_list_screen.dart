import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../l10n/app_localizations.dart';
import '../bloc/list/article_list_cubit.dart';
import '../../../../common/settings/settings_cubit.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ArticleListCubit>();
    _searchController = TextEditingController(text: cubit.state.query);
    if (cubit.state.status == ArticleListStatus.initial) {
      cubit.search('');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<SettingsCubit>().toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.read<SettingsCubit>().toggleLocale(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchPrompt,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ArticleListCubit>().search('');
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                context.read<ArticleListCubit>().search(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticleListCubit, ArticleListState>(
              builder: (context, state) {
                if (state.status == ArticleListStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == ArticleListStatus.notFound) {
                  return Center(child: Text(l10n.nothingFound));
                } else if (state.status == ArticleListStatus.error) {
                  return Center(child: Text(l10n.errorMessage));
                } else if (state.status == ArticleListStatus.loaded) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: ListTile(
                          leading: const Icon(Icons.article, size: 50),
                          title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            l10n.journal(item.journalTitle),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            context.push('/article/${item.id}');
                          },
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}