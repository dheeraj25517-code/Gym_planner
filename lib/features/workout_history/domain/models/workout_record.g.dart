// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutRecordCollection on Isar {
  IsarCollection<WorkoutRecord> get workoutRecords => this.collection();
}

const WorkoutRecordSchema = CollectionSchema(
  name: r'WorkoutRecord',
  id: -7749833127528171173,
  properties: {
    r'durationMinutes': PropertySchema(
      id: 0,
      name: r'durationMinutes',
      type: IsarType.long,
    ),
    r'focusGroup': PropertySchema(
      id: 1,
      name: r'focusGroup',
      type: IsarType.string,
    ),
    r'generalComments': PropertySchema(
      id: 2,
      name: r'generalComments',
      type: IsarType.string,
    ),
    r'loggedExercisesJson': PropertySchema(
      id: 3,
      name: r'loggedExercisesJson',
      type: IsarType.stringList,
    ),
    r'muscleNotes': PropertySchema(
      id: 4,
      name: r'muscleNotes',
      type: IsarType.string,
    ),
    r'performanceRating': PropertySchema(
      id: 5,
      name: r'performanceRating',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _workoutRecordEstimateSize,
  serialize: _workoutRecordSerialize,
  deserialize: _workoutRecordDeserialize,
  deserializeProp: _workoutRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _workoutRecordGetId,
  getLinks: _workoutRecordGetLinks,
  attach: _workoutRecordAttach,
  version: '3.1.0+1',
);

int _workoutRecordEstimateSize(
  WorkoutRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.focusGroup.length * 3;
  bytesCount += 3 + object.generalComments.length * 3;
  bytesCount += 3 + object.loggedExercisesJson.length * 3;
  {
    for (var i = 0; i < object.loggedExercisesJson.length; i++) {
      final value = object.loggedExercisesJson[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.muscleNotes.length * 3;
  return bytesCount;
}

void _workoutRecordSerialize(
  WorkoutRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.durationMinutes);
  writer.writeString(offsets[1], object.focusGroup);
  writer.writeString(offsets[2], object.generalComments);
  writer.writeStringList(offsets[3], object.loggedExercisesJson);
  writer.writeString(offsets[4], object.muscleNotes);
  writer.writeLong(offsets[5], object.performanceRating);
  writer.writeDateTime(offsets[6], object.timestamp);
}

WorkoutRecord _workoutRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutRecord();
  object.durationMinutes = reader.readLong(offsets[0]);
  object.focusGroup = reader.readString(offsets[1]);
  object.generalComments = reader.readString(offsets[2]);
  object.id = id;
  object.loggedExercisesJson = reader.readStringList(offsets[3]) ?? [];
  object.muscleNotes = reader.readString(offsets[4]);
  object.performanceRating = reader.readLong(offsets[5]);
  object.timestamp = reader.readDateTime(offsets[6]);
  return object;
}

P _workoutRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutRecordGetId(WorkoutRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutRecordGetLinks(WorkoutRecord object) {
  return [];
}

void _workoutRecordAttach(
    IsarCollection<dynamic> col, Id id, WorkoutRecord object) {
  object.id = id;
}

extension WorkoutRecordQueryWhereSort
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QWhere> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutRecordQueryWhere
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QWhereClause> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkoutRecordQueryFilter
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QFilterCondition> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      durationMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      durationMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      durationMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      durationMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'focusGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'focusGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'focusGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'focusGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      focusGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'focusGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'generalComments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'generalComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'generalComments',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'generalComments',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      generalCommentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'generalComments',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loggedExercisesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'loggedExercisesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'loggedExercisesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedExercisesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'loggedExercisesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      loggedExercisesJsonLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedExercisesJson',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'muscleNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'muscleNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'muscleNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'muscleNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      muscleNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'muscleNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      performanceRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'performanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      performanceRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'performanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      performanceRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'performanceRating',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      performanceRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'performanceRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WorkoutRecordQueryObject
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QFilterCondition> {}

extension WorkoutRecordQueryLinks
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QFilterCondition> {}

extension WorkoutRecordQuerySortBy
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QSortBy> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> sortByFocusGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusGroup', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByFocusGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusGroup', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByGeneralComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generalComments', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByGeneralCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generalComments', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> sortByMuscleNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleNotes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByMuscleNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleNotes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByPerformanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceRating', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByPerformanceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceRating', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension WorkoutRecordQuerySortThenBy
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QSortThenBy> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> thenByFocusGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusGroup', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByFocusGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'focusGroup', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByGeneralComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generalComments', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByGeneralCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'generalComments', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> thenByMuscleNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleNotes', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByMuscleNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'muscleNotes', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByPerformanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceRating', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByPerformanceRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'performanceRating', Sort.desc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension WorkoutRecordQueryWhereDistinct
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct> {
  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct>
      distinctByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMinutes');
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct> distinctByFocusGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'focusGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct>
      distinctByGeneralComments({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'generalComments',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct>
      distinctByLoggedExercisesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loggedExercisesJson');
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct> distinctByMuscleNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'muscleNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct>
      distinctByPerformanceRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'performanceRating');
    });
  }

  QueryBuilder<WorkoutRecord, WorkoutRecord, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension WorkoutRecordQueryProperty
    on QueryBuilder<WorkoutRecord, WorkoutRecord, QQueryProperty> {
  QueryBuilder<WorkoutRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutRecord, int, QQueryOperations> durationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMinutes');
    });
  }

  QueryBuilder<WorkoutRecord, String, QQueryOperations> focusGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'focusGroup');
    });
  }

  QueryBuilder<WorkoutRecord, String, QQueryOperations>
      generalCommentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'generalComments');
    });
  }

  QueryBuilder<WorkoutRecord, List<String>, QQueryOperations>
      loggedExercisesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedExercisesJson');
    });
  }

  QueryBuilder<WorkoutRecord, String, QQueryOperations> muscleNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'muscleNotes');
    });
  }

  QueryBuilder<WorkoutRecord, int, QQueryOperations>
      performanceRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'performanceRating');
    });
  }

  QueryBuilder<WorkoutRecord, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
