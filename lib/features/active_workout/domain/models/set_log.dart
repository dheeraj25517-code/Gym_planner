class SetLog {
  final int setNumber;
  final double weight;
  final int reps;
  final String type; // Enforces tracking styles: 'EXACT' or 'DROP'

  const SetLog({
    required this.setNumber,
    required this.weight,
    required this.reps,
    this.type = 'EXACT',
  });

  /// Converts the set instance properties into a serialized schema map string
  Map<String, dynamic> toMap() {
    return {
      'setNumber': setNumber,
      'weight': weight,
      'reps': reps,
      'type': type,
    };
  }

  /// Rebuilds an explicit SetLog object back out of a database storage map dictionary
  factory SetLog.fromMap(Map<String, dynamic> map) {
    return SetLog(
      setNumber: map['setNumber'] as int? ?? 1,
      weight: (map['weight'] as num? ?? 0.0).toDouble(),
      reps: map['reps'] as int? ?? 0,
      type: map['type'] as String? ?? 'EXACT',
    );
  }

  /// Instantly provisions a brand new copy of a working set row with modified variables
  SetLog copyWith({
    int? setNumber,
    double? weight,
    int? reps,
    String? type,
  }) {
    return SetLog(
      setNumber: setNumber ?? this.setNumber,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      type: type ?? this.type,
    );
  }
}