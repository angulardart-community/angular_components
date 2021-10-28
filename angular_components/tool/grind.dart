import 'dart:io';
import 'dart:convert';
import 'package:grinder/grinder.dart';

import 'package:path/path.dart' as p;

main(args) => grind(args);

@DefaultTask()
Future<void> analyze() async {
  log('Counting number of Dart files...');
  var count = 0;
  await Directory('lib').list(recursive: true).forEach((element) {
    if (element is File && p.extension(element.path) == '.dart') {
      count++;
    }
  });

  log('Analyzing...');

  final analyze = await Process.start('dart', ['analyze', '--format=machine']);

  var need_migrate = Set<String>();

  await analyze.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .forEach((element) {
    final output = element.split('|');

    if (output[2].contains('DEPRECATED')) {
      need_migrate.add(output[3]);
    }
  });

  log('${((1 - need_migrate.length / count) * 100).round()}% Done!');
  log('${need_migrate.length} out of $count files are still using deprecated API!\n');

  need_migrate.forEach((element) {
    print('- [ ] ' + p.relative(element, from: 'lib'));
  });
}
