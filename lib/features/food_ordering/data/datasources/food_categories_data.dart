import '../../domain/entities/food_item.dart';

class FoodCategoriesData {
  static List<FoodItem> getAppetizers() {
    return [
      FoodItem(
        id: 'app1',
        name: 'Buffalo Wings (8 pieces)',
        description: 'Crispy chicken wings tossed in spicy buffalo sauce with ranch dip',
        price: 11.99,
        imageUrl: 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
        category: 'Appetizers',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'app2',
        name: 'Mozzarella Sticks',
        description: 'Golden fried mozzarella cheese sticks with marinara sauce',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?w=400&h=300&fit=crop',
        category: 'Appetizers',
        rating: 4.4,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'app3',
        name: 'Loaded Nachos',
        description: 'Tortilla chips topped with cheese, jalapeños, sour cream, and guacamole',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=400&h=300&fit=crop',
        category: 'Appetizers',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'app4',
        name: 'Calamari Rings',
        description: 'Crispy fried squid rings served with spicy marinara sauce',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=400&h=300&fit=crop',
        category: 'Appetizers',
        rating: 4.3,
        isVegetarian: false,
        allergens: ['Seafood', 'Gluten'],
      ),
    ];
  }

  static List<FoodItem> getBeverages() {
    return [
      FoodItem(
        id: 'bev1',
        name: 'Fresh Orange Juice',
        description: 'Freshly squeezed orange juice, no added sugar',
        price: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400&h=300&fit=crop',
        category: 'Beverages',
        rating: 4.7,
        isVegetarian: true,
        allergens: [],
      ),
      FoodItem(
        id: 'bev2',
        name: 'Iced Coffee',
        description: 'Cold brew coffee served over ice with your choice of milk',
        price: 3.99,
        imageUrl: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&h=300&fit=crop',
        category: 'Beverages',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'bev3',
        name: 'Green Smoothie',
        description: 'Spinach, banana, mango, and coconut water blend',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=400&h=300&fit=crop',
        category: 'Beverages',
        rating: 4.6,
        isVegetarian: true,
        allergens: [],
      ),
      FoodItem(
        id: 'bev4',
        name: 'Craft Beer',
        description: 'Local IPA with citrus and pine notes',
        price: 5.99,
        imageUrl: 'https://images.unsplash.com/photo-1608270586620-248524c67de9?w=400&h=300&fit=crop',
        category: 'Beverages',
        rating: 4.4,
        isVegetarian: true,
        allergens: ['Gluten'],
      ),
    ];
  }

  static List<FoodItem> getSoups() {
    return [
      FoodItem(
        id: 'soup1',
        name: 'Tomato Basil Soup',
        description: 'Creamy tomato soup with fresh basil and a hint of garlic',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&h=300&fit=crop',
        category: 'Soups',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'soup2',
        name: 'Chicken Noodle Soup',
        description: 'Classic comfort soup with tender chicken and egg noodles',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&h=300&fit=crop',
        category: 'Soups',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Gluten', 'Eggs'],
      ),
      FoodItem(
        id: 'soup3',
        name: 'Miso Ramen',
        description: 'Rich miso broth with ramen noodles, pork, and green onions',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=300&fit=crop',
        category: 'Soups',
        rating: 4.8,
        isVegetarian: false,
        allergens: ['Gluten', 'Soy', 'Eggs'],
      ),
    ];
  }

  static List<FoodItem> getSnacks() {
    return [
      FoodItem(
        id: 'snack1',
        name: 'French Fries',
        description: 'Crispy golden fries seasoned with sea salt',
        price: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400&h=300&fit=crop',
        category: 'Snacks',
        rating: 4.3,
        isVegetarian: true,
        allergens: [],
      ),
      FoodItem(
        id: 'snack2',
        name: 'Onion Rings',
        description: 'Beer-battered onion rings served with ranch dressing',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1639024471283-03518883512d?w=400&h=300&fit=crop',
        category: 'Snacks',
        rating: 4.4,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'snack3',
        name: 'Pretzel Bites',
        description: 'Warm soft pretzel bites with cheese dipping sauce',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400&h=300&fit=crop',
        category: 'Snacks',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  static List<FoodItem> getBreakfast() {
    return [
      FoodItem(
        id: 'break1',
        name: 'Pancake Stack',
        description: 'Three fluffy pancakes with maple syrup and butter',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400&h=300&fit=crop',
        category: 'Breakfast',
        rating: 4.7,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: 'break2',
        name: 'Avocado Toast',
        description: 'Smashed avocado on sourdough with cherry tomatoes and feta',
        price: 11.99,
        imageUrl: 'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=400&h=300&fit=crop',
        category: 'Breakfast',
        rating: 4.6,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'break3',
        name: 'Breakfast Burrito',
        description: 'Scrambled eggs, bacon, cheese, and hash browns in flour tortilla',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=400&h=300&fit=crop',
        category: 'Breakfast',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
    ];
  }

  static Map<String, List<FoodItem>> getAllCategorizedItems() {
    return {
      'Appetizers': getAppetizers(),
      'Beverages': getBeverages(),
      'Soups': getSoups(),
      'Snacks': getSnacks(),
      'Breakfast': getBreakfast(),
    };
  }
}
