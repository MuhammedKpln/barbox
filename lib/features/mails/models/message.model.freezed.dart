// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Messages _$MessagesFromJson(Map<String, dynamic> json) {
  return _Messages.fromJson(json);
}

/// @nodoc
mixin _$Messages {
  @JsonKey(name: "hydra:member")
  List<Message> get hydraMember => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:totalItems")
  int get hydraTotalItems => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:view")
  HydraView? get hydraView => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:search")
  HydraSearch? get hydraSearch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagesCopyWith<Messages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesCopyWith<$Res> {
  factory $MessagesCopyWith(Messages value, $Res Function(Messages) then) =
      _$MessagesCopyWithImpl<$Res, Messages>;
  @useResult
  $Res call(
      {@JsonKey(name: "hydra:member") List<Message> hydraMember,
      @JsonKey(name: "hydra:totalItems") int hydraTotalItems,
      @JsonKey(name: "hydra:view") HydraView? hydraView,
      @JsonKey(name: "hydra:search") HydraSearch? hydraSearch});

  $HydraViewCopyWith<$Res>? get hydraView;
  $HydraSearchCopyWith<$Res>? get hydraSearch;
}

/// @nodoc
class _$MessagesCopyWithImpl<$Res, $Val extends Messages>
    implements $MessagesCopyWith<$Res> {
  _$MessagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hydraMember = null,
    Object? hydraTotalItems = null,
    Object? hydraView = freezed,
    Object? hydraSearch = freezed,
  }) {
    return _then(_value.copyWith(
      hydraMember: null == hydraMember
          ? _value.hydraMember
          : hydraMember // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      hydraTotalItems: null == hydraTotalItems
          ? _value.hydraTotalItems
          : hydraTotalItems // ignore: cast_nullable_to_non_nullable
              as int,
      hydraView: freezed == hydraView
          ? _value.hydraView
          : hydraView // ignore: cast_nullable_to_non_nullable
              as HydraView?,
      hydraSearch: freezed == hydraSearch
          ? _value.hydraSearch
          : hydraSearch // ignore: cast_nullable_to_non_nullable
              as HydraSearch?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HydraViewCopyWith<$Res>? get hydraView {
    if (_value.hydraView == null) {
      return null;
    }

    return $HydraViewCopyWith<$Res>(_value.hydraView!, (value) {
      return _then(_value.copyWith(hydraView: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $HydraSearchCopyWith<$Res>? get hydraSearch {
    if (_value.hydraSearch == null) {
      return null;
    }

    return $HydraSearchCopyWith<$Res>(_value.hydraSearch!, (value) {
      return _then(_value.copyWith(hydraSearch: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessagesCopyWith<$Res> implements $MessagesCopyWith<$Res> {
  factory _$$_MessagesCopyWith(
          _$_Messages value, $Res Function(_$_Messages) then) =
      __$$_MessagesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "hydra:member") List<Message> hydraMember,
      @JsonKey(name: "hydra:totalItems") int hydraTotalItems,
      @JsonKey(name: "hydra:view") HydraView? hydraView,
      @JsonKey(name: "hydra:search") HydraSearch? hydraSearch});

  @override
  $HydraViewCopyWith<$Res>? get hydraView;
  @override
  $HydraSearchCopyWith<$Res>? get hydraSearch;
}

/// @nodoc
class __$$_MessagesCopyWithImpl<$Res>
    extends _$MessagesCopyWithImpl<$Res, _$_Messages>
    implements _$$_MessagesCopyWith<$Res> {
  __$$_MessagesCopyWithImpl(
      _$_Messages _value, $Res Function(_$_Messages) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hydraMember = null,
    Object? hydraTotalItems = null,
    Object? hydraView = freezed,
    Object? hydraSearch = freezed,
  }) {
    return _then(_$_Messages(
      hydraMember: null == hydraMember
          ? _value._hydraMember
          : hydraMember // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      hydraTotalItems: null == hydraTotalItems
          ? _value.hydraTotalItems
          : hydraTotalItems // ignore: cast_nullable_to_non_nullable
              as int,
      hydraView: freezed == hydraView
          ? _value.hydraView
          : hydraView // ignore: cast_nullable_to_non_nullable
              as HydraView?,
      hydraSearch: freezed == hydraSearch
          ? _value.hydraSearch
          : hydraSearch // ignore: cast_nullable_to_non_nullable
              as HydraSearch?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Messages implements _Messages {
  const _$_Messages(
      {@JsonKey(name: "hydra:member") required final List<Message> hydraMember,
      @JsonKey(name: "hydra:totalItems") required this.hydraTotalItems,
      @JsonKey(name: "hydra:view") this.hydraView,
      @JsonKey(name: "hydra:search") this.hydraSearch})
      : _hydraMember = hydraMember;

  factory _$_Messages.fromJson(Map<String, dynamic> json) =>
      _$$_MessagesFromJson(json);

  final List<Message> _hydraMember;
  @override
  @JsonKey(name: "hydra:member")
  List<Message> get hydraMember {
    if (_hydraMember is EqualUnmodifiableListView) return _hydraMember;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hydraMember);
  }

  @override
  @JsonKey(name: "hydra:totalItems")
  final int hydraTotalItems;
  @override
  @JsonKey(name: "hydra:view")
  final HydraView? hydraView;
  @override
  @JsonKey(name: "hydra:search")
  final HydraSearch? hydraSearch;

  @override
  String toString() {
    return 'Messages(hydraMember: $hydraMember, hydraTotalItems: $hydraTotalItems, hydraView: $hydraView, hydraSearch: $hydraSearch)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Messages &&
            const DeepCollectionEquality()
                .equals(other._hydraMember, _hydraMember) &&
            (identical(other.hydraTotalItems, hydraTotalItems) ||
                other.hydraTotalItems == hydraTotalItems) &&
            (identical(other.hydraView, hydraView) ||
                other.hydraView == hydraView) &&
            (identical(other.hydraSearch, hydraSearch) ||
                other.hydraSearch == hydraSearch));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_hydraMember),
      hydraTotalItems,
      hydraView,
      hydraSearch);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessagesCopyWith<_$_Messages> get copyWith =>
      __$$_MessagesCopyWithImpl<_$_Messages>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessagesToJson(
      this,
    );
  }
}

abstract class _Messages implements Messages {
  const factory _Messages(
      {@JsonKey(name: "hydra:member")
          required final List<Message> hydraMember,
      @JsonKey(name: "hydra:totalItems")
          required final int hydraTotalItems,
      @JsonKey(name: "hydra:view")
          final HydraView? hydraView,
      @JsonKey(name: "hydra:search")
          final HydraSearch? hydraSearch}) = _$_Messages;

  factory _Messages.fromJson(Map<String, dynamic> json) = _$_Messages.fromJson;

  @override
  @JsonKey(name: "hydra:member")
  List<Message> get hydraMember;
  @override
  @JsonKey(name: "hydra:totalItems")
  int get hydraTotalItems;
  @override
  @JsonKey(name: "hydra:view")
  HydraView? get hydraView;
  @override
  @JsonKey(name: "hydra:search")
  HydraSearch? get hydraSearch;
  @override
  @JsonKey(ignore: true)
  _$$_MessagesCopyWith<_$_Messages> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  @JsonKey(name: "@id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "@type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "@context")
  String? get context => throw _privateConstructorUsedError;
  @JsonKey(name: "id")
  String get hydraMemberId => throw _privateConstructorUsedError;
  String get accountId => throw _privateConstructorUsedError;
  String get msgid => throw _privateConstructorUsedError;
  MessageFrom get from => throw _privateConstructorUsedError;
  List<MessageFrom>? get to => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get intro => throw _privateConstructorUsedError;
  bool get seen => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  bool get hasAttachments => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get downloadUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(name: "@id") String? id,
      @JsonKey(name: "@type") String? type,
      @JsonKey(name: "@context") String? context,
      @JsonKey(name: "id") String hydraMemberId,
      String accountId,
      String msgid,
      MessageFrom from,
      List<MessageFrom>? to,
      String subject,
      String intro,
      bool seen,
      bool isDeleted,
      bool hasAttachments,
      int size,
      String downloadUrl,
      DateTime createdAt,
      DateTime updatedAt});

  $MessageFromCopyWith<$Res> get from;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? context = freezed,
    Object? hydraMemberId = null,
    Object? accountId = null,
    Object? msgid = null,
    Object? from = null,
    Object? to = freezed,
    Object? subject = null,
    Object? intro = null,
    Object? seen = null,
    Object? isDeleted = null,
    Object? hasAttachments = null,
    Object? size = null,
    Object? downloadUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraMemberId: null == hydraMemberId
          ? _value.hydraMemberId
          : hydraMemberId // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      msgid: null == msgid
          ? _value.msgid
          : msgid // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as MessageFrom,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as List<MessageFrom>?,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      intro: null == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAttachments: null == hasAttachments
          ? _value.hasAttachments
          : hasAttachments // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageFromCopyWith<$Res> get from {
    return $MessageFromCopyWith<$Res>(_value.from, (value) {
      return _then(_value.copyWith(from: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "@id") String? id,
      @JsonKey(name: "@type") String? type,
      @JsonKey(name: "@context") String? context,
      @JsonKey(name: "id") String hydraMemberId,
      String accountId,
      String msgid,
      MessageFrom from,
      List<MessageFrom>? to,
      String subject,
      String intro,
      bool seen,
      bool isDeleted,
      bool hasAttachments,
      int size,
      String downloadUrl,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $MessageFromCopyWith<$Res> get from;
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$_Message>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? context = freezed,
    Object? hydraMemberId = null,
    Object? accountId = null,
    Object? msgid = null,
    Object? from = null,
    Object? to = freezed,
    Object? subject = null,
    Object? intro = null,
    Object? seen = null,
    Object? isDeleted = null,
    Object? hasAttachments = null,
    Object? size = null,
    Object? downloadUrl = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_Message(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraMemberId: null == hydraMemberId
          ? _value.hydraMemberId
          : hydraMemberId // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      msgid: null == msgid
          ? _value.msgid
          : msgid // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as MessageFrom,
      to: freezed == to
          ? _value._to
          : to // ignore: cast_nullable_to_non_nullable
              as List<MessageFrom>?,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      intro: null == intro
          ? _value.intro
          : intro // ignore: cast_nullable_to_non_nullable
              as String,
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAttachments: null == hasAttachments
          ? _value.hasAttachments
          : hasAttachments // ignore: cast_nullable_to_non_nullable
              as bool,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message(
      {@JsonKey(name: "@id") this.id,
      @JsonKey(name: "@type") this.type,
      @JsonKey(name: "@context") this.context,
      @JsonKey(name: "id") required this.hydraMemberId,
      required this.accountId,
      required this.msgid,
      required this.from,
      required final List<MessageFrom>? to,
      required this.subject,
      required this.intro,
      required this.seen,
      required this.isDeleted,
      required this.hasAttachments,
      required this.size,
      required this.downloadUrl,
      required this.createdAt,
      required this.updatedAt})
      : _to = to;

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  @JsonKey(name: "@id")
  final String? id;
  @override
  @JsonKey(name: "@type")
  final String? type;
  @override
  @JsonKey(name: "@context")
  final String? context;
  @override
  @JsonKey(name: "id")
  final String hydraMemberId;
  @override
  final String accountId;
  @override
  final String msgid;
  @override
  final MessageFrom from;
  final List<MessageFrom>? _to;
  @override
  List<MessageFrom>? get to {
    final value = _to;
    if (value == null) return null;
    if (_to is EqualUnmodifiableListView) return _to;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String subject;
  @override
  final String intro;
  @override
  final bool seen;
  @override
  final bool isDeleted;
  @override
  final bool hasAttachments;
  @override
  final int size;
  @override
  final String downloadUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Message(id: $id, type: $type, context: $context, hydraMemberId: $hydraMemberId, accountId: $accountId, msgid: $msgid, from: $from, to: $to, subject: $subject, intro: $intro, seen: $seen, isDeleted: $isDeleted, hasAttachments: $hasAttachments, size: $size, downloadUrl: $downloadUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Message &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.hydraMemberId, hydraMemberId) ||
                other.hydraMemberId == hydraMemberId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.msgid, msgid) || other.msgid == msgid) &&
            (identical(other.from, from) || other.from == from) &&
            const DeepCollectionEquality().equals(other._to, _to) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.intro, intro) || other.intro == intro) &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.hasAttachments, hasAttachments) ||
                other.hasAttachments == hasAttachments) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      context,
      hydraMemberId,
      accountId,
      msgid,
      from,
      const DeepCollectionEquality().hash(_to),
      subject,
      intro,
      seen,
      isDeleted,
      hasAttachments,
      size,
      downloadUrl,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {@JsonKey(name: "@id") final String? id,
      @JsonKey(name: "@type") final String? type,
      @JsonKey(name: "@context") final String? context,
      @JsonKey(name: "id") required final String hydraMemberId,
      required final String accountId,
      required final String msgid,
      required final MessageFrom from,
      required final List<MessageFrom>? to,
      required final String subject,
      required final String intro,
      required final bool seen,
      required final bool isDeleted,
      required final bool hasAttachments,
      required final int size,
      required final String downloadUrl,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  @JsonKey(name: "@id")
  String? get id;
  @override
  @JsonKey(name: "@type")
  String? get type;
  @override
  @JsonKey(name: "@context")
  String? get context;
  @override
  @JsonKey(name: "id")
  String get hydraMemberId;
  @override
  String get accountId;
  @override
  String get msgid;
  @override
  MessageFrom get from;
  @override
  List<MessageFrom>? get to;
  @override
  String get subject;
  @override
  String get intro;
  @override
  bool get seen;
  @override
  bool get isDeleted;
  @override
  bool get hasAttachments;
  @override
  int get size;
  @override
  String get downloadUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageFrom _$MessageFromFromJson(Map<String, dynamic> json) {
  return _MessageFrom.fromJson(json);
}

/// @nodoc
mixin _$MessageFrom {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageFromCopyWith<MessageFrom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageFromCopyWith<$Res> {
  factory $MessageFromCopyWith(
          MessageFrom value, $Res Function(MessageFrom) then) =
      _$MessageFromCopyWithImpl<$Res, MessageFrom>;
  @useResult
  $Res call({String name, String address});
}

/// @nodoc
class _$MessageFromCopyWithImpl<$Res, $Val extends MessageFrom>
    implements $MessageFromCopyWith<$Res> {
  _$MessageFromCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageFromCopyWith<$Res>
    implements $MessageFromCopyWith<$Res> {
  factory _$$_MessageFromCopyWith(
          _$_MessageFrom value, $Res Function(_$_MessageFrom) then) =
      __$$_MessageFromCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String address});
}

/// @nodoc
class __$$_MessageFromCopyWithImpl<$Res>
    extends _$MessageFromCopyWithImpl<$Res, _$_MessageFrom>
    implements _$$_MessageFromCopyWith<$Res> {
  __$$_MessageFromCopyWithImpl(
      _$_MessageFrom _value, $Res Function(_$_MessageFrom) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
  }) {
    return _then(_$_MessageFrom(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageFrom implements _MessageFrom {
  const _$_MessageFrom({required this.name, required this.address});

  factory _$_MessageFrom.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromFromJson(json);

  @override
  final String name;
  @override
  final String address;

  @override
  String toString() {
    return 'MessageFrom(name: $name, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageFrom &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageFromCopyWith<_$_MessageFrom> get copyWith =>
      __$$_MessageFromCopyWithImpl<_$_MessageFrom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageFromToJson(
      this,
    );
  }
}

abstract class _MessageFrom implements MessageFrom {
  const factory _MessageFrom(
      {required final String name,
      required final String address}) = _$_MessageFrom;

  factory _MessageFrom.fromJson(Map<String, dynamic> json) =
      _$_MessageFrom.fromJson;

  @override
  String get name;
  @override
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_MessageFromCopyWith<_$_MessageFrom> get copyWith =>
      throw _privateConstructorUsedError;
}

HydraSearch _$HydraSearchFromJson(Map<String, dynamic> json) {
  return _HydraSearch.fromJson(json);
}

/// @nodoc
mixin _$HydraSearch {
  @JsonKey(name: "@type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:template")
  String? get hydraTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:variableRepresentation")
  String? get hydraVariableRepresentation => throw _privateConstructorUsedError;
  List<HydraMapping>? get hydraMapping => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HydraSearchCopyWith<HydraSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HydraSearchCopyWith<$Res> {
  factory $HydraSearchCopyWith(
          HydraSearch value, $Res Function(HydraSearch) then) =
      _$HydraSearchCopyWithImpl<$Res, HydraSearch>;
  @useResult
  $Res call(
      {@JsonKey(name: "@type")
          String? type,
      @JsonKey(name: "hydra:template")
          String? hydraTemplate,
      @JsonKey(name: "hydra:variableRepresentation")
          String? hydraVariableRepresentation,
      List<HydraMapping>? hydraMapping});
}

/// @nodoc
class _$HydraSearchCopyWithImpl<$Res, $Val extends HydraSearch>
    implements $HydraSearchCopyWith<$Res> {
  _$HydraSearchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? hydraTemplate = freezed,
    Object? hydraVariableRepresentation = freezed,
    Object? hydraMapping = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraTemplate: freezed == hydraTemplate
          ? _value.hydraTemplate
          : hydraTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraVariableRepresentation: freezed == hydraVariableRepresentation
          ? _value.hydraVariableRepresentation
          : hydraVariableRepresentation // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraMapping: freezed == hydraMapping
          ? _value.hydraMapping
          : hydraMapping // ignore: cast_nullable_to_non_nullable
              as List<HydraMapping>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HydraSearchCopyWith<$Res>
    implements $HydraSearchCopyWith<$Res> {
  factory _$$_HydraSearchCopyWith(
          _$_HydraSearch value, $Res Function(_$_HydraSearch) then) =
      __$$_HydraSearchCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "@type")
          String? type,
      @JsonKey(name: "hydra:template")
          String? hydraTemplate,
      @JsonKey(name: "hydra:variableRepresentation")
          String? hydraVariableRepresentation,
      List<HydraMapping>? hydraMapping});
}

/// @nodoc
class __$$_HydraSearchCopyWithImpl<$Res>
    extends _$HydraSearchCopyWithImpl<$Res, _$_HydraSearch>
    implements _$$_HydraSearchCopyWith<$Res> {
  __$$_HydraSearchCopyWithImpl(
      _$_HydraSearch _value, $Res Function(_$_HydraSearch) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? hydraTemplate = freezed,
    Object? hydraVariableRepresentation = freezed,
    Object? hydraMapping = freezed,
  }) {
    return _then(_$_HydraSearch(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraTemplate: freezed == hydraTemplate
          ? _value.hydraTemplate
          : hydraTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraVariableRepresentation: freezed == hydraVariableRepresentation
          ? _value.hydraVariableRepresentation
          : hydraVariableRepresentation // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraMapping: freezed == hydraMapping
          ? _value._hydraMapping
          : hydraMapping // ignore: cast_nullable_to_non_nullable
              as List<HydraMapping>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HydraSearch implements _HydraSearch {
  const _$_HydraSearch(
      {@JsonKey(name: "@type")
          this.type,
      @JsonKey(name: "hydra:template")
          this.hydraTemplate,
      @JsonKey(name: "hydra:variableRepresentation")
          this.hydraVariableRepresentation,
      final List<HydraMapping>? hydraMapping})
      : _hydraMapping = hydraMapping;

  factory _$_HydraSearch.fromJson(Map<String, dynamic> json) =>
      _$$_HydraSearchFromJson(json);

  @override
  @JsonKey(name: "@type")
  final String? type;
  @override
  @JsonKey(name: "hydra:template")
  final String? hydraTemplate;
  @override
  @JsonKey(name: "hydra:variableRepresentation")
  final String? hydraVariableRepresentation;
  final List<HydraMapping>? _hydraMapping;
  @override
  List<HydraMapping>? get hydraMapping {
    final value = _hydraMapping;
    if (value == null) return null;
    if (_hydraMapping is EqualUnmodifiableListView) return _hydraMapping;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'HydraSearch(type: $type, hydraTemplate: $hydraTemplate, hydraVariableRepresentation: $hydraVariableRepresentation, hydraMapping: $hydraMapping)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HydraSearch &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hydraTemplate, hydraTemplate) ||
                other.hydraTemplate == hydraTemplate) &&
            (identical(other.hydraVariableRepresentation,
                    hydraVariableRepresentation) ||
                other.hydraVariableRepresentation ==
                    hydraVariableRepresentation) &&
            const DeepCollectionEquality()
                .equals(other._hydraMapping, _hydraMapping));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      hydraTemplate,
      hydraVariableRepresentation,
      const DeepCollectionEquality().hash(_hydraMapping));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HydraSearchCopyWith<_$_HydraSearch> get copyWith =>
      __$$_HydraSearchCopyWithImpl<_$_HydraSearch>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HydraSearchToJson(
      this,
    );
  }
}

abstract class _HydraSearch implements HydraSearch {
  const factory _HydraSearch(
      {@JsonKey(name: "@type")
          final String? type,
      @JsonKey(name: "hydra:template")
          final String? hydraTemplate,
      @JsonKey(name: "hydra:variableRepresentation")
          final String? hydraVariableRepresentation,
      final List<HydraMapping>? hydraMapping}) = _$_HydraSearch;

  factory _HydraSearch.fromJson(Map<String, dynamic> json) =
      _$_HydraSearch.fromJson;

  @override
  @JsonKey(name: "@type")
  String? get type;
  @override
  @JsonKey(name: "hydra:template")
  String? get hydraTemplate;
  @override
  @JsonKey(name: "hydra:variableRepresentation")
  String? get hydraVariableRepresentation;
  @override
  List<HydraMapping>? get hydraMapping;
  @override
  @JsonKey(ignore: true)
  _$$_HydraSearchCopyWith<_$_HydraSearch> get copyWith =>
      throw _privateConstructorUsedError;
}

HydraMapping _$HydraMappingFromJson(Map<String, dynamic> json) {
  return _HydraMapping.fromJson(json);
}

/// @nodoc
mixin _$HydraMapping {
  @JsonKey(name: "@type")
  String? get type => throw _privateConstructorUsedError;
  String? get variable => throw _privateConstructorUsedError;
  String? get property => throw _privateConstructorUsedError;
  bool? get required => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HydraMappingCopyWith<HydraMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HydraMappingCopyWith<$Res> {
  factory $HydraMappingCopyWith(
          HydraMapping value, $Res Function(HydraMapping) then) =
      _$HydraMappingCopyWithImpl<$Res, HydraMapping>;
  @useResult
  $Res call(
      {@JsonKey(name: "@type") String? type,
      String? variable,
      String? property,
      bool? required});
}

/// @nodoc
class _$HydraMappingCopyWithImpl<$Res, $Val extends HydraMapping>
    implements $HydraMappingCopyWith<$Res> {
  _$HydraMappingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? variable = freezed,
    Object? property = freezed,
    Object? required = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      variable: freezed == variable
          ? _value.variable
          : variable // ignore: cast_nullable_to_non_nullable
              as String?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as String?,
      required: freezed == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HydraMappingCopyWith<$Res>
    implements $HydraMappingCopyWith<$Res> {
  factory _$$_HydraMappingCopyWith(
          _$_HydraMapping value, $Res Function(_$_HydraMapping) then) =
      __$$_HydraMappingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "@type") String? type,
      String? variable,
      String? property,
      bool? required});
}

/// @nodoc
class __$$_HydraMappingCopyWithImpl<$Res>
    extends _$HydraMappingCopyWithImpl<$Res, _$_HydraMapping>
    implements _$$_HydraMappingCopyWith<$Res> {
  __$$_HydraMappingCopyWithImpl(
      _$_HydraMapping _value, $Res Function(_$_HydraMapping) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? variable = freezed,
    Object? property = freezed,
    Object? required = freezed,
  }) {
    return _then(_$_HydraMapping(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      variable: freezed == variable
          ? _value.variable
          : variable // ignore: cast_nullable_to_non_nullable
              as String?,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as String?,
      required: freezed == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HydraMapping implements _HydraMapping {
  const _$_HydraMapping(
      {@JsonKey(name: "@type") this.type,
      this.variable,
      this.property,
      this.required});

  factory _$_HydraMapping.fromJson(Map<String, dynamic> json) =>
      _$$_HydraMappingFromJson(json);

  @override
  @JsonKey(name: "@type")
  final String? type;
  @override
  final String? variable;
  @override
  final String? property;
  @override
  final bool? required;

  @override
  String toString() {
    return 'HydraMapping(type: $type, variable: $variable, property: $property, required: $required)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HydraMapping &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.variable, variable) ||
                other.variable == variable) &&
            (identical(other.property, property) ||
                other.property == property) &&
            (identical(other.required, required) ||
                other.required == required));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, variable, property, required);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HydraMappingCopyWith<_$_HydraMapping> get copyWith =>
      __$$_HydraMappingCopyWithImpl<_$_HydraMapping>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HydraMappingToJson(
      this,
    );
  }
}

abstract class _HydraMapping implements HydraMapping {
  const factory _HydraMapping(
      {@JsonKey(name: "@type") final String? type,
      final String? variable,
      final String? property,
      final bool? required}) = _$_HydraMapping;

  factory _HydraMapping.fromJson(Map<String, dynamic> json) =
      _$_HydraMapping.fromJson;

  @override
  @JsonKey(name: "@type")
  String? get type;
  @override
  String? get variable;
  @override
  String? get property;
  @override
  bool? get required;
  @override
  @JsonKey(ignore: true)
  _$$_HydraMappingCopyWith<_$_HydraMapping> get copyWith =>
      throw _privateConstructorUsedError;
}

HydraView _$HydraViewFromJson(Map<String, dynamic> json) {
  return _HydraView.fromJson(json);
}

/// @nodoc
mixin _$HydraView {
  @JsonKey(name: "@id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "@type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:first")
  String get hydraFirst => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:last")
  String get hydraLast => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:previous")
  String get hydraPrevious => throw _privateConstructorUsedError;
  @JsonKey(name: "hydra:next")
  String get hydraNext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HydraViewCopyWith<HydraView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HydraViewCopyWith<$Res> {
  factory $HydraViewCopyWith(HydraView value, $Res Function(HydraView) then) =
      _$HydraViewCopyWithImpl<$Res, HydraView>;
  @useResult
  $Res call(
      {@JsonKey(name: "@id") String? id,
      @JsonKey(name: "@type") String? type,
      @JsonKey(name: "hydra:first") String hydraFirst,
      @JsonKey(name: "hydra:last") String hydraLast,
      @JsonKey(name: "hydra:previous") String hydraPrevious,
      @JsonKey(name: "hydra:next") String hydraNext});
}

/// @nodoc
class _$HydraViewCopyWithImpl<$Res, $Val extends HydraView>
    implements $HydraViewCopyWith<$Res> {
  _$HydraViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? hydraFirst = null,
    Object? hydraLast = null,
    Object? hydraPrevious = null,
    Object? hydraNext = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraFirst: null == hydraFirst
          ? _value.hydraFirst
          : hydraFirst // ignore: cast_nullable_to_non_nullable
              as String,
      hydraLast: null == hydraLast
          ? _value.hydraLast
          : hydraLast // ignore: cast_nullable_to_non_nullable
              as String,
      hydraPrevious: null == hydraPrevious
          ? _value.hydraPrevious
          : hydraPrevious // ignore: cast_nullable_to_non_nullable
              as String,
      hydraNext: null == hydraNext
          ? _value.hydraNext
          : hydraNext // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HydraViewCopyWith<$Res> implements $HydraViewCopyWith<$Res> {
  factory _$$_HydraViewCopyWith(
          _$_HydraView value, $Res Function(_$_HydraView) then) =
      __$$_HydraViewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "@id") String? id,
      @JsonKey(name: "@type") String? type,
      @JsonKey(name: "hydra:first") String hydraFirst,
      @JsonKey(name: "hydra:last") String hydraLast,
      @JsonKey(name: "hydra:previous") String hydraPrevious,
      @JsonKey(name: "hydra:next") String hydraNext});
}

/// @nodoc
class __$$_HydraViewCopyWithImpl<$Res>
    extends _$HydraViewCopyWithImpl<$Res, _$_HydraView>
    implements _$$_HydraViewCopyWith<$Res> {
  __$$_HydraViewCopyWithImpl(
      _$_HydraView _value, $Res Function(_$_HydraView) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? hydraFirst = null,
    Object? hydraLast = null,
    Object? hydraPrevious = null,
    Object? hydraNext = null,
  }) {
    return _then(_$_HydraView(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      hydraFirst: null == hydraFirst
          ? _value.hydraFirst
          : hydraFirst // ignore: cast_nullable_to_non_nullable
              as String,
      hydraLast: null == hydraLast
          ? _value.hydraLast
          : hydraLast // ignore: cast_nullable_to_non_nullable
              as String,
      hydraPrevious: null == hydraPrevious
          ? _value.hydraPrevious
          : hydraPrevious // ignore: cast_nullable_to_non_nullable
              as String,
      hydraNext: null == hydraNext
          ? _value.hydraNext
          : hydraNext // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HydraView implements _HydraView {
  const _$_HydraView(
      {@JsonKey(name: "@id") this.id,
      @JsonKey(name: "@type") this.type,
      @JsonKey(name: "hydra:first") required this.hydraFirst,
      @JsonKey(name: "hydra:last") required this.hydraLast,
      @JsonKey(name: "hydra:previous") required this.hydraPrevious,
      @JsonKey(name: "hydra:next") required this.hydraNext});

  factory _$_HydraView.fromJson(Map<String, dynamic> json) =>
      _$$_HydraViewFromJson(json);

  @override
  @JsonKey(name: "@id")
  final String? id;
  @override
  @JsonKey(name: "@type")
  final String? type;
  @override
  @JsonKey(name: "hydra:first")
  final String hydraFirst;
  @override
  @JsonKey(name: "hydra:last")
  final String hydraLast;
  @override
  @JsonKey(name: "hydra:previous")
  final String hydraPrevious;
  @override
  @JsonKey(name: "hydra:next")
  final String hydraNext;

  @override
  String toString() {
    return 'HydraView(id: $id, type: $type, hydraFirst: $hydraFirst, hydraLast: $hydraLast, hydraPrevious: $hydraPrevious, hydraNext: $hydraNext)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HydraView &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hydraFirst, hydraFirst) ||
                other.hydraFirst == hydraFirst) &&
            (identical(other.hydraLast, hydraLast) ||
                other.hydraLast == hydraLast) &&
            (identical(other.hydraPrevious, hydraPrevious) ||
                other.hydraPrevious == hydraPrevious) &&
            (identical(other.hydraNext, hydraNext) ||
                other.hydraNext == hydraNext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, hydraFirst, hydraLast, hydraPrevious, hydraNext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HydraViewCopyWith<_$_HydraView> get copyWith =>
      __$$_HydraViewCopyWithImpl<_$_HydraView>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HydraViewToJson(
      this,
    );
  }
}

abstract class _HydraView implements HydraView {
  const factory _HydraView(
          {@JsonKey(name: "@id") final String? id,
          @JsonKey(name: "@type") final String? type,
          @JsonKey(name: "hydra:first") required final String hydraFirst,
          @JsonKey(name: "hydra:last") required final String hydraLast,
          @JsonKey(name: "hydra:previous") required final String hydraPrevious,
          @JsonKey(name: "hydra:next") required final String hydraNext}) =
      _$_HydraView;

  factory _HydraView.fromJson(Map<String, dynamic> json) =
      _$_HydraView.fromJson;

  @override
  @JsonKey(name: "@id")
  String? get id;
  @override
  @JsonKey(name: "@type")
  String? get type;
  @override
  @JsonKey(name: "hydra:first")
  String get hydraFirst;
  @override
  @JsonKey(name: "hydra:last")
  String get hydraLast;
  @override
  @JsonKey(name: "hydra:previous")
  String get hydraPrevious;
  @override
  @JsonKey(name: "hydra:next")
  String get hydraNext;
  @override
  @JsonKey(ignore: true)
  _$$_HydraViewCopyWith<_$_HydraView> get copyWith =>
      throw _privateConstructorUsedError;
}
