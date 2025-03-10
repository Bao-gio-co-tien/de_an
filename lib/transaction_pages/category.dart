
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String? icon;
  final String? type;

  Category({
    required this.id,
    required this.name,
    this.icon,
    this.type
  });

  factory Category.fromMap(String id, Map<String, dynamic> map) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      icon: map['icon'] ?? 'help_outline',
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'type': type,
    };
  }

  IconData getIcon() {
    final iconMap = {
      // Income icons
      'salary': Icons.work,
      'investment': Icons.trending_up,
      'gift': Icons.card_giftcard,
      'savings': Icons.savings,
      'business': Icons.business,
      'freelance': Icons.computer,
      'rental': Icons.house,

      // Expense icons
      'food': Icons.restaurant,
      'shopping': Icons.shopping_cart,
      'transport': Icons.directions_car,
      'entertainment': Icons.movie,
      'bills': Icons.receipt_long,
      'healthcare': Icons.local_hospital,
      'education': Icons.school,
      'travel': Icons.flight,
      'groceries': Icons.local_grocery_store,
      'clothing': Icons.checkroom,
      'fitness': Icons.fitness_center,
      'beauty': Icons.face,
      'electronics': Icons.devices,
      'pets': Icons.pets,
      'home': Icons.home,
      'insurance': Icons.security,
      'gifts': Icons.card_giftcard,
      'coffee': Icons.coffee,
      'sports': Icons.sports_soccer,
      'books': Icons.book,
      'hobbies': Icons.palette,

      'default': Icons.help_outline,
    };

    return iconMap[icon] ?? Icons.help_outline;
  }
}