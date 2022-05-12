class ChipVO {
  dynamic? chipName;
  bool? isSelected;

  ChipVO({this.chipName, this.isSelected});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChipVO &&
          runtimeType == other.runtimeType &&
          chipName == other.chipName;

  @override
  int get hashCode => chipName.hashCode;
}