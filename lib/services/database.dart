import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:incident_report/services/global.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;

  DocumentReference ref;
  CollectionReference colRef;

  DatabaseService({this.path}) {
    ref = _db.doc(path);
    // colRef = _db.collection(path);
  }

  DocumentReference createRef() {
    return ref;
  }
}

class SubCategory<T> {
  Future<List<T>> getSubSubData(List<DocumentReference> listRef) {
    print('INTERIEUR FUTURE');
    print(listRef);
    return Future.wait(listRef
        .map((ref) => ref.get().then((doc) {
              print('THE DATA');
              print(doc.data());
              return Global.models[T]({'id': doc.id, ...doc.data()}) as T;
            }))
        .toList());
  }
}

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;

  DocumentReference ref;

  Document({this.path}) {
    ref = _db.doc(path);
  }

  Future<T> getData() {
    return ref
        .get()
        .then((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T);
  }

  // Future<List<T>> getSubSubData(List<DocumentReference> listRef) {
  //   return Future.wait(listRef.map(
  //       (ref) => ref.get().then((doc) => Global.models[T](doc.data()) as T)));
  // }

  // List<Future<T>> getSubData(List<DocumentReference> listRef) {
  //   return listRef
  //       .map(
  //           (ref) => ref.get().then((doc) => Global.models[T](doc.data()) as T))
  //       .toList();
  // }

  Stream<T> streamData() {
    return ref
        .snapshots()
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    // print('HERE IS THE SNAPSHOT');
    var snapshots = await ref.get();
    // print(snapshots.docs.map((doc) => doc.data()).toList());
    return snapshots.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T)
        .toList();
  }

  Future<List<T>> getProfiles(List<DocumentReference> members) async {
    return Future.wait(members
        .map((ref) => ref.get().then((doc) {
              print('THE DATA');
              print(doc.data());
              return Global.models[T]({'id': doc.id, ...doc.data()}) as T;
            }))
        .toList());
  }

  Future<List<T>> getDataById(String field, String uid) async {
    // print('HERE IS THE SNAPSHOT');
    var snapshots = await ref.where(field, isEqualTo: uid).get();
    print(snapshots.docs.map((doc) => doc.data()).toList());
    return snapshots.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T)
        .toList();
  }

  Future<List<T>> getDataByPlayerAndGoal(String goalID) async {
    print('THE GAOALS ARE');
    var snapshots = await ref.where('originalId', isEqualTo: goalID).get();
    print(snapshots.docs.map((doc) => doc.data()).toList());
    return snapshots.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T)
        .toList();
  }

  Future<List<T>> getDataByPlayer(String player, DateTime date) async {
    // print('HERE IS THE SNAPSHOT');
    var snapshots = await ref.where('player', isEqualTo: player).get();
    print(snapshots.docs.map((doc) => doc.data()).toList());
    var newsnapshot = snapshots.docs.where((element) =>
        (element.data()['endDate'] as Timestamp).toDate().isAfter(date));
    return newsnapshot.map((doc) {
      if ((doc.data()['endDate'] as Timestamp).toDate().isAfter(date)) {
        print('he is');
        return Global.models[T]({'id': doc.id, ...doc.data()}) as T;
      }
    }).toList();
  }

  Future<List<T>> getDatabyDateInf(String field) async {
    // print('HERE IS THE SNAPSHOT');
    var snapshots = await ref
        .where(field,
            isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .get();
    print(snapshots.docs.map((doc) => doc.data()).toList());
    return snapshots.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T)
        .toList();
  }
  // Future<List<T>> getDatabyDateInf(String field, String member) async {
  //   // print('HERE IS THE SNAPSHOT');
  //   var snapshots = await ref
  //       .where(field, isLessThan: Timestamp.fromDate(DateTime.now()))
  //       .get();
  //   print(snapshots.docs.map((doc) => doc.data()).toList());
  //   return snapshots.docs
  //       .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T)
  //       .toList();
  // }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((event) => event.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T));
  }

  Stream<List<T>> streamDataByField(String player, DateTime date) {
    print(player);
    print(date);
    ref.snapshots().map((event) => print('LOL'));
    return ref.snapshots().map((event) => event.docs.map((doc) {
          print('tema');
          print(doc.data());
          if ((doc.data()['endDate'] as Timestamp).toDate().isAfter(date))
            return Global.models[T]({'id': doc.id, ...doc.data()}) as T;
        }));
  }

  Future upsert(Map data) {
    return ref.add(data);
  }

  Future deleteById(String id) {
    return ref.doc(id).delete();
  }
}
