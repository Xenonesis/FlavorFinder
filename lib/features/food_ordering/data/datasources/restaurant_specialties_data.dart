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
      '21': _getSeoulKitchenMenu(),
      '22': _getPhoSaigonMenu(),
      '23': _getElMariachiMenu(),
      '24': _getPizzeriaNapoliMenu(),
      '25': _getWingStopMenu(),
      '26': _getMorningGloryMenu(),
      '27': _getPancakeParadiseMenu(),
      '28': _getChickenDelightMenu(),
      '29': _getSandwichCentralMenu(),
      '30': _getNoodleHouseMenu(),
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

  // Implemented restaurant menus
  static List<FoodItem> _getSliceParadiseMenu() {
    return [
      FoodItem(id: 'sp1', name: 'Supreme Pizza', description: 'Pepperoni, sausage, peppers, onions, and mushrooms', price: 22.99, imageUrl: '', category: 'Pizza', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sp2', name: 'Hawaiian Pizza', description: 'Ham, pineapple, and extra cheese', price: 18.99, imageUrl: '', category: 'Pizza', rating: 4.4, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sp3', name: 'Veggie Delight Pizza', description: 'Bell peppers, mushrooms, olives, and fresh tomatoes', price: 17.99, imageUrl: '', category: 'Pizza', rating: 4.3, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sp4', name: 'Buffalo Chicken Pizza', description: 'Spicy buffalo chicken with ranch drizzle', price: 20.99, imageUrl: '', category: 'Pizza', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sp5', name: 'Garlic Knots (6 pieces)', description: 'Soft bread knots with garlic butter and parmesan', price: 7.99, imageUrl: '', category: 'Appetizers', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getBangkokStreetMenu() {
    return [
      FoodItem(id: 'bs1', name: 'Pad Thai', description: 'Stir-fried rice noodles with shrimp and peanuts', price: 13.99, imageUrl: '', category: 'Thai', rating: 4.8, isVegetarian: false, allergens: ['Shellfish', 'Peanuts', 'Eggs']),
      FoodItem(id: 'bs2', name: 'Green Curry Chicken', description: 'Spicy green curry with chicken and vegetables', price: 15.99, imageUrl: '', category: 'Thai', rating: 4.7, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'bs3', name: 'Thai Basil Beef', description: 'Stir-fried beef with holy basil and chili', price: 16.99, imageUrl: '', category: 'Thai', rating: 4.6, isVegetarian: false, allergens: ['Soy']),
      FoodItem(id: 'bs4', name: 'Som Tam (Papaya Salad)', description: 'Spicy green papaya salad with lime dressing', price: 9.99, imageUrl: '', category: 'Salads', rating: 4.5, isVegetarian: true, allergens: ['Peanuts']),
      FoodItem(id: 'bs5', name: 'Mango Sticky Rice', description: 'Sweet sticky rice with fresh mango slices', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.4, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getGrillMasterMenu() {
    return [
      FoodItem(id: 'gm1', name: 'BBQ Ribs (Half Rack)', description: 'Slow-smoked pork ribs with signature BBQ sauce', price: 18.99, imageUrl: '', category: 'BBQ', rating: 4.8, isVegetarian: false, allergens: []),
      FoodItem(id: 'gm2', name: 'Pulled Pork Sandwich', description: 'Tender pulled pork with coleslaw on brioche bun', price: 12.99, imageUrl: '', category: 'Sandwiches', rating: 4.6, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'gm3', name: 'Smoked Brisket Platter', description: 'Sliced brisket with two sides and cornbread', price: 22.99, imageUrl: '', category: 'BBQ', rating: 4.9, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'gm4', name: 'Grilled Chicken Wings (10 pieces)', description: 'Smoky grilled wings with dry rub seasoning', price: 13.99, imageUrl: '', category: 'Wings', rating: 4.5, isVegetarian: false, allergens: []),
      FoodItem(id: 'gm5', name: 'Mac and Cheese', description: 'Creamy three-cheese macaroni baked to perfection', price: 7.99, imageUrl: '', category: 'Sides', rating: 4.4, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getMumbaiExpressMenu() {
    return [
      FoodItem(id: 'me1', name: 'Chicken Biryani', description: 'Fragrant basmati rice with spiced chicken', price: 16.99, imageUrl: '', category: 'Rice', rating: 4.8, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'me2', name: 'Paneer Makhani', description: 'Cottage cheese in rich tomato cream sauce', price: 14.99, imageUrl: '', category: 'Main Course', rating: 4.7, isVegetarian: true, allergens: ['Dairy']),
      FoodItem(id: 'me3', name: 'Fish Curry', description: 'South Indian style fish curry with coconut', price: 17.99, imageUrl: '', category: 'Main Course', rating: 4.6, isVegetarian: false, allergens: ['Fish']),
      FoodItem(id: 'me4', name: 'Tandoori Chicken', description: 'Clay oven roasted chicken with spices', price: 15.99, imageUrl: '', category: 'Tandoori', rating: 4.7, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'me5', name: 'Dal Tadka', description: 'Yellow lentils tempered with spices', price: 11.99, imageUrl: '', category: 'Vegetarian', rating: 4.5, isVegetarian: true, allergens: []),
    ];
  }

  static List<FoodItem> _getTacoFiestaMenu() {
    return [
      FoodItem(id: 'tf1', name: 'Carne Asada Tacos (3 pieces)', description: 'Grilled steak tacos with onions and cilantro', price: 13.99, imageUrl: '', category: 'Tacos', rating: 4.7, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'tf2', name: 'Chicken Tinga Burrito', description: 'Shredded chicken burrito with rice and beans', price: 11.99, imageUrl: '', category: 'Burritos', rating: 4.5, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tf3', name: 'Veggie Quesadilla', description: 'Cheese quesadilla with peppers and onions', price: 9.99, imageUrl: '', category: 'Quesadillas', rating: 4.3, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'tf4', name: 'Elote (Mexican Street Corn)', description: 'Grilled corn with mayo, cheese, and chili powder', price: 5.99, imageUrl: '', category: 'Sides', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
      FoodItem(id: 'tf5', name: 'Tres Leches Cake', description: 'Sponge cake soaked in three types of milk', price: 7.99, imageUrl: '', category: 'Desserts', rating: 4.8, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
    ];
  }

  static List<FoodItem> _getMediterraneanMenu() {
    return [
      FoodItem(id: 'md1', name: 'Lamb Gyros', description: 'Slow-cooked lamb with tzatziki and pita bread', price: 14.99, imageUrl: '', category: 'Mediterranean', rating: 4.8, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'md2', name: 'Greek Salad', description: 'Fresh vegetables with feta cheese and olives', price: 11.99, imageUrl: '', category: 'Salads', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
      FoodItem(id: 'md3', name: 'Hummus Platter', description: 'House-made hummus with pita and vegetables', price: 9.99, imageUrl: '', category: 'Appetizers', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Sesame']),
      FoodItem(id: 'md4', name: 'Moussaka', description: 'Layered eggplant and meat casserole with béchamel', price: 17.99, imageUrl: '', category: 'Main Course', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'md5', name: 'Baklava', description: 'Flaky pastry with nuts and honey syrup', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.9, isVegetarian: true, allergens: ['Gluten', 'Nuts']),
    ];
  }

  static List<FoodItem> _getKebabCornerMenu() {
    return [
      FoodItem(id: 'kc1', name: 'Mixed Grill Platter', description: 'Assorted grilled meats with rice and salad', price: 19.99, imageUrl: '', category: 'Grilled', rating: 4.8, isVegetarian: false, allergens: []),
      FoodItem(id: 'kc2', name: 'Chicken Shawarma', description: 'Marinated chicken wrap with garlic sauce', price: 12.99, imageUrl: '', category: 'Wraps', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'kc3', name: 'Falafel Bowl', description: 'Chickpea fritters with tahini and vegetables', price: 11.99, imageUrl: '', category: 'Vegetarian', rating: 4.5, isVegetarian: true, allergens: ['Sesame']),
      FoodItem(id: 'kc4', name: 'Lamb Kofta', description: 'Spiced ground lamb skewers with mint yogurt', price: 16.99, imageUrl: '', category: 'Grilled', rating: 4.7, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'kc5', name: 'Turkish Delight', description: 'Rose-flavored confection dusted with powdered sugar', price: 4.99, imageUrl: '', category: 'Desserts', rating: 4.3, isVegetarian: true, allergens: ['Nuts']),
    ];
  }

  static List<FoodItem> _getVeggieParadiseMenu() {
    return [
      FoodItem(id: 'vp1', name: 'Beyond Burger', description: 'Plant-based burger with all the fixings', price: 14.99, imageUrl: '', category: 'Burgers', rating: 4.6, isVegetarian: true, allergens: ['Gluten']),
      FoodItem(id: 'vp2', name: 'Cauliflower Wings', description: 'Battered cauliflower with buffalo sauce', price: 10.99, imageUrl: '', category: 'Appetizers', rating: 4.4, isVegetarian: true, allergens: ['Gluten']),
      FoodItem(id: 'vp3', name: 'Vegan Pad Thai', description: 'Rice noodles with tofu and vegetables', price: 12.99, imageUrl: '', category: 'Asian', rating: 4.5, isVegetarian: true, allergens: ['Soy', 'Peanuts']),
      FoodItem(id: 'vp4', name: 'Quinoa Stuffed Bell Peppers', description: 'Bell peppers stuffed with quinoa and vegetables', price: 13.99, imageUrl: '', category: 'Main Course', rating: 4.7, isVegetarian: true, allergens: []),
      FoodItem(id: 'vp5', name: 'Coconut Ice Cream', description: 'Creamy coconut-based ice cream with toppings', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.3, isVegetarian: true, allergens: []),
    ];
  }

  static List<FoodItem> _getCoffeeCentralMenu() {
    return [
      FoodItem(id: 'cc1', name: 'Espresso', description: 'Rich and bold single shot espresso', price: 2.99, imageUrl: '', category: 'Coffee', rating: 4.7, isVegetarian: true, allergens: []),
      FoodItem(id: 'cc2', name: 'Caramel Macchiato', description: 'Espresso with steamed milk and caramel drizzle', price: 5.49, imageUrl: '', category: 'Coffee', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
      FoodItem(id: 'cc3', name: 'Croissant Sandwich', description: 'Buttery croissant with ham and cheese', price: 7.99, imageUrl: '', category: 'Breakfast', rating: 4.4, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'cc4', name: 'Blueberry Muffin', description: 'Fresh baked muffin with wild blueberries', price: 3.99, imageUrl: '', category: 'Pastries', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'cc5', name: 'Chai Tea Latte', description: 'Spiced tea blend with steamed milk', price: 4.99, imageUrl: '', category: 'Tea', rating: 4.3, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getLePetitBistroMenu() {
    return [
      FoodItem(id: 'lpb1', name: 'Coq au Vin', description: 'Braised chicken in red wine with vegetables', price: 24.99, imageUrl: '', category: 'French', rating: 4.9, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'lpb2', name: 'French Onion Soup', description: 'Traditional soup with gruyere cheese crouton', price: 8.99, imageUrl: '', category: 'Soups', rating: 4.8, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'lpb3', name: 'Duck Confit', description: 'Slow-cooked duck leg with garlic potatoes', price: 28.99, imageUrl: '', category: 'French', rating: 4.9, isVegetarian: false, allergens: []),
      FoodItem(id: 'lpb4', name: 'Ratatouille', description: 'Traditional vegetable stew from Provence', price: 16.99, imageUrl: '', category: 'Vegetarian', rating: 4.6, isVegetarian: true, allergens: []),
      FoodItem(id: 'lpb5', name: 'Crème Brûlée', description: 'Vanilla custard with caramelized sugar top', price: 9.99, imageUrl: '', category: 'Desserts', rating: 4.8, isVegetarian: true, allergens: ['Dairy', 'Eggs']),
    ];
  }

  static List<FoodItem> _getOceansCatchMenu() {
    return [
      FoodItem(id: 'oc1', name: 'Grilled Salmon Fillet', description: 'Atlantic salmon with lemon butter and herbs', price: 22.99, imageUrl: '', category: 'Seafood', rating: 4.8, isVegetarian: false, allergens: ['Fish', 'Dairy']),
      FoodItem(id: 'oc2', name: 'Seafood Paella', description: 'Spanish rice with shrimp, mussels, and calamari', price: 26.99, imageUrl: '', category: 'Seafood', rating: 4.9, isVegetarian: false, allergens: ['Shellfish', 'Fish']),
      FoodItem(id: 'oc3', name: 'Fish Tacos (3 pieces)', description: 'Blackened mahi-mahi with mango salsa', price: 16.99, imageUrl: '', category: 'Tacos', rating: 4.7, isVegetarian: false, allergens: ['Fish', 'Gluten']),
      FoodItem(id: 'oc4', name: 'Clam Chowder', description: 'New England style chowder with fresh clams', price: 9.99, imageUrl: '', category: 'Soups', rating: 4.6, isVegetarian: false, allergens: ['Shellfish', 'Dairy']),
      FoodItem(id: 'oc5', name: 'Lobster Roll', description: 'Fresh lobster meat on toasted brioche roll', price: 24.99, imageUrl: '', category: 'Sandwiches', rating: 4.8, isVegetarian: false, allergens: ['Shellfish', 'Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getHometownDinerMenu() {
    return [
      FoodItem(id: 'hd1', name: 'Classic Meatloaf', description: 'Homestyle meatloaf with mashed potatoes and gravy', price: 14.99, imageUrl: '', category: 'American', rating: 4.5, isVegetarian: false, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'hd2', name: 'Chicken Fried Steak', description: 'Breaded steak with country gravy and fries', price: 16.99, imageUrl: '', category: 'American', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'hd3', name: 'Apple Pie à la Mode', description: 'Fresh apple pie with vanilla ice cream', price: 7.99, imageUrl: '', category: 'Desserts', rating: 4.7, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'hd4', name: 'Breakfast Platter', description: 'Two eggs, bacon, sausage, hash browns, and toast', price: 12.99, imageUrl: '', category: 'Breakfast', rating: 4.4, isVegetarian: false, allergens: ['Gluten', 'Eggs']),
      FoodItem(id: 'hd5', name: 'Milkshake (Chocolate/Vanilla/Strawberry)', description: 'Thick milkshake made with real ice cream', price: 5.99, imageUrl: '', category: 'Beverages', rating: 4.5, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  // New restaurant menus
  static List<FoodItem> _getSeoulKitchenMenu() {
    return [
      FoodItem(id: 'sk1', name: 'Korean BBQ Beef Bowl', description: 'Marinated beef bulgogi with rice and kimchi', price: 15.99, imageUrl: '', category: 'Korean', rating: 4.8, isVegetarian: false, allergens: ['Soy', 'Sesame']),
      FoodItem(id: 'sk2', name: 'Bibimbap', description: 'Mixed rice bowl with vegetables and gochujang', price: 13.99, imageUrl: '', category: 'Korean', rating: 4.7, isVegetarian: true, allergens: ['Eggs', 'Soy', 'Sesame']),
      FoodItem(id: 'sk3', name: 'Korean Fried Chicken', description: 'Double-fried chicken with sweet and spicy glaze', price: 16.99, imageUrl: '', category: 'Korean', rating: 4.9, isVegetarian: false, allergens: ['Gluten', 'Soy']),
      FoodItem(id: 'sk4', name: 'Kimchi Jjigae', description: 'Spicy kimchi stew with pork and tofu', price: 12.99, imageUrl: '', category: 'Korean', rating: 4.6, isVegetarian: false, allergens: ['Soy']),
    ];
  }

  static List<FoodItem> _getPhoSaigonMenu() {
    return [
      FoodItem(id: 'ps1', name: 'Pho Bo (Beef Noodle Soup)', description: 'Traditional Vietnamese beef noodle soup', price: 12.99, imageUrl: '', category: 'Vietnamese', rating: 4.8, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'ps2', name: 'Banh Mi Sandwich', description: 'Vietnamese baguette with pork and pickled vegetables', price: 8.99, imageUrl: '', category: 'Vietnamese', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Eggs']),
      FoodItem(id: 'ps3', name: 'Fresh Spring Rolls', description: 'Rice paper rolls with shrimp and herbs', price: 9.99, imageUrl: '', category: 'Vietnamese', rating: 4.5, isVegetarian: false, allergens: ['Shellfish', 'Peanuts']),
      FoodItem(id: 'ps4', name: 'Vietnamese Iced Coffee', description: 'Strong coffee with condensed milk over ice', price: 4.99, imageUrl: '', category: 'Beverages', rating: 4.7, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getElMariachiMenu() {
    return [
      FoodItem(id: 'em1', name: 'Street Tacos (4 pieces)', description: 'Authentic street tacos with choice of meat', price: 12.99, imageUrl: '', category: 'Tacos', rating: 4.7, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'em2', name: 'Carne Asada Fries', description: 'Loaded fries with grilled steak and cheese', price: 14.99, imageUrl: '', category: 'Mexican', rating: 4.6, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'em3', name: 'Pozole Soup', description: 'Traditional Mexican soup with hominy and pork', price: 11.99, imageUrl: '', category: 'Soups', rating: 4.5, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'em4', name: 'Flan', description: 'Traditional caramel custard dessert', price: 6.99, imageUrl: '', category: 'Desserts', rating: 4.4, isVegetarian: true, allergens: ['Dairy', 'Eggs']),
    ];
  }

  static List<FoodItem> _getPizzeriaNapoliMenu() {
    return [
      FoodItem(id: 'pn1', name: 'Neapolitan Margherita', description: 'Wood-fired pizza with San Marzano tomatoes', price: 18.99, imageUrl: '', category: 'Pizza', rating: 4.9, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'pn2', name: 'Prosciutto e Arugula', description: 'Pizza with prosciutto, arugula, and parmesan', price: 22.99, imageUrl: '', category: 'Pizza', rating: 4.8, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'pn3', name: 'Quattro Stagioni', description: 'Four seasons pizza with varied toppings', price: 21.99, imageUrl: '', category: 'Pizza', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'pn4', name: 'Gelato Trio', description: 'Three scoops of authentic Italian gelato', price: 8.99, imageUrl: '', category: 'Desserts', rating: 4.6, isVegetarian: true, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getWingStopMenu() {
    return [
      FoodItem(id: 'ws1', name: 'Buffalo Wings (12 pieces)', description: 'Classic buffalo wings with celery and blue cheese', price: 14.99, imageUrl: '', category: 'Wings', rating: 4.8, isVegetarian: false, allergens: ['Dairy']),
      FoodItem(id: 'ws2', name: 'Honey BBQ Wings (12 pieces)', description: 'Sweet and smoky BBQ wings', price: 14.99, imageUrl: '', category: 'Wings', rating: 4.6, isVegetarian: false, allergens: []),
      FoodItem(id: 'ws3', name: 'Lemon Pepper Wings (12 pieces)', description: 'Dry-rubbed wings with lemon pepper seasoning', price: 14.99, imageUrl: '', category: 'Wings', rating: 4.7, isVegetarian: false, allergens: []),
      FoodItem(id: 'ws4', name: 'Loaded Fries', description: 'Fries topped with cheese, bacon, and ranch', price: 8.99, imageUrl: '', category: 'Sides', rating: 4.4, isVegetarian: false, allergens: ['Dairy']),
    ];
  }

  static List<FoodItem> _getMorningGloryMenu() {
    return [
      FoodItem(id: 'mg1', name: 'Full Breakfast Platter', description: 'Eggs, bacon, sausage, hash browns, and toast', price: 13.99, imageUrl: '', category: 'Breakfast', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Eggs']),
      FoodItem(id: 'mg2', name: 'Avocado Toast Deluxe', description: 'Smashed avocado with poached egg and hollandaise', price: 11.99, imageUrl: '', category: 'Breakfast', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Eggs', 'Dairy']),
      FoodItem(id: 'mg3', name: 'Breakfast Burrito', description: 'Scrambled eggs, cheese, and choice of meat in tortilla', price: 9.99, imageUrl: '', category: 'Breakfast', rating: 4.4, isVegetarian: false, allergens: ['Gluten', 'Eggs', 'Dairy']),
      FoodItem(id: 'mg4', name: 'Fresh Fruit Bowl', description: 'Seasonal fresh fruits with yogurt and granola', price: 8.99, imageUrl: '', category: 'Breakfast', rating: 4.3, isVegetarian: true, allergens: ['Dairy', 'Nuts']),
    ];
  }

  static List<FoodItem> _getPancakeParadiseMenu() {
    return [
      FoodItem(id: 'pp1', name: 'Classic Buttermilk Pancakes', description: 'Three fluffy pancakes with maple syrup', price: 9.99, imageUrl: '', category: 'Breakfast', rating: 4.7, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'pp2', name: 'Blueberry Pancakes', description: 'Pancakes loaded with fresh blueberries', price: 11.99, imageUrl: '', category: 'Breakfast', rating: 4.8, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'pp3', name: 'Chocolate Chip Pancakes', description: 'Pancakes with chocolate chips and whipped cream', price: 12.99, imageUrl: '', category: 'Breakfast', rating: 4.6, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
      FoodItem(id: 'pp4', name: 'French Toast', description: 'Thick-cut brioche French toast with cinnamon', price: 10.99, imageUrl: '', category: 'Breakfast', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Dairy', 'Eggs']),
    ];
  }

  static List<FoodItem> _getChickenDelightMenu() {
    return [
      FoodItem(id: 'cd1', name: 'Fried Chicken Bucket (8 pieces)', description: 'Crispy fried chicken with secret spices', price: 19.99, imageUrl: '', category: 'Fried Chicken', rating: 4.7, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'cd2', name: 'Chicken Tenders (6 pieces)', description: 'Hand-breaded chicken tenders with dipping sauce', price: 12.99, imageUrl: '', category: 'Fried Chicken', rating: 4.5, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'cd3', name: 'Spicy Chicken Sandwich', description: 'Crispy chicken breast with spicy mayo and pickles', price: 11.99, imageUrl: '', category: 'Sandwiches', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Eggs']),
      FoodItem(id: 'cd4', name: 'Biscuits and Gravy', description: 'Buttery biscuits with sausage gravy', price: 7.99, imageUrl: '', category: 'Breakfast', rating: 4.4, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getSandwichCentralMenu() {
    return [
      FoodItem(id: 'sc1', name: 'Italian Sub', description: 'Salami, ham, provolone with Italian dressing', price: 10.99, imageUrl: '', category: 'Sandwiches', rating: 4.6, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sc2', name: 'Turkey Club', description: 'Turkey, bacon, lettuce, tomato on toasted bread', price: 11.99, imageUrl: '', category: 'Sandwiches', rating: 4.5, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'sc3', name: 'Reuben Sandwich', description: 'Corned beef, sauerkraut, Swiss cheese on rye', price: 12.99, imageUrl: '', category: 'Sandwiches', rating: 4.7, isVegetarian: false, allergens: ['Gluten', 'Dairy']),
      FoodItem(id: 'sc4', name: 'Grilled Cheese & Tomato Soup', description: 'Classic grilled cheese with creamy tomato soup', price: 9.99, imageUrl: '', category: 'Combos', rating: 4.4, isVegetarian: true, allergens: ['Gluten', 'Dairy']),
    ];
  }

  static List<FoodItem> _getNoodleHouseMenu() {
    return [
      FoodItem(id: 'nh1', name: 'Tonkotsu Ramen', description: 'Rich pork bone broth with chashu and egg', price: 14.99, imageUrl: '', category: 'Ramen', rating: 4.9, isVegetarian: false, allergens: ['Gluten', 'Eggs', 'Soy']),
      FoodItem(id: 'nh2', name: 'Beef Pho', description: 'Vietnamese beef noodle soup with herbs', price: 13.99, imageUrl: '', category: 'Vietnamese', rating: 4.8, isVegetarian: false, allergens: ['Gluten']),
      FoodItem(id: 'nh3', name: 'Dan Dan Noodles', description: 'Sichuan noodles with spicy peanut sauce', price: 12.99, imageUrl: '', category: 'Chinese', rating: 4.6, isVegetarian: true, allergens: ['Gluten', 'Peanuts', 'Soy']),
      FoodItem(id: 'nh4', name: 'Udon Stir Fry', description: 'Thick wheat noodles with vegetables and teriyaki', price: 11.99, imageUrl: '', category: 'Japanese', rating: 4.5, isVegetarian: true, allergens: ['Gluten', 'Soy']),
    ];
  }
}