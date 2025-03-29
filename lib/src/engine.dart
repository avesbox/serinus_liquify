import 'package:liquify/liquify.dart';
import 'package:serinus/serinus.dart';

import 'errors.dart';

/// The [LiquifyEngine] in an implementation of the Serinus ViewEngine. It uses the [liquify](https://pub.dev/packages/liquify) package to render templates.
class LiquifyEngine extends ViewEngine {
  final Root? root;

  LiquifyEngine({this.root});

  @override
  Future<String> render(View view) async {
    if (root == null) {
      throw LiquifyEngineMissingRoot();
    }
    final template = Template.fromFile(view.view, root!, data: view.variables);
    return template.renderAsync();
  }

  @override
  Future<String> renderString(ViewString viewString) {
    final template = Template.parse(viewString.viewData,
        data: viewString.variables, root: root);
    return template.renderAsync();
  }
}
