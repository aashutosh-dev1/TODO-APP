// ignore_for_file: public_member_api_docs, avoid_final_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed
class Either<L, R> with _$Either<L, R> {
  const factory Either.left(final L left) = Left<L, R>;

  const factory Either.right(final R right) = Right<L, R>;
}
