import 'dart:convert';
import 'dart:io';

// запуск: dart run tool/check_arb.dart
// сверяет ключи и плейсхолдеры в app_ru.arb и app_en.arb
void main() {
  final ru = _read('lib/l10n/app_ru.arb');
  final en = _read('lib/l10n/app_en.arb');

  final problems = <String>[];
  for (final key in ru.keys) {
    if (!en.containsKey(key)) {
      problems.add('нет в en: $key');
    } else if (!_samePlaceholders(ru[key]!, en[key]!)) {
      problems.add('разные плейсхолдеры: $key');
    }
  }
  for (final key in en.keys) {
    if (!ru.containsKey(key)) problems.add('нет в ru: $key');
  }

  if (problems.isEmpty) {
    stdout.writeln('en: 0 расхождений, ключей ${en.length}');
  } else {
    problems.forEach(stdout.writeln);
    exitCode = 1;
  }
}

Map<String, String> _read(String path) {
  final json =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final entry in json.entries)
      if (!entry.key.startsWith('@')) entry.key: entry.value.toString(),
  };
}

bool _samePlaceholders(String a, String b) {
  final regExp = RegExp(r'\{(\w+)');
  final first = regExp.allMatches(a).map((m) => m.group(1)).toSet();
  final second = regExp.allMatches(b).map((m) => m.group(1)).toSet();
  return first.length == second.length && first.containsAll(second);
}
