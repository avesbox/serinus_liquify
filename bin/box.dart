import 'package:serinus_liquify/serinus_liquify.dart';
import 'package:serinus_liquify/parser.dart';

class BoxTag extends AbstractTag with CustomTagParser {
  BoxTag(super.content, super.filters);

  @override
  dynamic evaluate(Evaluator evaluator, Buffer buffer) {
    String content = evaluator.evaluate(body[0]).toString().trim();
    print(content);
    content = Template.parse(content, data: evaluator.context.all()).render();

    String boxChar = this.content.isNotEmpty
        ? evaluator.evaluate(this.content[0]).toString()
        : '+';

    List<String> lines = content.split('\n');
    int maxLength = lines
        .map((line) => line.length)
        .reduce((a, b) => a > b ? a : b);

    String topBottom = boxChar * (maxLength);
    buffer.writeln(topBottom);

    for (String line in lines) {
      buffer.writeln('$boxChar ${line.padRight(maxLength)} $boxChar');
    }

    buffer.writeln(topBottom);
    print(buffer.toString());
  }

  @override
  Parser parser() {
    return (tagStart() &
            string('box').trim() &
            any().starLazy(tagEnd()).flatten().optional() &
            tagEnd() &
            any()
                .starLazy(tagStart() & string('endbox').trim() & tagEnd())
                .flatten() &
            tagStart() &
            string('endbox').trim() &
            tagEnd())
        .map((values) {
          var boxChar = values[2] != null ? TextNode(values[2]) : null;
          return Tag(
            "box",
            boxChar != null ? [boxChar] : [],
            body: [TextNode(values[4])],
          );
        });
  }
}
