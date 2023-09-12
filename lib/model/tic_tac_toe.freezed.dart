// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tic_tac_toe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TicTacToe {
  List<List<String>> get board => throw _privateConstructorUsedError;
  String get currentPlayer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicTacToeCopyWith<TicTacToe> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicTacToeCopyWith<$Res> {
  factory $TicTacToeCopyWith(TicTacToe value, $Res Function(TicTacToe) then) =
      _$TicTacToeCopyWithImpl<$Res, TicTacToe>;
  @useResult
  $Res call({List<List<String>> board, String currentPlayer});
}

/// @nodoc
class _$TicTacToeCopyWithImpl<$Res, $Val extends TicTacToe>
    implements $TicTacToeCopyWith<$Res> {
  _$TicTacToeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TicTacToeCopyWith<$Res> implements $TicTacToeCopyWith<$Res> {
  factory _$$_TicTacToeCopyWith(
          _$_TicTacToe value, $Res Function(_$_TicTacToe) then) =
      __$$_TicTacToeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<String>> board, String currentPlayer});
}

/// @nodoc
class __$$_TicTacToeCopyWithImpl<$Res>
    extends _$TicTacToeCopyWithImpl<$Res, _$_TicTacToe>
    implements _$$_TicTacToeCopyWith<$Res> {
  __$$_TicTacToeCopyWithImpl(
      _$_TicTacToe _value, $Res Function(_$_TicTacToe) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? currentPlayer = null,
  }) {
    return _then(_$_TicTacToe(
      board: null == board
          ? _value._board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TicTacToe extends _TicTacToe {
  const _$_TicTacToe(
      {required final List<List<String>> board, required this.currentPlayer})
      : _board = board,
        super._();

  final List<List<String>> _board;
  @override
  List<List<String>> get board {
    if (_board is EqualUnmodifiableListView) return _board;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_board);
  }

  @override
  final String currentPlayer;

  @override
  String toString() {
    return 'TicTacToe(board: $board, currentPlayer: $currentPlayer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TicTacToe &&
            const DeepCollectionEquality().equals(other._board, _board) &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_board), currentPlayer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TicTacToeCopyWith<_$_TicTacToe> get copyWith =>
      __$$_TicTacToeCopyWithImpl<_$_TicTacToe>(this, _$identity);
}

abstract class _TicTacToe extends TicTacToe {
  const factory _TicTacToe(
      {required final List<List<String>> board,
      required final String currentPlayer}) = _$_TicTacToe;
  const _TicTacToe._() : super._();

  @override
  List<List<String>> get board;
  @override
  String get currentPlayer;
  @override
  @JsonKey(ignore: true)
  _$$_TicTacToeCopyWith<_$_TicTacToe> get copyWith =>
      throw _privateConstructorUsedError;
}
