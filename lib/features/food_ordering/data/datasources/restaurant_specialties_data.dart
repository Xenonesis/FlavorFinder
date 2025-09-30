import '../../domain/entities/food_item.dart';

class RestaurantSpecialtiesData {
  static Map<String, List<FoodItem>> getRestaurantMenus() {
    return {
      '1': _getTonysPizzaMenu(),
      '2': _getSliceParadiseMenu(),
      '3': _getDragonPalaceMenu(),
      '4': _getSakuraSushiMenu(),
      '5': _getBangkokStreetMenu(),
      '6': _getBurgerJunctionMenu(),
      '7': _getGrillMasterMenu(),
      '8': _getSpiceGardenMenu(),
      '9': _getMumbaiExpressMenu(),
      '10': _getCasaMexicanaMenu(),
      '11': _getTacoFiestaMenu(),
      '12': _getMediterraneanMenu(),
      '13': _getKebabCornerMenu(),
      '14': _getGreenBowlMenu(),
      '15': _getVeggieParadiseMenu(),
      '16': _getSweetDreamsMenu(),
      '17': _getCoffeeCentralMenu(),
      '18': _getLePetitBistroMenu(),
      '19': _getOceansCatchMenu(),
      '20': _getHometownDinerMenu(),
    };
  }

  static List<FoodItem> _getTonysPizzaMenu() {
    return [
      FoodItem(id: '1', name: 'Margherita Pizza', description: 'Fresh mozzarella, tomato sauce, basil', price: 16.99, imageUrl: '', category: 'Pizza', rating: 4.8, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: '2', name: 'Pepperoni Supreme', description: 'Premium pepperoni with extra cheese', price: 19.99, imageUrl: '', category: 'Pizza', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: '3', name: 'Meat Lovers Pizza', description: 'Pepperoni, sausage, bacon, ham, ground beef', price: 24.99, imageUrl: '', category: 'Pizza', rating: 4.9, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tp1', name: 'White Pizza', description: 'Ricotta, mozzarella, garlic, and herbs', price: 18.99, imageUrl: '', category: 'Pizza', rating: 4.6, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tp2', name: 'BBQ Chicken Pizza', description: 'Grilled chicken, BBQ sauce, red onions', price: 21.99, imageUrl: '', category: 'Pizza', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tp3', name: 'Caesar Salad', description: 'Romaine lettuce, parmesan, croutons, caesar dressing', price: 9.99, imageUrl: '', category: 'Salads', rating: 4.4, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tp4', name: 'Garlic Bread', description: 'Fresh baked bread with garlic butter and herbs', price: 6.99, imageUrl: '', category: 'Appetizers', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getDragonPalaceMenu() {
    return [
      FoodItem(id: '4', name: 'General Tso\'s Chicken', description: 'Crispy chicken in sweet and tangy sauce', price: 14.99, imageUrl: '', category: 'Main Course', rating: 4.6, isVegetarian: false, allergens: ['Soy', 'Gluten']),
      FoodItem(id: '5', name: 'Kung Pao Chicken', description: 'Diced chicken with peanuts and chili peppers', price: 13.99, imageUrl: '', category: 'Main Course', rating: 4.5, isVegetarian: false, allergens: ['Peanuts', 'Soy']),
      FoodItem(id: '6', name: 'Vegetable Lo Mein', description: 'Soft noodles with mixed vegetables', price: 11.99, imageUrl: '', category: 'Noodles', rating: 4.4, isVegetarian: true, allergens: ['Gluten', 'Soy']),
      FoodItem(id: 'dp1', name: 'Sweet and Sour Pork', description: 'Battered pork with pineapple and bell peppers', price: 15.99, imageUrl: '', category: 'Main Course', rating: 4.3, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'dp2', name: 'Beef and Broccoli', description: 'Tender beef with fresh broccoli in brown sauce', price: 16.99, imageUrl: '', category: 'Main Course', rating: 4.6, isVegetarian: false, allergens: ['Soy']),
      FoodItem(id: 'dp3', name: 'Fried Rice', description: 'Wok-fried rice with eggs and vegetables', price: 9.99, imageUrl: '', category: 'Rice', rating: 4.2, isVegetarian: true, allergens: ['Eggs', 'Soy']),
      FoodItem(id: 'dp4', name: 'Spring Rolls (4 pieces)', description: 'Crispy vegetable spring rolls with sweet chili sauce', price: 7.99, imageUrl: '', category: 'Appetizers', rating: 4.4, isVegetarian: true, allergens: ['Gluten']),
    ];
  }

  static List<FoodItem> _getSakuraSushiMenu() {
    return [
      FoodItem(id: '7', name: 'California Roll', description: 'Crab, avocado, and cucumber', price: 8.99, imageUrl: '', category: 'Sushi', rating: 4.7, isVegetarian: false, allergens: ['Shellfish']),
      FoodItem(id: '8', name: 'Salmon Nigiri (6 pieces)', description: 'Fresh salmon over seasoned rice', price: 12.99, imageUrl: '', category: 'Sushi', rating: 4.9, isVegetarian: false, allergens: ['Fish']),
      FoodItem(id: '9', name: 'Dragon Roll', description: 'Eel and cucumber with avocado on top', price: 15.99, imageUrl: '', category: 'Sushi', rating: 4.8, isVegetarian: false, allergens: ['Fish', 'Soy']),
      FoodItem(id: 'ss1', name: 'Tuna Sashimi (8 pieces)', description: 'Fresh tuna slices without rice', price: 16.99, imageUrl: '', category: 'Sashimi', rating: 4.9, isVegetarian: false, allergens: ['Fish']),
      FoodItem(id: 'ss2', name: 'Philadelphia Roll', description: 'Salmon, cream cheese, and cucumber', price: 10.99, imageUrl: '', category: 'Sushi', rating: 4.6, isVegetarian: false, allergens: ['Fish', 'Dairy']),
      FoodItem(id: 'ss3', name: 'Miso Soup', description: 'Traditional soybean paste soup with tofu', price: 3.99, imageUrl: '', category: 'Soups', rating: 4.5, isVegetarian: true, allergens: ['Soy']),
      FoodItem(id: 'ss4', name: 'Edamame', description: 'Steamed soybeans with sea salt', price: 5.99, imageUrl: '', category: 'Appetizers', rating: 4.3, isVegetarian: true, allergens: ['Soy']),
    ];
  }

  static List<FoodItem> _getBurgerJunctionMenu() {
    return [
      FoodItem(id: '10', name: 'Classic Cheeseburger', description: 'Beef patty with cheese and fixings', price: 12.99, imageUrl: '', category: 'Burgers', rating: 4.5, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: '11', name: 'BBQ Bacon Burger', description: 'Double patty with bacon and BBQ sauce', price: 16.99, imageUrl: '', category: 'Burgers', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: '12', name: 'Crispy Chicken Sandwich', description: 'Fried chicken with mayo and pickles', price: 13.99, imageUrl: '', category: 'Sandwiches', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Eggs']),
      FoodItem(id: 'bj1', name: 'Veggie Burger', description: 'Plant-based patty with avocado and sprouts', price: 11.99, imageUrl: '', category: 'Burgers', rating: 4.2, isVegetarian: true, allergens: ['Gluten']),
      FoodItem(id: 'bj2', name: 'Fish & Chips', description: 'Beer-battered cod with seasoned fries', price: 15.99, imageUrl: '', category: 'Main Course', rating: 4.4, isVegetarian: false, allergens: ['Fish', 'Gluten']),
      FoodItem(id: 'bj3', name: 'Loaded Fries', description: 'Fries topped with cheese, bacon, and green onions', price: 8.99, imageUrl: '', category: 'Sides', rating: 4.3, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'bj4', name: 'Chocolate Milkshake', description: 'Rich chocolate shake with whipped cream', price: 5.99, imageUrl: '', category: 'Beverages', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getSpiceGardenMenu() {
    return [
      FoodItem(id: '13', name: 'Butter Chicken', description: 'Tender chicken in creamy tomato curry', price: 15.99, imageUrl: '', category: 'Main Course', rating: 4.8, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: '14', name: 'Vegetable Biryani', description: 'Fragrant rice with mixed vegetables', price: 13.99, imageUrl: '', category: 'Rice', rating: 4.6, isVegetarian: true, allergens: []),
      FoodItem(id: '15', name: 'Chicken Tikka Masala', description: 'Grilled chicken in rich tomato curry', price: 16.99, imageUrl: '', category: 'Main Course', rating: 4.7, isVegetarian: false, allergens: ['Dairy', 'Gluten']),
      FoodItem(id: 'sg1', name: 'Lamb Vindaloo', description: 'Spicy lamb curry with potatoes', price: 18.99, imageUrl: '', category: 'Main Course', rating: 4.5, isVegetarian: false, allergens: []),
      FoodItem(id: 'sg2', name: 'Palak Paneer', description: 'Cottage cheese in creamy spinach curry', price: 14.99, imageUrl: '', category: 'Main Course', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
      FoodItem(id: 'sg3', name: 'Garlic Naan', description: 'Fresh baked bread with garlic and herbs', price: 3.99, imageUrl: '', category: 'Bread', rating: 4.7, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sg4', name: 'Samosas (3 pieces)', description: 'Crispy pastries filled with spiced potatoes', price: 6.99, imageUrl: '', category: 'Appetizers', rating: 4.4, isVegetarian: true, allergens: ['Gluten']),
    ];
  }

  static List<FoodItem> _getCasaMexicanaMenu() {
    return [
      FoodItem(id: '16', name: 'Chicken Quesadilla', description: 'Grilled chicken and cheese in tortilla', price: 11.99, imageUrl: '', category: 'Mexican', rating: 4.5, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: '17', name: 'Beef Burrito Bowl', description: 'Seasoned beef with rice and toppings', price: 13.99, imageUrl: '', category: 'Bowls', rating: 4.6, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: '18', name: 'Fish Tacos (3 pieces)', description: 'Grilled fish with cabbage slaw', price: 14.99, imageUrl: '', category: 'Tacos', rating: 4.7, isVegetarian: false, allergens: ['Fish', 'Gluten']),
      FoodItem(id: 'cm1', name: 'Chicken Enchiladas', description: 'Rolled tortillas with chicken and cheese sauce', price: 15.99, imageUrl: '', category: 'Main Course', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'cm2', name: 'Carnitas Tacos (3 pieces)', description: 'Slow-cooked pork with onions and cilantro', price: 12.99, imageUrl: '', category: 'Tacos', rating: 4.5, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'cm3', name: 'Guacamole & Chips', description: 'Fresh avocado dip with tortilla chips', price: 7.99, imageUrl: '', category: 'Appetizers', rating: 4.4, isVegetarian: true, allergens: []),
      FoodItem(id: 'cm4', name: 'Churros', description: 'Fried pastry sticks with cinnamon sugar', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.3, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getGreenBowlMenu() {
    return [
      FoodItem(id: '19', name: 'Quinoa Power Bowl', description: 'Quinoa with roasted vegetables and tahini', price: 12.99, imageUrl: '', category: 'Bowls', rating: 4.8, isVegetarian: true, allergens: ['Sesame']),
      FoodItem(id: '20', name: 'Grilled Salmon Salad', description: 'Fresh salmon over mixed greens', price: 16.99, imageUrl: '', category: 'Salads', rating: 4.7, isVegetarian: false, allergens: ['Fish']),
      FoodItem(id: '21', name: 'Acai Bowl', description: 'Acai blend with granola and berries', price: 9.99, imageUrl: '', category: 'Breakfast', rating: 4.6, isVegetarian: true, allergens: ['Nuts']),
      FoodItem(id: 'gb1', name: 'Buddha Bowl', description: 'Brown rice, tofu, and seasonal vegetables', price: 13.99, imageUrl: '', category: 'Bowls', rating: 4.5, isVegetarian: true, allergens: ['Soy']),
      FoodItem(id: 'gb2', name: 'Kale Caesar Salad', description: 'Massaged kale with vegan caesar dressing', price: 11.99, imageUrl: '', category: 'Salads', rating: 4.4, isVegetarian: true, allergens: []),
      FoodItem(id: 'gb3', name: 'Green Juice', description: 'Kale, spinach, apple, and ginger blend', price: 7.99, imageUrl: '', category: 'Beverages', rating: 4.3, isVegetarian: true, allergens: []),
    ];
  }

  static List<FoodItem> _getSweetDreamsMenu() {
    return [
      FoodItem(id: '22', name: 'Chocolate Lava Cake', description: 'Warm cake with molten chocolate center', price: 7.99, imageUrl: '', category: 'Desserts', rating: 4.9, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: '23', name: 'New York Cheesecake', description: 'Classic cheesecake with berry compote', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.8, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: '24', name: 'Tiramisu', description: 'Coffee-soaked ladyfingers with mascarpone', price: 8.99, imageUrl: '', category: 'Desserts', rating: 4.7, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'sd1', name: 'Apple Pie', description: 'Classic apple pie with vanilla ice cream', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.6, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'sd2', name: 'Chocolate Chip Cookies (6 pieces)', description: 'Fresh baked cookies with chocolate chips', price: 4.99, imageUrl: '', category: 'Desserts', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'sd3', name: 'Red Velvet Cupcake', description: 'Moist red velvet with cream cheese frosting', price: 3.99, imageUrl: '', category: 'Desserts', rating: 4.4, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
    ];
  }

  // Placeholder methods for other restaurants
  static List<FoodItem> _getSliceParadiseMenu() => [];
  static List<FoodItem> _getBangkokStreetMenu() => [];
  static List<FoodItem> _getGrillMasterMenu() => [];
  static List<FoodItem> _getMumbaiExpressMenu() => [];
  static List<FoodItem> _getTacoFiestaMenu() => [];
  static List<FoodItem> _getMediterraneanMenu() => [];
  static List<FoodItem> _getKebabCornerMenu() => [];
  static List<FoodItem> _getVeggieParadiseMenu() => [];
  static List<FoodItem> _getCoffeeCentralMenu() => [];
  static List<FoodItem> _getLePetitBistroMenu() => [];
  static List<FoodItem> _getOceansCatchMenu() => [];
  static List<FoodItem> _getHometownDinerMenu() => [];
}
