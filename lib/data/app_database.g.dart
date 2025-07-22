// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkersTable extends Workers with TableInfo<$WorkersTable, Worker> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobTitleMeta = const VerificationMeta(
    'jobTitle',
  );
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
    'job_title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hrCodeMeta = const VerificationMeta('hrCode');
  @override
  late final GeneratedColumn<String> hrCode = GeneratedColumn<String>(
    'hr_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    jobTitle,
    department,
    hrCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Worker> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('job_title')) {
      context.handle(
        _jobTitleMeta,
        jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_jobTitleMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    } else if (isInserting) {
      context.missing(_departmentMeta);
    }
    if (data.containsKey('hr_code')) {
      context.handle(
        _hrCodeMeta,
        hrCode.isAcceptableOrUnknown(data['hr_code']!, _hrCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_hrCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Worker map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Worker(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      jobTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_title'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      hrCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hr_code'],
      )!,
    );
  }

  @override
  $WorkersTable createAlias(String alias) {
    return $WorkersTable(attachedDatabase, alias);
  }
}

class Worker extends DataClass implements Insertable<Worker> {
  final int id;
  final String name;
  final String jobTitle;
  final String department;
  final String hrCode;
  const Worker({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.department,
    required this.hrCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['job_title'] = Variable<String>(jobTitle);
    map['department'] = Variable<String>(department);
    map['hr_code'] = Variable<String>(hrCode);
    return map;
  }

  WorkersCompanion toCompanion(bool nullToAbsent) {
    return WorkersCompanion(
      id: Value(id),
      name: Value(name),
      jobTitle: Value(jobTitle),
      department: Value(department),
      hrCode: Value(hrCode),
    );
  }

  factory Worker.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Worker(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      jobTitle: serializer.fromJson<String>(json['jobTitle']),
      department: serializer.fromJson<String>(json['department']),
      hrCode: serializer.fromJson<String>(json['hrCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'jobTitle': serializer.toJson<String>(jobTitle),
      'department': serializer.toJson<String>(department),
      'hrCode': serializer.toJson<String>(hrCode),
    };
  }

  Worker copyWith({
    int? id,
    String? name,
    String? jobTitle,
    String? department,
    String? hrCode,
  }) => Worker(
    id: id ?? this.id,
    name: name ?? this.name,
    jobTitle: jobTitle ?? this.jobTitle,
    department: department ?? this.department,
    hrCode: hrCode ?? this.hrCode,
  );
  Worker copyWithCompanion(WorkersCompanion data) {
    return Worker(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      department: data.department.present
          ? data.department.value
          : this.department,
      hrCode: data.hrCode.present ? data.hrCode.value : this.hrCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Worker(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('department: $department, ')
          ..write('hrCode: $hrCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, jobTitle, department, hrCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Worker &&
          other.id == this.id &&
          other.name == this.name &&
          other.jobTitle == this.jobTitle &&
          other.department == this.department &&
          other.hrCode == this.hrCode);
}

class WorkersCompanion extends UpdateCompanion<Worker> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> jobTitle;
  final Value<String> department;
  final Value<String> hrCode;
  const WorkersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.department = const Value.absent(),
    this.hrCode = const Value.absent(),
  });
  WorkersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String jobTitle,
    required String department,
    required String hrCode,
  }) : name = Value(name),
       jobTitle = Value(jobTitle),
       department = Value(department),
       hrCode = Value(hrCode);
  static Insertable<Worker> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? jobTitle,
    Expression<String>? department,
    Expression<String>? hrCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (jobTitle != null) 'job_title': jobTitle,
      if (department != null) 'department': department,
      if (hrCode != null) 'hr_code': hrCode,
    });
  }

  WorkersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? jobTitle,
    Value<String>? department,
    Value<String>? hrCode,
  }) {
    return WorkersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      department: department ?? this.department,
      hrCode: hrCode ?? this.hrCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (hrCode.present) {
      map['hr_code'] = Variable<String>(hrCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('department: $department, ')
          ..write('hrCode: $hrCode')
          ..write(')'))
        .toString();
  }
}

class $ToolsTable extends Tools with TableInfo<$ToolsTable, Tool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, unit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tools';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tool(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $ToolsTable createAlias(String alias) {
    return $ToolsTable(attachedDatabase, alias);
  }
}

