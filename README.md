![Serinus Banner](https://raw.githubusercontent.com/avesbox/serinus_liquify/main/assets/serinus_liquify.png)

[![Discord](https://img.shields.io/discord/1099781506978807919?logo=discord&logoColor=white)](https://discord.gg/FPwH2fEUVF)

serinus_liqufiy is the integration of the [Liquify](https://github.com/kingwill101/liquify) template engine and Serinus. Thanks to it you can now easily use the Liquify template engine in your Serinus application.

# Getting Started

## Installation

To install Serinus you can use the following command:

```bash
dart pub add serinus_liquify
```

## Usage

To use the Liquify template engine in your Serinus application, you need to add the LiquifyEngine to the application. This can be done using this code:

```dart
import 'package:serinus/serinus.dart';
import 'package:serinus_liquify/serinus_liquify.dart';

Future<void> main() async {
  final app = await serinus.createApplication(
    entrypoint: AppModule()
  );

  // Add the Liquify engine to the application
  app.viewEngine = LiquifyEngine();

  // Start the application
  await app.serve();
}
```

## Documentation

You can find the documentation [here][https://serinus.app/plugins/serinus_liquify].

Also if you need help with Liquify itself you can head to [its github repo](https://github.com/kingwill101/liquify) and check the documentation there.

# License

serinus_liquify and all the other Avesbox Packages are licensed under the MIT license. See the [LICENSE](LICENSE) file for more info.
