// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_report_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlyReportCollection on Isar {
  IsarCollection<MonthlyReport> get monthlyReports => this.collection();
}

const MonthlyReportSchema = CollectionSchema(
  name: r'MonthlyReport',
  id: -5910048480329234032,
  properties: {
    r'categoryJson': PropertySchema(
      id: 0,
      name: r'categoryJson',
      type: IsarType.string,
    ),
    r'monthYear': PropertySchema(
      id: 1,
      name: r'monthYear',
      type: IsarType.string,
    ),
    r'totalBudget': PropertySchema(
      id: 2,
      name: r'totalBudget',
      type: IsarType.double,
    ),
    r'totalExpense': PropertySchema(
      id: 3,
      name: r'totalExpense',
      type: IsarType.double,
    )
  },
  estimateSize: _monthlyReportEstimateSize,
  serialize: _monthlyReportSerialize,
  deserialize: _monthlyReportDeserialize,
  deserializeProp: _monthlyReportDeserializeProp,
  idName: r'id',
  indexes: {
    r'monthYear': IndexSchema(
      id: -8729709491572084802,
      name: r'monthYear',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'monthYear',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _monthlyReportGetId,
  getLinks: _monthlyReportGetLinks,
  attach: _monthlyReportAttach,
  version: '3.1.0+1',
);

int _monthlyReportEstimateSize(
  MonthlyReport object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoryJson.length * 3;
  bytesCount += 3 + object.monthYear.length * 3;
  return bytesCount;
}

void _monthlyReportSerialize(
  MonthlyReport object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryJson);
  writer.writeString(offsets[1], object.monthYear);
  writer.writeDouble(offsets[2], object.totalBudget);
  writer.writeDouble(offsets[3], object.totalExpense);
}

MonthlyReport _monthlyReportDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlyReport();
  object.categoryJson = reader.readString(offsets[0]);
  object.id = id;
  object.monthYear = reader.readString(offsets[1]);
  object.totalBudget = reader.readDouble(offsets[2]);
  object.totalExpense = reader.readDouble(offsets[3]);
  return object;
}

P _monthlyReportDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monthlyReportGetId(MonthlyReport object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlyReportGetLinks(MonthlyReport object) {
  return [];
}

void _monthlyReportAttach(
    IsarCollection<dynamic> col, Id id, MonthlyReport object) {
  object.id = id;
}

extension MonthlyReportByIndex on IsarCollection<MonthlyReport> {
  Future<MonthlyReport?> getByMonthYear(String monthYear) {
    return getByIndex(r'monthYear', [monthYear]);
  }

  MonthlyReport? getByMonthYearSync(String monthYear) {
    return getByIndexSync(r'monthYear', [monthYear]);
  }

  Future<bool> deleteByMonthYear(String monthYear) {
    return deleteByIndex(r'monthYear', [monthYear]);
  }

  bool deleteByMonthYearSync(String monthYear) {
    return deleteByIndexSync(r'monthYear', [monthYear]);
  }

  Future<List<MonthlyReport?>> getAllByMonthYear(List<String> monthYearValues) {
    final values = monthYearValues.map((e) => [e]).toList();
    return getAllByIndex(r'monthYear', values);
  }

  List<MonthlyReport?> getAllByMonthYearSync(List<String> monthYearValues) {
    final values = monthYearValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'monthYear', values);
  }

  Future<int> deleteAllByMonthYear(List<String> monthYearValues) {
    final values = monthYearValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'monthYear', values);
  }

  int deleteAllByMonthYearSync(List<String> monthYearValues) {
    final values = monthYearValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'monthYear', values);
  }

  Future<Id> putByMonthYear(MonthlyReport object) {
    return putByIndex(r'monthYear', object);
  }

  Id putByMonthYearSync(MonthlyReport object, {bool saveLinks = true}) {
    return putByIndexSync(r'monthYear', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMonthYear(List<MonthlyReport> objects) {
    return putAllByIndex(r'monthYear', objects);
  }

  List<Id> putAllByMonthYearSync(List<MonthlyReport> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'monthYear', objects, saveLinks: saveLinks);
  }
}

extension MonthlyReportQueryWhereSort
    on QueryBuilder<MonthlyReport, MonthlyReport, QWhere> {
  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonthlyReportQueryWhere
    on QueryBuilder<MonthlyReport, MonthlyReport, QWhereClause> {
  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause> idBetween(
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

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause>
      monthYearEqualTo(String monthYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monthYear',
        value: [monthYear],
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterWhereClause>
      monthYearNotEqualTo(String monthYear) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthYear',
              lower: [],
              upper: [monthYear],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthYear',
              lower: [monthYear],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthYear',
              lower: [monthYear],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthYear',
              lower: [],
              upper: [monthYear],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MonthlyReportQueryFilter
    on QueryBuilder<MonthlyReport, MonthlyReport, QFilterCondition> {
  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      categoryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
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

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monthYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monthYear',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthYear',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      monthYearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monthYear',
        value: '',
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalBudgetEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalBudgetGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalBudgetLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalBudget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalBudgetBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalBudget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalExpenseEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalExpense',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalExpenseGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalExpense',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalExpenseLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalExpense',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterFilterCondition>
      totalExpenseBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalExpense',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension MonthlyReportQueryObject
    on QueryBuilder<MonthlyReport, MonthlyReport, QFilterCondition> {}

extension MonthlyReportQueryLinks
    on QueryBuilder<MonthlyReport, MonthlyReport, QFilterCondition> {}

extension MonthlyReportQuerySortBy
    on QueryBuilder<MonthlyReport, MonthlyReport, QSortBy> {
  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByCategoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryJson', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByCategoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryJson', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> sortByMonthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthYear', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByMonthYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthYear', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> sortByTotalBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBudget', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByTotalBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBudget', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByTotalExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpense', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      sortByTotalExpenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpense', Sort.desc);
    });
  }
}

extension MonthlyReportQuerySortThenBy
    on QueryBuilder<MonthlyReport, MonthlyReport, QSortThenBy> {
  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByCategoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryJson', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByCategoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryJson', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> thenByMonthYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthYear', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByMonthYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthYear', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy> thenByTotalBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBudget', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByTotalBudgetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalBudget', Sort.desc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByTotalExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpense', Sort.asc);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QAfterSortBy>
      thenByTotalExpenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalExpense', Sort.desc);
    });
  }
}

extension MonthlyReportQueryWhereDistinct
    on QueryBuilder<MonthlyReport, MonthlyReport, QDistinct> {
  QueryBuilder<MonthlyReport, MonthlyReport, QDistinct> distinctByCategoryJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QDistinct> distinctByMonthYear(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthYear', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QDistinct>
      distinctByTotalBudget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalBudget');
    });
  }

  QueryBuilder<MonthlyReport, MonthlyReport, QDistinct>
      distinctByTotalExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalExpense');
    });
  }
}

extension MonthlyReportQueryProperty
    on QueryBuilder<MonthlyReport, MonthlyReport, QQueryProperty> {
  QueryBuilder<MonthlyReport, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlyReport, String, QQueryOperations> categoryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryJson');
    });
  }

  QueryBuilder<MonthlyReport, String, QQueryOperations> monthYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthYear');
    });
  }

  QueryBuilder<MonthlyReport, double, QQueryOperations> totalBudgetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalBudget');
    });
  }

  QueryBuilder<MonthlyReport, double, QQueryOperations> totalExpenseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalExpense');
    });
  }
}
