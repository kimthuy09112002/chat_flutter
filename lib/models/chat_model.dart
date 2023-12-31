class ChatModel {
  String? id;
  String? message;
  UserModel? user;
  bool? isRecalled;

  ChatModel();

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel()
    ..id = json['id'] as String?
    ..message = json['message'] as String?
    ..user = UserModel.fromJson(json['user'])
    ..isRecalled = json['isRecalled'];
}

class UserModel {
  String? id;
  String? name;
  String? image;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    image = json['image'] as String?;
  }
}

class FakeChats {
  static final chats = <ChatModel>[
    ChatModel.fromJson(libraryJson1),
    ChatModel.fromJson(libraryJson2),
    ChatModel.fromJson(libraryJson3),
    ChatModel.fromJson(libraryJson4),
    ChatModel.fromJson(libraryJson5),
    ChatModel.fromJson(libraryJson6),
    ChatModel.fromJson(libraryJson7),
  ];

  static const libraryJson1 = {
    'id': '1',
    'isRecalled' : false,
    'user': {
      'id': '1',
      'name': 'Lorem Ipsum',
      'image': 'abc',
      // 'image': 'https://picsum.photos/250?image=201',
    },
    'message':
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
  };

  static const libraryJson2 = {
    'id': '2',
    'isRecalled' : false,
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 2',
  };

  static const libraryJson3 = {
    'id': '3',
    'isRecalled' : false,
    'user': {
      'id': '1',
      'name': 'Bibliothèque 3',
      'image': 'https://picsum.photos/250?image=203',
    },
    'message': 'Description de la bibliothèque 3',
  };

  static const libraryJson4 = {
    'id': '4',
    'isRecalled' : false,
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 4',
  };

  static const libraryJson5 = {
    'id': '5',
    'isRecalled' : false,
    'user': {
      'id': '1',
      'name': 'Bibliothèque 3',
      'image': 'https://picsum.photos/250?image=203',
    },
    'message': 'Description de la bibliothèque 3',
  };

  static const libraryJson6 = {
    'id': '6',
    'isRecalled' : false,
    'user': {
      'id': '2',
      'name': 'Bibliothèque 2',
      'image': 'https://picsum.photos/250?image=202',
    },
    'message': 'Description de la bibliothèque 2',
  };

  static const libraryJson7 = {
    'id': '7',
    'isRecalled' : false,
    'user': {
      'id': '1',
      'name': 'Lorem Ipsum',
      'image': 'abc',
      // 'image': 'https://picsum.photos/250?image=201',
    },
    'message':
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
  };
}

