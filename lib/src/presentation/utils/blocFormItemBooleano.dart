class BlocFormItemBoleano {

  final bool value;
  final String? error;

  const BlocFormItemBoleano({
    this.value=false,
    this.error
  });

    BlocFormItemBoleano copyWith({
     bool? value,
     String? error,
  }){
     return BlocFormItemBoleano(
      value: value ?? this.value,
      error: error ?? this.error
     );
  }




}