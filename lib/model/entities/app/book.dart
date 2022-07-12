import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pick_books/extensions/date_extension.dart';
import 'package:pick_books/model/converters/date_time_timestamp_converter.dart';
import 'package:pick_books/model/repositories/firestore/collection_paging_repository.dart';
import 'package:pick_books/model/repositories/firestore/document.dart';

part 'book.freezed.dart';
part 'book.g.dart';

/// CollectionPagingRepositoryProvider
final bookPagingProvider = Provider.family
    .autoDispose<CollectionPagingRepository<Book>, CollectionParam<Book>>(
        (ref, query) {
  return CollectionPagingRepository<Book>(
    query: query.query,
    limit: query.limit,
    decode: query.decode,
  );
});

/// Entity
@freezed
class Book with _$Book {
  const factory Book({
    String? bookId,
    String? title,
    String? url,
    String? description,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Book;
  const Book._();

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  static String collectionPath(String userId) =>
      'sample/v1/users/$userId/books';
  static CollectionReference<SnapType> colRef(String userId) =>
      Document.colRef(collectionPath(userId));

  static String docPath(String userId, String id) =>
      '${collectionPath(userId)}/$id';
  static DocumentReference<SnapType> docRef(String userId, String id) =>
      Document.docRefWithDocPath(docPath(userId, id));

  Map<String, dynamic> get toCreateDoc => <String, dynamic>{
        'bookId': bookId,
        'title': title,
        'url': url,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> get toUpdateDoc => <String, dynamic>{
        'title': title,
        'url': url,
        'description': description,
        'updatedAt': FieldValue.serverTimestamp(),
      };

  String get dateLabel {
    final date = createdAt;
    if (date == null) {
      return '-';
    }
    return date.format(pattern: 'yyyy.M.d HH:mm');
  }
}
