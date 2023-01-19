import 'package:interview_mockup/data/data.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAccess {
  static final Logger _logger = Logger();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference cardItems =
      FirebaseFirestore.instance.collection('cardItem');

  Future<void> populateMembers(String firstName, String lastName) async {
    try {
      final members = FirebaseFirestore.instance.collection('users').doc();
      members
          .set({
            'id': members.id,
            'firstName': firstName,
            'lastName': lastName,
          })
          .then((value) => _logger.i("User created"))
          .catchError((error) => _logger.i("Failed to create user: $error"));
    } catch (e) {
      _logger.e("error firebase create members");
    }
  }

  Future<void> listMembers(String userName) async {
    try {
      QuerySnapshot querySnapshot = await users.get();
      final members = querySnapshot.docs.map((doc) => doc.data()).toList();
      _logger.i("all members list :: ", members.toString());
    } catch (e) {
      _logger.e("error firebase list members :: ", e.toString());
    }
  }

  Future<dynamic> addCardItem(String description, String source, String dueDate,
      String progress) async {
    try {
      final docItems = FirebaseFirestore.instance.collection('cardItem').doc();

      var response = docItems
          .set({
            'id': docItems.id,
            'description': description,
            'source': source,
            'progress': progress,
            'dueDate': dueDate
          })
          .then((value) => _logger.i("cardItem created"))
          .catchError(
              (error) => _logger.e("Failed to create cardItem : $error"));
      return response;
    } catch (e) {
      _logger.e("error firebase creating cardItem  ", e.toString());
    }
  }

  Future<void> updateCardItem(String documentId, String description) async {
    final docItems =
        FirebaseFirestore.instance.collection('cardItem').doc(documentId);

    try {
      docItems
          .update({
            'description': description,
          })
          .then((value) => _logger.i("cardItem  Updated"))
          .catchError((error) => _logger.e("Failed to update cardItem"));
    } catch (e) {
      _logger.e("error firebase updating cardItem request ", e.toString());
    }
  }

  Future<dynamic> listAllCardItem() async {
    try {
      QuerySnapshot querySnapshot = await cardItems.get();
      List<CardItemModel> items = querySnapshot.docs
          .map((doc) => CardItemModel.fromJson(doc.data()))
          .toList();
      return items;
    } catch (e) {
      _logger.e("error firebase list cardItem request ", e.toString());
    }
  }

  Future<dynamic> deleteCardItem(String documentId) async {
    try {
      final docItems =
          FirebaseFirestore.instance.collection('cardItem').doc(documentId);

      var response = docItems
          .delete()
          .then((value) => _logger.i("cardItem deleted"))
          .catchError(
              (error) => _logger.e("Failed to delete cardItem : $error"));
      return response;
    } catch (e) {
      _logger.e("error firebase deleting cardItem  ", e.toString());
    }
  }

  void populateData() async {
    await FirebaseAccess().populateMembers("Sarah", "Cobb");
    await FirebaseAccess().populateMembers("Joshua", "Kennedy");
    await FirebaseAccess().populateMembers("Amanda", "Rogers");
    await FirebaseAccess().populateMembers("Felicia", "Kim");
    await FirebaseAccess().populateMembers("Melissa", "Montgomery");
    await FirebaseAccess().populateMembers("Catherine", "Silva");
    await FirebaseAccess().populateMembers("Taylor", "Buchanan");
    await FirebaseAccess().populateMembers("Brenda", "Davis");
    await FirebaseAccess().populateMembers("Justin", "Bowen");
    await FirebaseAccess().populateMembers("Matthew", "Valencia");
    await FirebaseAccess().addCardItem(
        "Overcome Key issues to meet key milestones drink from the firehose,yet beef up(let's no tryto) boil the ocean(here/there/everywhere).",
        "trello",
        "",
        "");
  }
}
