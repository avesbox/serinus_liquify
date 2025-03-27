import 'dart:io';

import 'package:liquify/liquify.dart';
import 'package:serinus_liquify/serinus_liquify.dart';

class FileSystemRoot extends Root {

  final String rootPath;
  final String? Function()? notFoundCallback;

  FileSystemRoot(this.rootPath, {
    this.notFoundCallback,
  }) {
    if (!Directory(rootPath).existsSync()) {
      throw LiquifyEngineMissingRootPath(rootPath);
    }
  }

  @override
  Source resolve(String path) {
    final normalizedPath = path.endsWith('.liquid') ? path : '$path.liquid';
    final file = File('$rootPath/$normalizedPath');
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      return Source.fromString(content);
    }
    final notFound = notFoundCallback?.call();
    if (notFound != null) {
      return Source.fromString(notFound);
    }
    return Source.fromString('');
  }

}