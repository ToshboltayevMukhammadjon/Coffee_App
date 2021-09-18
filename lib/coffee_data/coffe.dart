import 'dart:math';

final random = Random();
final coffees = List.generate(
  _names.length,
  (index) => Coffee(
    image: 'assets/${index + 1}.png',
    name: _names[index],
    price: _price[index],
  ),
);

class Coffee {
  final String name;
  final String image;
  final String price;

  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _names = [
  'Caramel Cold Drink',
  'Iced Coffee Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];

final _price = [
  '23 000',
  '17 000',
  '14 000',
  '25 000',
  '16 000',
  '35 000',
  '27 000',
  '20 000',
  '45 000',
  '22 000',
  '37 000',
];
