class BlocFormItemBoleano {

  final bool value;

  const BlocFormItemBoleano({
    this.value=false,
  });

    BlocFormItemBoleano copyWith({
     bool? value,
     String? error,
  }){
     return BlocFormItemBoleano(
      value: value ?? this.value,
     );
  }




}