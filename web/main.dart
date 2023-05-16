import 'dart:html';

import 'components/collapse.dart';
import 'components/navbar.dart';

Element htmlStringToElement(String html) {
  DomParser parser = DomParser();
  Document doc = parser.parseFromString(html, "text/html");
  return doc.documentElement?.children[1].children[0] ?? Element.div();
}

class Log {
  final String _header;
  final String _body;

  String get header => _header;
  String get body => _body;

  Log(this._header, this._body);
}

List<Collapse> logsWidget(List<Log> logs) {
  return logs
      .map((log) => Collapse(
            Element.span()..text = log.header,
            Element.p()..text = log.body,
          ))
      .toList();
}

Future<void> main() async {
  List<Collapse> logs = logsWidget([
    Log("Test", "support different loggers?"),
    Log("Okay", "learn more about json and dart"),
    Log("Fetch", "try fetching from api"),
    Log("SSR", "with golang possible?"),
  ]);

  List<Menu> menus = [
    Menu(Element.a()..text = "Logs", []),
    Menu(
        Element.a()
          ..text = "Usage"
          ..className = "justify-between",
        [
          Menu(
              Element.a()
                ..className = "bg-base-100"
                ..text = "CPU",
              []),
          Menu(
              Element.a()
                ..className = "bg-base-100"
                ..text = "Memory",
              []),
        ]),
    Menu(Element.a()..text = "Email", []),
  ];

  Navbar navbar = Navbar(
      Element.a()
        ..className = "btn btn-ghost normal-case text-xl"
        ..text = 'Dashboard',
      menus,
      Element.div());

  window.console.log(logs);
  List<Element> responses =
      await Future.wait([navbar.render(), ...logs.map((e) => e.render())]);

  BodyElement body = querySelector('#output') as BodyElement;
  body.insertBefore(responses[0], body.firstChild);

  DivElement logsContainer = querySelector('#logs_container') as DivElement;
  List<Element> list = responses.sublist(1).map((element) {
    DivElement div = DivElement();
    div.className = 'p-1';
    div.append(element);
    return div;
  }).toList();

  logsContainer.children.addAll(list);
}
