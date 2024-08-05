class ListModel {
  final String id;
  final String name;
  final List<ListItem> items;

  const ListModel({required this.id, required this.name, required this.items});
}

class ListItem {
  final String id;
  final String name;
  String? subtitle;
  bool isDone = false;

  ListItem(
      {required this.id,
      required this.name,
      this.subtitle,
      required this.isDone});
}
