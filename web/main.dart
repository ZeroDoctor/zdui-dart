import 'dart:html';

import 'util/html.dart';

Future<void> main() async {
  BodyElement body = querySelector('#output') as BodyElement;
  body.children.add(htmlStringToElement("""
    <div class="container mx-auto flex justify-center h-screen items-center">
      <a href="/pages/page.html">link to pages</a>
    </div>
"""));
}
