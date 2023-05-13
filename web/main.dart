import 'dart:html';

import 'components/collapse.dart';
import 'components/navbar.dart';

Element htmlStringToElement(String html) {
  DomParser parser = DomParser();
  Document doc = parser.parseFromString(html, "text/html");
  return doc.documentElement?.children[1].children[0] ?? Element.div();
}

Future<void> main() async {

  List<Collapse> collapses = [
    Collapse(
      Element.span()..text = 'Golden',
      Element.p()..text = 'checking this out',
    ),
    Collapse(
      Element.span()..text = 'Spurs',
      Element.p()..text = 'this is it',
    ),
    Collapse(
      Element.span()..text = 'Lakers',
      Element.p()..text = 'this is all you know',
    ),
  ];

  List<Menu> menus = [
    Menu(Element.a()..text = "Logs", []),
    Menu(Element.a()
      ..text = "Usage"
      ..className = "justify-between", 
    [
      Menu(Element.a()..text = "CPU", []),
      Menu(Element.a()..text = "Memory", []),
    ]),
    Menu(Element.a()..text = "Email", []),
  ];

  Navbar navbar = Navbar(
    Element.a()..text = 'Dashboard', 
    menus,
    Element.div()
  );

  List<Element> responses = await Future.wait([navbar.render(), ...collapses.map((e) => e.render())]);

  BodyElement body = querySelector('#output') as BodyElement;
  body.insertBefore(responses[0], body.firstChild);

  DivElement container = querySelector('#container') as DivElement;
  List<Element> list = responses
    .sublist(1)
    .map(
      (element) {
        DivElement div = DivElement();
        div.className = 'p-1';
        div.append(element);
        return div;
      }
    ).toList();

  container.children.addAll(list);
}
