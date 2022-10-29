class AddPasswordModel {
  final String id;
  final String title;
  final String? url;
  final String username;
  final String password;
  final String? notes;
  // final String date;
  const AddPasswordModel({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    // required this.date,
    this.url,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'username': username,
      'password': password,
      'notes': notes,
      // 'date': DateFormat.yMd().format(date).toString(),
    };
  }

  factory AddPasswordModel.fromMap(Map<String, dynamic> map) {
    return AddPasswordModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      url: map['url'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      notes: map['notes'] ?? '',
      // date: DateFormat.yMd().parse(map['date']) ?? '',
    );
  }
  // @override
  // String toString() =>
  //     'trans(id: $id,title: $title, url: $url, username: $username, password: $password, notes: $notes)';
}
