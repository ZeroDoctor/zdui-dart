import 'dart:html';

import 'components/navbar.dart';

Element htmlStringToElement(String html) {
  DomParser parser = DomParser();
  Document doc = parser.parseFromString(html, "text/html");
  return doc.documentElement?.children[1].children[0] ?? Element.div();
}

Future<void> main() async {
  List<Menu> menus = [
    Menu(() {
      AnchorElement a = AnchorElement();
      a.text = "Logs";
      return a;
    }(), []),
    Menu(() {
      AnchorElement a = AnchorElement();
      a.text = "Usage";
      return a;
    }(), [
      Menu(() {
        AnchorElement a = AnchorElement();
        a.text = "CPU";
        return a;
      }(), []),
      Menu(() {
        AnchorElement a = AnchorElement();
        a.text = "Memory";
        return a;
      }(), []),
    ]),
    Menu(() {
      AnchorElement a = AnchorElement();
      a.text = "Email";
      return a;
    }(), []),
  ];

  Navbar navbar = Navbar("Dashboard", menus);

  // to render components in parallel do:
  //  List<String> responses = await Future.wait([navbar.render(), navbar.render()]);

  Element renderElement = htmlStringToElement(await navbar.render());

  BodyElement output = querySelector('#output') as BodyElement;
  output.insertBefore(renderElement, output.firstChild);
}
