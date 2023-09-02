
extension PriceExtension on Object {
  String? toPrice() {
    if (this is double) {
      final doublePrice = this as double;
      final roundedPrice = doublePrice.toStringAsFixed(2);
      return roundedPrice.endsWith('.00') ? doublePrice.toInt().toString() : roundedPrice.toString();
    } else if (this is String) {
      final doublePrice = double.tryParse(this.toString());
      if (doublePrice != null) {
        final roundedPrice = doublePrice.toStringAsFixed(2);
        return roundedPrice.endsWith('.00') ? doublePrice.toInt().toString() : double.tryParse(roundedPrice).toString();
      }
    }

    return this.toString();
  }

}

extension PriceExt on double? {
  String? toPriceString() {
    final doublePrice = this as double;
    final roundedPrice = doublePrice.toStringAsFixed(2);
    return roundedPrice.endsWith('.00') ? doublePrice.toInt().toString() : roundedPrice.toString();
  }

}
