class Memo {
  final String key;
  String title;
  String body;

  Memo(this.title, this.body, {this.key});

  factory Memo.fromMap(Map<String, dynamic> memo) {
    return Memo(memo['title'], memo['body'], key: memo['key']);
  }

  Map<String, dynamic> asMap() => {
        'title': title,
        'body': body,
      };

  @override
  bool operator ==(o) {
    return o is Memo && o.key == key;
  }
}
