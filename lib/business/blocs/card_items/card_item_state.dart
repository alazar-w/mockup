part of 'card_item_bloc.dart';

class CardItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class CardItemInitState extends CardItemState {
  @override
  List<Object> get props => [];
}

class AddCardItemSuccess extends CardItemState {
  // final String description;
  AddCardItemSuccess();
  @override
  List<Object> get props => [];
}

class ListCardItemSuccess extends CardItemState {
  final List<CardItemModel> cardItem;
  ListCardItemSuccess(this.cardItem);
  @override
  List<Object> get props => [cardItem];
}

class CardItemDataLoading extends CardItemState {}

class CardItemDataError extends CardItemState {}
class ListCardItemError extends CardItemState {}