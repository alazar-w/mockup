part of 'card_item_bloc.dart';

class CardItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ListCardItem extends CardItemEvent {
  @override
  List<Object> get props => [];
}

class AddCardItemEvent extends CardItemEvent {
  final String description;
  final String source;
  final String progress;
  final String dueDate;

  AddCardItemEvent(this.description, this.source, this.progress, this.dueDate);

  @override
  List<Object> get props => [description, source, progress, dueDate];
}

class EditCardItemEvent extends CardItemEvent {
  final String documentID;
  final String description;


  EditCardItemEvent(this.documentID, this.description);

  @override
  List<Object> get props =>
      [documentID, description];
}

class RemoveCardItemEvent extends CardItemEvent {
  final String documentID;

  RemoveCardItemEvent(this.documentID);

  @override
  List<Object> get props => [documentID];
}
