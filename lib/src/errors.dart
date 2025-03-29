/// Error thrown when the root object is not provided.
class LiquifyEngineMissingRoot extends Error {
  @override
  String toString() {
    return 'LiquifyEngineMissingRoot: The root object is required for rendering templates.';
  }
}

/// Error thrown when the root path does not exist.
class LiquifyEngineMissingRootPath extends Error {
  final String path;

  LiquifyEngineMissingRootPath(this.path);

  @override
  String toString() {
    return 'LiquifyEngineMissingRootPath: The root path "$path" does not exist.';
  }
}
