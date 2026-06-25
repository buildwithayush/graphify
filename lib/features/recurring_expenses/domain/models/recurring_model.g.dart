// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecurringModelCollection on Isar {
  IsarCollection<RecurringModel> get recurringModels => this.collection();
}

const RecurringModelSchema = CollectionSchema(
  name: r'RecurringModel',
  id: -1929543797265721733,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'lastLoggedDate': PropertySchema(
      id: 2,
      name: r'lastLoggedDate',
      type: IsarType.dateTime,
    ),
    r'recurringDay': PropertySchema(
      id: 3,
      name: r'recurringDay',
      type: IsarType.long,
    )
  },
  estimateSize: _recurringModelEstimateSize,
  serialize: _recurringModelSerialize,
  deserialize: _recurringModelDeserialize,
  deserializeProp: _recurringModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recurringModelGetId,
  getLinks: _recurringModelGetLinks,
  attach: _recurringModelAttach,
  version: '3.1.0+1',
);

int _recurringModelEstimateSize(
  RecurringModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  return bytesCount;
}

void _recurringModelSerialize(
  RecurringModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeString(offsets[1], object.category);
  writer.writeDateTime(offsets[2], object.lastLoggedDate);
  writer.writeLong(offsets[3], object.recurringDay);
}

RecurringModel _recurringModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecurringModel(
    amount: reader.readDouble(offsets[0]),
    category: reader.readString(offsets[1]),
    lastLoggedDate: reader.readDateTimeOrNull(offsets[2]),
    recurringDay: reader.readLong(offsets[3]),
  );
  object.id = id;
  return object;
}

P _recurringModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recurringModelGetId(RecurringModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recurringModelGetLinks(RecurringModel object) {
  return [];
}

void _recurringModelAttach(
    IsarCollection<dynamic> col, Id id, RecurringModel object) {
  object.id = id;
}

extension RecurringModelQueryWhereSort
    on QueryBuilder<RecurringModel, RecurringModel, QWhere> {
  QueryBuilder<RecurringModel, RecurringModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecurringModelQueryWhere
    on QueryBuilder<RecurringModel, RecurringModel, QWhereClause> {
  QueryBuilder<RecurringModel, RecurringModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RecurringModel, RecurringModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterWhereClause> idBetween(
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

extension RecurringModelQueryFilter
    on QueryBuilder<RecurringModel, RecurringModel, QFilterCondition> {
  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
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

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastLoggedDate',
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastLoggedDate',
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastLoggedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastLoggedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastLoggedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      lastLoggedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastLoggedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      recurringDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      recurringDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      recurringDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterFilterCondition>
      recurringDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RecurringModelQueryObject
    on QueryBuilder<RecurringModel, RecurringModel, QFilterCondition> {}

extension RecurringModelQueryLinks
    on QueryBuilder<RecurringModel, RecurringModel, QFilterCondition> {}

extension RecurringModelQuerySortBy
    on QueryBuilder<RecurringModel, RecurringModel, QSortBy> {
  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByLastLoggedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLoggedDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByLastLoggedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLoggedDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByRecurringDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringDay', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      sortByRecurringDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringDay', Sort.desc);
    });
  }
}

extension RecurringModelQuerySortThenBy
    on QueryBuilder<RecurringModel, RecurringModel, QSortThenBy> {
  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByLastLoggedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLoggedDate', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByLastLoggedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastLoggedDate', Sort.desc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByRecurringDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringDay', Sort.asc);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QAfterSortBy>
      thenByRecurringDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringDay', Sort.desc);
    });
  }
}

extension RecurringModelQueryWhereDistinct
    on QueryBuilder<RecurringModel, RecurringModel, QDistinct> {
  QueryBuilder<RecurringModel, RecurringModel, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QDistinct>
      distinctByLastLoggedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastLoggedDate');
    });
  }

  QueryBuilder<RecurringModel, RecurringModel, QDistinct>
      distinctByRecurringDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringDay');
    });
  }
}

extension RecurringModelQueryProperty
    on QueryBuilder<RecurringModel, RecurringModel, QQueryProperty> {
  QueryBuilder<RecurringModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecurringModel, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<RecurringModel, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<RecurringModel, DateTime?, QQueryOperations>
      lastLoggedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastLoggedDate');
    });
  }

  QueryBuilder<RecurringModel, int, QQueryOperations> recurringDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringDay');
    });
  }
}
