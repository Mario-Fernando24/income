class BlocFormItem<T> {
  final T value;
  final String? error;

  const BlocFormItem({
    required this.value,
    this.error,
  });

  BlocFormItem<T> copyWith({
    T? value,
    String? error,
  }) {
    return BlocFormItem<T>(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}