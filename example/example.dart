import 'package:liquify/parser.dart';
import 'package:serinus_liquify/serinus_liquify.dart';
import 'package:serinus/serinus.dart';
import './box.dart';

class AppController extends Controller {
  AppController() : super('/') {
    on(Route.get('/viewString'), (RequestContext context) async {
      return View.string(
        'Hello, {{ name | upcase }}! Your items are: {% for item in items %}{{ item }}{% unless forloop.last %}, {% endunless %}{% endfor %}.',
        {
          'name': 'Alice',
          'items': ['apple', 'banana', 'cherry']
        }
      );
    });
    on(Route.get('/view'), (RequestContext context) async {
      return View.template('view', {});
    });
    on(Route.get('/custom-tags'), (RequestContext context) async {
      return View.template('custom-tags', {
        'name': 'Alice',
        'age': 30,
        'items': [1, 2, 3, 4, 5],
      });
    });
  }
}

class AppModule extends Module {
  AppModule() : super(controllers: [AppController()]);
}

Future<void> main(List<String> arguments) async {
  TagRegistry.register('box', (content, filters) => BoxTag(content, filters));
  FilterRegistry.register('sum', (value, args, namedArgs) {
    if (value is! List) {
      return value;
    }
    return (value as List<int>).reduce((int a, int b) => a + b);
  });
  final application = await serinus.createApplication(entrypoint: AppModule());

  application.viewEngine = LiquifyEngine(
      root:
          FileSystemRoot('templates', notFoundCallback: () => '404 Not Found'));

  application.serve();
}
