import 'package:liquify/liquify.dart';
import 'package:serinus/serinus.dart';

import 'errors.dart';

/// The [LiquifyEngine] in an implementation of the Serinus ViewEngine. It uses the [liquify](https://pub.dev/packages/liquify) package to render templates.
class LiquifyEngine extends ViewEngine {
  final Root? root;

  LiquifyEngine({this.root});

  @override
  Future<String> render(View view) async {
    if (!view.fromFile) {
      final template = Template.parse(
        view.template,
        data: view.variables, 
        root: root,
      );
      return template.renderAsync();
    }
    if (root == null) {
      throw LiquifyEngineMissingRoot();
    }
    final template = Template.fromFile(
      view.template,
      root!,
      data: view.variables,
    );
    return template.renderAsync();
  }
}
