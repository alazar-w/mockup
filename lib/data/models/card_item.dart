// {
//     "description": "",
//     "source":""
// }

class CardItemModel {
  CardItemModel({
    String? id,
    String? description,
    String? source,
    String? progress,
    String? dueDate,
  }) {
    _id = id;
    _description = description;
    _source = source;
    _progress = progress;
    _dueDate = dueDate;
  }

  CardItemModel.fromJson(dynamic json ) {
    _id = json['id'];
    _description = json['description'];
    _source = json['source'];
    _progress = json['progress'];
    _dueDate = json['dueDate'];

  }
  String? _id;
  String? _source;
  String? _description;
  String? _progress;
  String? _dueDate;


  CardItemModel copyWith({
    String? id,
    String? description,
    String? source,
    String? progress,
    String? dueDate
  }) =>
      CardItemModel(
        id: id ?? _id,
        source: description ?? _source,
        description: source ?? _description,
        progress: progress ?? _progress,
        dueDate: dueDate ?? _dueDate

      );

  String? get id => _id;
  String? get description => _source;
  String? get source => _description;
  String? get progress => _progress;
  String? get dueDate => _dueDate;

  Map<String, dynamic> toJson(CardItemModel newItems) {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['source'] = _source;
    map['progress'] = _progress;
    map['dueDate'] = _dueDate;
    return map;
  }
}
