abstract class Component {
  Future<String> render() async {
    throw Error();
  }
}
