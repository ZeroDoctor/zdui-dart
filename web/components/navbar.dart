import 'dart:html';

import '../structures/stack.dart';
import 'component.dart';

final String svgDropArrow =
    '<svg class="fill-current" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"><path d="M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z"/></svg>';
final String svgMenu =
    '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h8m-8 6h16" /></svg>';

class Menu {
  final Element element;
  final List<Menu> subMenus;

  Menu(this.element, this.subMenus);
}

class Navbar extends Component {
  final Element _startElement;
  final List<Menu> _menus;
  final Element _endElement; 
  final String _className;

  Navbar(this._startElement, this._menus, this._endElement, [this._className = '']);

  @override
  Future<Element> render() async {
    StringBuffer menuBuffer = StringBuffer();

    Stack<List<Menu>> listMenuStack = Stack<List<Menu>>();

    for (var menu in _menus) {
      LIElement rootLi = LIElement();
      rootLi.children.add(menu.element);
      if (menu.subMenus.isNotEmpty) {
        menu.element.children.add(htmlToElements(svgDropArrow));
        rootLi.setAttribute("tabindex", "0");
        listMenuStack.push(menu.subMenus);
      }

      while (listMenuStack.isNotEmpty) {
        UListElement ul = UListElement();
        ul.className = "p-2 z-50";

        for (var menu in listMenuStack.pop()) {
          LIElement li = LIElement();
          li.children.add(menu.element);
          if (menu.subMenus.isNotEmpty) {
            menu.element.children.add(htmlToElements(svgDropArrow));
            li.setAttribute("tabindex", "0");

            UListElement ul = UListElement();
            listMenuStack.push(menu.subMenus);
            li.children.add(ul);
          }

          ul.children.add(li);
        }

        rootLi.children.add(ul);
      }

      menuBuffer.write(rootLi.outerHtml);
    }

    return htmlToElements("""
<div class="navbar bg-base-100 z-50 $_className">
  <div class="navbar-start">
    <div class="dropdown">
      <label tabindex="0" class="btn btn-ghost lg:hidden">
        $svgMenu
      </label>
      <ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">
        ${menuBuffer.toString()}
      </ul>
    </div>

    ${_startElement.outerHtml}
  </div>

  <div class="navbar-center hidden lg:flex">
    <ul class="menu menu-horizontal px-1">
      ${menuBuffer.toString()}
    </ul>
  </div>

  <div class="navbar-end">
    ${_endElement.outerHtml}
  </div>
</div>
    """);
  }
}