class Tool extends DataClass implements Insertable<Tool> {
  final int id;
  final String name;
  final String unit;
  const Tool({required this.id, required this.name, required this.unit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  ToolsCompanion toCompanion(bool nullToAbsent) {
    return ToolsCompanion(id: Value(id), name: Value(name), unit: Value(unit));
  }

  factory Tool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tool(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(unit),
    };
  }

  Tool copyWith({int? id, String? name, String? unit}) =>
      Tool(id: id ?? this.id, name: name ?? this.name, unit: unit ?? this.unit);
  Tool copyWithCompanion(ToolsCompanion data) {
    return Tool(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tool(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tool &&
          other.id == this.id &&
          other.name == this.name &&
          other.unit == this.unit);
}

class ToolsCompanion extends UpdateCompanion<Tool> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> unit;
  const ToolsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
  });
  ToolsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String unit,
  }) : name = Value(name),
       unit = Value(unit);
  static Insertable<Tool> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
    });
  }

  ToolsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? unit,
  }) {
    return ToolsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToolsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _workerIdMeta = const VerificationMeta(
    'workerId',
  );
  @override
  late final GeneratedColumn<int> workerId = GeneratedColumn<int>(
    'worker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workers (id)',
    ),
  );
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
    'tool_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tools (id)',
    ),
  );
  static const VerificationMeta _issueQtyMeta = const VerificationMeta(
    'issueQty',
  );
  @override
  late final GeneratedColumn<int> issueQty = GeneratedColumn<int>(
    'issue_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _returnQtyMeta = const VerificationMeta(
    'returnQty',
  );
  @override
  late final GeneratedColumn<int> returnQty = GeneratedColumn<int>(
    'return_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    workerId,
    toolId,
    issueQty,
    returnQty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('worker_id')) {
      context.handle(
        _workerIdMeta,
        workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('tool_id')) {
      context.handle(
        _toolIdMeta,
        toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toolIdMeta);
    }
    if (data.containsKey('issue_qty')) {
      context.handle(
        _issueQtyMeta,
        issueQty.isAcceptableOrUnknown(data['issue_qty']!, _issueQtyMeta),
      );
    }
    if (data.containsKey('return_qty')) {
      context.handle(
        _returnQtyMeta,
        returnQty.isAcceptableOrUnknown(data['return_qty']!, _returnQtyMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      workerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}worker_id'],
      )!,
      toolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tool_id'],
      )!,
      issueQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}issue_qty'],
      )!,
      returnQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}return_qty'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final DateTime date;
  final int workerId;
  final int toolId;
  final int issueQty;
  final int returnQty;
  const Transaction({
    required this.id,
    required this.date,
    required this.workerId,
    required this.toolId,
    required this.issueQty,
    required this.returnQty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['worker_id'] = Variable<int>(workerId);
    map['tool_id'] = Variable<int>(toolId);
    map['issue_qty'] = Variable<int>(issueQty);
    map['return_qty'] = Variable<int>(returnQty);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      date: Value(date),
      workerId: Value(workerId),
      toolId: Value(toolId),
      issueQty: Value(issueQty),
      returnQty: Value(returnQty),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      workerId: serializer.fromJson<int>(json['workerId']),
      toolId: serializer.fromJson<int>(json['toolId']),
      issueQty: serializer.fromJson<int>(json['issueQty']),
      returnQty: serializer.fromJson<int>(json['returnQty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'workerId': serializer.toJson<int>(workerId),
      'toolId': serializer.toJson<int>(toolId),
      'issueQty': serializer.toJson<int>(issueQty),
      'returnQty': serializer.toJson<int>(returnQty),
    };
  }

  Transaction copyWith({
    String? id,
    DateTime? date,
    int? workerId,
    int? toolId,
    int? issueQty,
    int? returnQty,
  }) => Transaction(
    id: id ?? this.id,
    date: date ?? this.date,
    workerId: workerId ?? this.workerId,
    toolId: toolId ?? this.toolId,
    issueQty: issueQty ?? this.issueQty,
    returnQty: returnQty ?? this.returnQty,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      toolId: data.toolId.present ? data.toolId.value : this.toolId,
      issueQty: data.issueQty.present ? data.issueQty.value : this.issueQty,
      returnQty: data.returnQty.present ? data.returnQty.value : this.returnQty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('workerId: $workerId, ')
          ..write('toolId: $toolId, ')
          ..write('issueQty: $issueQty, ')
          ..write('returnQty: $returnQty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, workerId, toolId, issueQty, returnQty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.date == this.date &&
          other.workerId == this.workerId &&
          other.toolId == this.toolId &&
          other.issueQty == this.issueQty &&
          other.returnQty == this.returnQty);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> workerId;
  final Value<int> toolId;
  final Value<int> issueQty;
  final Value<int> returnQty;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.workerId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.issueQty = const Value.absent(),
    this.returnQty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    this.date = const Value.absent(),
    required int workerId,
    required int toolId,
    this.issueQty = const Value.absent(),
    this.returnQty = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workerId = Value(workerId),
       toolId = Value(toolId);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? workerId,
    Expression<int>? toolId,
    Expression<int>? issueQty,
    Expression<int>? returnQty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (workerId != null) 'worker_id': workerId,
      if (toolId != null) 'tool_id': toolId,
      if (issueQty != null) 'issue_qty': issueQty,
      if (returnQty != null) 'return_qty': returnQty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? workerId,
    Value<int>? toolId,
    Value<int>? issueQty,
    Value<int>? returnQty,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      workerId: workerId ?? this.workerId,
      toolId: toolId ?? this.toolId,
      issueQty: issueQty ?? this.issueQty,
      returnQty: returnQty ?? this.returnQty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<int>(workerId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (issueQty.present) {
      map['issue_qty'] = Variable<int>(issueQty.value);
    }
    if (returnQty.present) {
      map['return_qty'] = Variable<int>(returnQty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('workerId: $workerId, ')
          ..write('toolId: $toolId, ')
          ..write('issueQty: $issueQty, ')
          ..write('returnQty: $returnQty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkersTable workers = $WorkersTable(this);
  late final $ToolsTable tools = $ToolsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    workers,
    tools,
    transactions,
  ];
}

typedef $$WorkersTableCreateCompanionBuilder =
    WorkersCompanion Function({
      Value<int> id,
      required String name,
      required String jobTitle,
      required String department,
      required String hrCode,
    });
typedef $$WorkersTableUpdateCompanionBuilder =
    WorkersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> jobTitle,
      Value<String> department,
      Value<String> hrCode,
    });

final class $$WorkersTableReferences
    extends BaseReferences<_$AppDatabase, $WorkersTable, Worker> {
  $$WorkersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(db.workers.id, db.transactions.workerId),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.workerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkersTableFilterComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hrCode => $composableBuilder(
    column: $table.hrCode,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.workerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkersTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hrCode => $composableBuilder(
    column: $table.hrCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkersTable> {
  $$WorkersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hrCode =>
      $composableBuilder(column: $table.hrCode, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.workerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkersTable,
          Worker,
          $$WorkersTableFilterComposer,
          $$WorkersTableOrderingComposer,
          $$WorkersTableAnnotationComposer,
          $$WorkersTableCreateCompanionBuilder,
          $$WorkersTableUpdateCompanionBuilder,
          (Worker, $$WorkersTableReferences),
          Worker,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$WorkersTableTableManager(_$AppDatabase db, $WorkersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> jobTitle = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String> hrCode = const Value.absent(),
              }) => WorkersCompanion(
                id: id,
                name: name,
                jobTitle: jobTitle,
                department: department,
                hrCode: hrCode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String jobTitle,
                required String department,
                required String hrCode,
              }) => WorkersCompanion.insert(
                id: id,
                name: name,
                jobTitle: jobTitle,
                department: department,
                hrCode: hrCode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      Worker,
                      $WorkersTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$WorkersTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$WorkersTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.workerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WorkersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkersTable,
      Worker,
      $$WorkersTableFilterComposer,
      $$WorkersTableOrderingComposer,
      $$WorkersTableAnnotationComposer,
      $$WorkersTableCreateCompanionBuilder,
      $$WorkersTableUpdateCompanionBuilder,
      (Worker, $$WorkersTableReferences),
      Worker,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$ToolsTableCreateCompanionBuilder =
    ToolsCompanion Function({
      Value<int> id,
      required String name,
      required String unit,
    });
typedef $$ToolsTableUpdateCompanionBuilder =
    ToolsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> unit,
    });

final class $$ToolsTableReferences
    extends BaseReferences<_$AppDatabase, $ToolsTable, Tool> {
  $$ToolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(db.tools.id, db.transactions.toolId),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.toolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ToolsTableFilterComposer extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToolsTableOrderingComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ToolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ToolsTable,
          Tool,
          $$ToolsTableFilterComposer,
          $$ToolsTableOrderingComposer,
          $$ToolsTableAnnotationComposer,
          $$ToolsTableCreateCompanionBuilder,
          $$ToolsTableUpdateCompanionBuilder,
          (Tool, $$ToolsTableReferences),
          Tool,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$ToolsTableTableManager(_$AppDatabase db, $ToolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> unit = const Value.absent(),
              }) => ToolsCompanion(id: id, name: name, unit: unit),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String unit,
              }) => ToolsCompanion.insert(id: id, name: name, unit: unit),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ToolsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<Tool, $ToolsTable, Transaction>(
                      currentTable: table,
                      referencedTable: $$ToolsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ToolsTableReferences(
                        db,
                        table,
                        p0,
                      ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.toolId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ToolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ToolsTable,
      Tool,
      $$ToolsTableFilterComposer,
      $$ToolsTableOrderingComposer,
      $$ToolsTableAnnotationComposer,
      $$ToolsTableCreateCompanionBuilder,
      $$ToolsTableUpdateCompanionBuilder,
      (Tool, $$ToolsTableReferences),
      Tool,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      Value<DateTime> date,
      required int workerId,
      required int toolId,
      Value<int> issueQty,
      Value<int> returnQty,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> workerId,
      Value<int> toolId,
      Value<int> issueQty,
      Value<int> returnQty,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkersTable _workerIdTable(_$AppDatabase db) =>
      db.workers.createAlias(
        $_aliasNameGenerator(db.transactions.workerId, db.workers.id),
      );

  $$WorkersTableProcessedTableManager get workerId {
    final $_column = $_itemColumn<int>('worker_id')!;

    final manager = $$WorkersTableTableManager(
      $_db,
      $_db.workers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ToolsTable _toolIdTable(_$AppDatabase db) => db.tools.createAlias(
    $_aliasNameGenerator(db.transactions.toolId, db.tools.id),
  );

  $$ToolsTableProcessedTableManager get toolId {
    final $_column = $_itemColumn<int>('tool_id')!;

    final manager = $$ToolsTableTableManager(
      $_db,
      $_db.tools,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get issueQty => $composableBuilder(
    column: $table.issueQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkersTableFilterComposer get workerId {
    final $$WorkersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableFilterComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableFilterComposer get toolId {
    final $$ToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableFilterComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get issueQty => $composableBuilder(
    column: $table.issueQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get returnQty => $composableBuilder(
    column: $table.returnQty,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkersTableOrderingComposer get workerId {
    final $$WorkersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableOrderingComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableOrderingComposer get toolId {
    final $$ToolsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableOrderingComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get issueQty =>
      $composableBuilder(column: $table.issueQty, builder: (column) => column);

  GeneratedColumn<int> get returnQty =>
      $composableBuilder(column: $table.returnQty, builder: (column) => column);

  $$WorkersTableAnnotationComposer get workerId {
    final $$WorkersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.workers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkersTableAnnotationComposer(
            $db: $db,
            $table: $db.workers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableAnnotationComposer get toolId {
    final $$ToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool workerId, bool toolId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> workerId = const Value.absent(),
                Value<int> toolId = const Value.absent(),
                Value<int> issueQty = const Value.absent(),
                Value<int> returnQty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                date: date,
                workerId: workerId,
                toolId: toolId,
                issueQty: issueQty,
                returnQty: returnQty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> date = const Value.absent(),
                required int workerId,
                required int toolId,
                Value<int> issueQty = const Value.absent(),
                Value<int> returnQty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                date: date,
                workerId: workerId,
                toolId: toolId,
                issueQty: issueQty,
                returnQty: returnQty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workerId = false, toolId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (workerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workerId,
                                referencedTable: $$TransactionsTableReferences
                                    ._workerIdTable(db),
                                referencedColumn: $$TransactionsTableReferences
                                    ._workerIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (toolId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.toolId,
                                referencedTable: $$TransactionsTableReferences
                                    ._toolIdTable(db),
                                referencedColumn: $$TransactionsTableReferences
                                    ._toolIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool workerId, bool toolId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkersTableTableManager get workers =>
      $$WorkersTableTableManager(_db, _db.workers);
  $$ToolsTableTableManager get tools =>
      $$ToolsTableTableManager(_db, _db.tools);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
