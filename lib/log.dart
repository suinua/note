class Log {
  static _MemoGroupLog get memoGroup => _MemoGroupLog();

  static _MemoLog get memo => _MemoLog();

  static _MemoLabelLog get label => _MemoLabelLog();
}

abstract class _LogTemplate {
  static void itemAdded(String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName added on bloc : $itemValue');

  static void itemRemoved(String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName removed on bloc : $itemValue');

  static void itemUpdated(String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName updated on bloc : $itemValue');

  static void itemAddedOnFirebase(
          String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName added on firebase : $itemValue');

  static void itemRemovedOnFirebase(
          String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName removed on firebase : $itemValue');

  static void itemUpdatedOnFirebase(
          String itemName, Map<String, dynamic> itemValue) =>
      print('$itemName updated on firebase : $itemValue');
}

class _MemoLog {
  void onAdded(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAdded('memo', itemValue);

  void onRemoved(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemoved('memo', itemValue);

  void onUpdated(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdated('memo', itemValue);

  void onAddedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAddedOnFirebase('memo', itemValue);

  void onRemovedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemovedOnFirebase('memo', itemValue);

  void onUpdatedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdatedOnFirebase('memo', itemValue);
}

class _MemoGroupLog {
  void onAdded(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAdded('memo group', itemValue);

  void onRemoved(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemoved('memo group', itemValue);

  void onUpdated(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdated('memo group', itemValue);

  void onAddedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAddedOnFirebase('memo group', itemValue);

  void onRemovedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemovedOnFirebase('memo group', itemValue);

  void onUpdatedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdatedOnFirebase('memo group', itemValue);
}

class _MemoLabelLog {
  void onAdded(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAdded('memo label', itemValue);

  void onRemoved(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemoved('memo label', itemValue);

  void onUpdated(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdated('memo label', itemValue);

  void onAddedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemAddedOnFirebase('memo label', itemValue);

  void onRemovedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemRemovedOnFirebase('memo label', itemValue);

  void onUpdatedOnFirebase(Map<String, dynamic> itemValue) =>
      _LogTemplate.itemUpdatedOnFirebase('memo label', itemValue);
}
