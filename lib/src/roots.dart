import 'dart:io';

import 'package:liquify/liquify.dart';
import 'package:serinus_liquify/serinus_liquify.dart';

/// The [Root] implementation provided by the Serinus team. It allows to use the templates on your file system.
class FileSystemRoot extends Root {
  final String rootPath;
  final String? Function()? notFoundCallback;

  FileSystemRoot(this.rootPath, {this.notFoundCallback}) {
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
      return Source(Uri.file(file.path), content, this);
    }
    final notFound = notFoundCallback?.call();
    if (notFound != null) {
      return Source(null, notFound, this);
    }
    return Source(null, '', this);
  }
}
