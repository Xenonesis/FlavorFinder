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

  static List<FoodItem> getBurgers() {
    return [
      FoodItem(
        id: 'burger1',
        name: 'Classic Cheeseburger',
        description: 'Beef patty with cheese, lettuce, tomato, and special sauce',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
        category: 'Burgers',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'burger2',
        name: 'Double Bacon Burger',
        description: 'Double beef patty with crispy bacon and cheddar cheese',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400&h=300&fit=crop',
        category: 'Burgers',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'burger3',
        name: 'Mushroom Swiss Burger',
        description: 'Beef patty with sautéed mushrooms and Swiss cheese',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=400&h=300&fit=crop',
        category: 'Burgers',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  static List<FoodItem> getPizzas() {
    return [
      FoodItem(
        id: 'pizza1',
        name: 'Margherita Pizza',
        description: 'Fresh mozzarella, tomato sauce, and basil',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'pizza2',
        name: 'Pepperoni Pizza',
        description: 'Classic pepperoni with mozzarella cheese',
        price: 18.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'pizza3',
        name: 'Supreme Pizza',
        description: 'Pepperoni, sausage, peppers, onions, and mushrooms',
        price: 22.99,
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.9,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  static List<FoodItem> getSalads() {
    return [
      FoodItem(
        id: 'salad1',
        name: 'Caesar Salad',
        description: 'Crisp romaine lettuce with parmesan and croutons',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=400&h=300&fit=crop',
        category: 'Salads',
        rating: 4.4,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'salad2',
        name: 'Greek Salad',
        description: 'Mixed greens with feta cheese, olives, and tomatoes',
        price: 11.99,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
        category: 'Salads',
        rating: 4.6,
        isVegetarian: true,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'salad3',
        name: 'Chicken Caesar Salad',
        description: 'Caesar salad topped with grilled chicken breast',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1551248429-40975aa4de74?w=400&h=300&fit=crop',
        category: 'Salads',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  static List<FoodItem> getPasta() {
    return [
      FoodItem(
        id: 'pasta1',
        name: 'Spaghetti Carbonara',
        description: 'Creamy pasta with bacon, eggs, and parmesan',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=400&h=300&fit=crop',
        category: 'Pasta',
        rating: 4.8,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: 'pasta2',
        name: 'Penne Arrabbiata',
        description: 'Spicy tomato sauce with garlic and red pepper flakes',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1563379091339-03246963d51a?w=400&h=300&fit=crop',
        category: 'Pasta',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Gluten'],
      ),
      FoodItem(
        id: 'pasta3',
        name: 'Fettuccine Alfredo',
        description: 'Rich and creamy white sauce with parmesan cheese',
        price: 15.99,
        imageUrl: 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=400&h=300&fit=crop',
        category: 'Pasta',
        rating: 4.6,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
    ];
  }

  static List<FoodItem> getSeafood() {
    return [
      FoodItem(
        id: 'seafood1',
        name: 'Grilled Salmon',
        description: 'Fresh Atlantic salmon with lemon and herbs',
        price: 22.99,
        imageUrl: 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400&h=300&fit=crop',
        category: 'Seafood',
        rating: 4.8,
        isVegetarian: false,
        allergens: ['Fish'],
      ),
      FoodItem(
        id: 'seafood2',
        name: 'Shrimp Scampi',
        description: 'Garlic butter shrimp over linguine pasta',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=400&h=300&fit=crop',
        category: 'Seafood',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Shellfish', 'Gluten', 'Dairy'],
      ),
      FoodItem(
        id: 'seafood3',
        name: 'Fish and Chips',
        description: 'Beer-battered cod with thick-cut fries',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1544944664-2c6c1f0c9c0c?w=400&h=300&fit=crop',
        category: 'Seafood',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Fish', 'Gluten'],
      ),
    ];
  }

  static List<FoodItem> getWings() {
    return [
      FoodItem(
        id: 'wings1',
        name: 'Buffalo Wings (10 pieces)',
        description: 'Spicy buffalo wings with celery and blue cheese',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=400&h=300&fit=crop',
        category: 'Wings',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: 'wings2',
        name: 'BBQ Wings (10 pieces)',
        description: 'Sweet and smoky BBQ glazed wings',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1562967916-eb82221dfb92?w=400&h=300&fit=crop',
        category: 'Wings',
        rating: 4.6,
        isVegetarian: false,
        allergens: [],
      ),
      FoodItem(
        id: 'wings3',
        name: 'Honey Garlic Wings (10 pieces)',
        description: 'Sweet and savory honey garlic glazed wings',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1608039755401-742074f0548d?w=400&h=300&fit=crop',
        category: 'Wings',
        rating: 4.8,
        isVegetarian: false,
        allergens: [],
      ),
    ];
  }

  static List<FoodItem> getDesserts() {
    return [
      FoodItem(
        id: 'dessert1',
        name: 'Chocolate Lava Cake',
        description: 'Warm chocolate cake with molten center and ice cream',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.9,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: 'dessert2',
        name: 'New York Cheesecake',
        description: 'Classic creamy cheesecake with berry compote',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: 'dessert3',
        name: 'Ice Cream Sundae',
        description: 'Three scoops with hot fudge, whipped cream, and cherry',
        price: 5.99,
        imageUrl: 'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.5,
        isVegetarian: true,
        allergens: ['Dairy'],
      ),
    ];
  }

  static List<FoodItem> getHealthy() {
    return [
      FoodItem(
        id: 'healthy1',
        name: 'Quinoa Power Bowl',
        description: 'Quinoa with roasted vegetables and tahini dressing',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
        category: 'Healthy',
        rating: 4.7,
        isVegetarian: true,
        allergens: ['Sesame'],
      ),
      FoodItem(
        id: 'healthy2',
        name: 'Acai Bowl',
        description: 'Acai berry blend with granola, fresh fruits, and honey',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1511690743698-d9d85f2fbf38?w=400&h=300&fit=crop',
        category: 'Healthy',
        rating: 4.6,
        isVegetarian: true,
        allergens: ['Nuts'],
      ),
      FoodItem(
        id: 'healthy3',
        name: 'Grilled Chicken Salad',
        description: 'Mixed greens with grilled chicken and balsamic vinaigrette',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
        category: 'Healthy',
        rating: 4.5,
        isVegetarian: false,
        allergens: [],
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
      'Burgers': getBurgers(),
      'Pizza': getPizzas(),
      'Salads': getSalads(),
      'Pasta': getPasta(),
      'Seafood': getSeafood(),
      'Wings': getWings(),
      'Desserts': getDesserts(),
      'Healthy': getHealthy(),
    };
  }
}
