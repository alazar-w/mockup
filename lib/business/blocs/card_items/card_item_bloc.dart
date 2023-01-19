import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_mockup/business/business.dart';
import 'package:interview_mockup/data/data.dart';
part 'card_item_event.dart';
part 'card_item_state.dart';



class CardItemBloc extends Bloc<CardItemEvent, CardItemState> {
  CardItemBloc({
    CardItemState? cardState,
  }) : super(CardItemInitState()) {
    //create cardItem
    on<AddCardItemEvent>(_addCardItem);

    //edit cardItem
    on<EditCardItemEvent>(_editCardItem);

    //list cardItem
    on<ListCardItem>(_listCardItem);

    //remove cardItem
    on<RemoveCardItemEvent>(_removeCardItem);



  }

  Future<void> _addCardItem(
      AddCardItemEvent event, Emitter emit) async {

    emit(CardItemDataLoading());
    try {
      await FirebaseAccess().addCardItem(event.description,event.source,event.dueDate,event.progress);
      var cardItems = await FirebaseAccess().listAllCardItem();
      emit(ListCardItemSuccess(cardItems));
      // emit(AddCardItemSuccess());
    } catch (e) {
      emit(CardItemDataError());
    }
  }

  Future<void> _editCardItem(EditCardItemEvent event, Emitter emit) async{

    emit(CardItemDataLoading());
    try {
      await FirebaseAccess().updateCardItem(event.documentID,event.description);
      var cardItems = await FirebaseAccess().listAllCardItem();

      emit(ListCardItemSuccess(cardItems));
    } catch (e) {
      emit(CardItemDataError());
    }

  }

  Future<void> _listCardItem(ListCardItem event, Emitter emit) async {
    emit(CardItemDataLoading());
    try {
      var cardItems = await FirebaseAccess().listAllCardItem();
      emit(ListCardItemSuccess(cardItems));
    } catch (e) {
      emit(ListCardItemError());
    }
  }


  Future<void> _removeCardItem( RemoveCardItemEvent event, Emitter emit) async{
    emit(CardItemDataLoading());
    try {
      await FirebaseAccess().deleteCardItem(event.documentID);
      var cardItems = await FirebaseAccess().listAllCardItem();
      emit(ListCardItemSuccess(cardItems));
    } catch (e) {
      emit(CardItemDataError());
    }
  }
}
