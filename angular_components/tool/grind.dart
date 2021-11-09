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

@Task('Build protocol buffers')
void build_protoc() {
  var pkgRoot = _runProc('git', ['rev-parse', '--show-toplevel']);
  var currentDir = Directory.current.resolveSymbolicLinksSync();
  if (!p.equals(p.join(pkgRoot, 'angular_components'), currentDir)) {
    throw StateError('Expected the git root ($pkgRoot/angular_components) '
        'to match the current directory ($currentDir).');
  }

  // By default try to run from a pre-determined location for Travis.
  var protocPath = '${Platform.environment['HOME']}/protoc/bin/protoc';

  // Use the version of protoc on the $PATH if available.
  var result = Process.runSync('which', ['protoc']);
  if (result.exitCode == 0) {
    protocPath = (result.stdout as String).trim();
  }

  final datepickerProtoPath = '${currentDir}/lib/material_datepicker/proto';

  // 1 - get a list of modified `.pb.dart` files - should be empty
  if (_changedGeneratedFiles().isNotEmpty) {
    print('INFO: .pb.dart files are already modified???');
  }

  // 2 - run build
  _runProc(protocPath, [
    '--proto_path=$datepickerProtoPath',
    '--dart_out=$datepickerProtoPath',
    '$datepickerProtoPath/date.proto'
  ]);
  _runProc(protocPath, [
    '--proto_path=$datepickerProtoPath',
    '--dart_out=$datepickerProtoPath',
    '$datepickerProtoPath/date_range.proto'
  ]);
  _runProc('dartfmt', ['-w', datepickerProtoPath]);

  // 3 - get a list of modified `.pb.dart` files, for info only
  _runProc('git', ['diff', '$datepickerProtoPath/date.pb.dart']);
  _runProc('git', ['diff', '$datepickerProtoPath/date_range.pb.dart']);
}

final _whitespace = RegExp(r'\s');

Set<String> _changedGeneratedFiles() {
  var output = _runProc('git', ['status', '--porcelain']);
  return LineSplitter.split(output)
      .map((line) => line.split(_whitespace).last)
      .where((path) => path.endsWith('.pb.dart'))
      .toSet();
}

String _runProc(String proc, List<String> args) {
  var result = Process.runSync(proc, args);
  if (result.exitCode != 0) {
	throw Exception('Bruh, "$proc $args" failed!');
//    throw ProcessException(
//        proc, args, result.stderr as String, result.exitCode);
  }
  return (result.stdout as String).trim();
}
