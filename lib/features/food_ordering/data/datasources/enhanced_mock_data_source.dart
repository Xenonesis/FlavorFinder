import '../../domain/entities/restaurant.dart';
import '../../domain/entities/food_item.dart';

class EnhancedMockDataSource {
  static List<Restaurant> getRestaurants() {
    return [
      // Pizza Places
      Restaurant(
        id: '1',
        name: 'Tony\'s Authentic Pizza',
        cuisine: 'Italian',
        rating: 4.8,
        deliveryTime: 25,
        deliveryFee: 2.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '2',
        name: 'Slice Paradise',
        cuisine: 'Italian',
        rating: 4.6,
        deliveryTime: 30,
        deliveryFee: 1.99,
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
      ),
      
      // Asian Cuisine
      Restaurant(
        id: '3',
        name: 'Dragon Palace',
        cuisine: 'Chinese',
        rating: 4.7,
        deliveryTime: 35,
        deliveryFee: 3.49,
        imageUrl: 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '4',
        name: 'Sakura Sushi Bar',
        cuisine: 'Japanese',
        rating: 4.9,
        deliveryTime: 40,
        deliveryFee: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '5',
        name: 'Bangkok Street Food',
        cuisine: 'Thai',
        rating: 4.5,
        deliveryTime: 28,
        deliveryFee: 2.49,
        imageUrl: 'https://images.unsplash.com/photo-1559847844-d721426d6edc?w=400&h=300&fit=crop',
      ),
      
      // American & Fast Food
      Restaurant(
        id: '6',
        name: 'Burger Junction',
        cuisine: 'American',
        rating: 4.4,
        deliveryTime: 20,
        deliveryFee: 1.49,
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '7',
        name: 'Grill Master BBQ',
        cuisine: 'American',
        rating: 4.6,
        deliveryTime: 35,
        deliveryFee: 3.99,
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&h=300&fit=crop',
      ),
      
      // Indian Cuisine
      Restaurant(
        id: '8',
        name: 'Spice Garden',
        cuisine: 'Indian',
        rating: 4.7,
        deliveryTime: 32,
        deliveryFee: 2.99,
        imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '9',
        name: 'Mumbai Express',
        cuisine: 'Indian',
        rating: 4.5,
        deliveryTime: 38,
        deliveryFee: 3.49,
        imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&h=300&fit=crop',
      ),
      
      // Mexican Cuisine
      Restaurant(
        id: '10',
        name: 'Casa Mexicana',
        cuisine: 'Mexican',
        rating: 4.6,
        deliveryTime: 25,
        deliveryFee: 2.49,
        imageUrl: 'https://images.unsplash.com/photo-1565299585323-38174c4a6471?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '11',
        name: 'Taco Fiesta',
        cuisine: 'Mexican',
        rating: 4.3,
        deliveryTime: 22,
        deliveryFee: 1.99,
        imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400&h=300&fit=crop',
      ),
      
      // Mediterranean & Middle Eastern
      Restaurant(
        id: '12',
        name: 'Mediterranean Delights',
        cuisine: 'Mediterranean',
        rating: 4.8,
        deliveryTime: 30,
        deliveryFee: 3.99,
        imageUrl: 'https://images.unsplash.com/photo-1544510808-efac33be2456?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '13',
        name: 'Kebab Corner',
        cuisine: 'Middle Eastern',
        rating: 4.4,
        deliveryTime: 26,
        deliveryFee: 2.99,
        imageUrl: 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=400&h=300&fit=crop',
      ),
      
      // Healthy & Vegetarian
      Restaurant(
        id: '14',
        name: 'Green Bowl',
        cuisine: 'Healthy',
        rating: 4.7,
        deliveryTime: 20,
        deliveryFee: 2.49,
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '15',
        name: 'Veggie Paradise',
        cuisine: 'Vegetarian',
        rating: 4.5,
        deliveryTime: 25,
        deliveryFee: 1.99,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
      ),
      
      // Desserts & Coffee
      Restaurant(
        id: '16',
        name: 'Sweet Dreams Bakery',
        cuisine: 'Desserts',
        rating: 4.9,
        deliveryTime: 15,
        deliveryFee: 1.49,
        imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '17',
        name: 'Coffee Central',
        cuisine: 'Coffee & Tea',
        rating: 4.6,
        deliveryTime: 12,
        deliveryFee: 0.99,
        imageUrl: 'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400&h=300&fit=crop',
      ),
      
      // Fine Dining
      Restaurant(
        id: '18',
        name: 'Le Petit Bistro',
        cuisine: 'French',
        rating: 4.9,
        deliveryTime: 45,
        deliveryFee: 5.99,
        imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop',
      ),
      Restaurant(
        id: '19',
        name: 'Ocean\'s Catch',
        cuisine: 'Seafood',
        rating: 4.8,
        deliveryTime: 40,
        deliveryFee: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44?w=400&h=300&fit=crop',
      ),
      
      // Local Favorites
      Restaurant(
        id: '20',
        name: 'Hometown Diner',
        cuisine: 'American',
        rating: 4.3,
        deliveryTime: 28,
        deliveryFee: 2.99,
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=300&fit=crop',
      ),
    ];
  }

  static List<FoodItem> getFoodItems() {
    return [
      // Tony's Authentic Pizza
      FoodItem(
        id: '1',
        name: 'Margherita Pizza',
        description: 'Fresh mozzarella, tomato sauce, basil, and olive oil on our signature thin crust',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '2',
        name: 'Pepperoni Supreme',
        description: 'Premium pepperoni, mozzarella cheese, and our special tomato sauce',
        price: 19.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '3',
        name: 'Meat Lovers Pizza',
        description: 'Pepperoni, sausage, bacon, ham, and ground beef with extra cheese',
        price: 24.99,
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop',
        category: 'Pizza',
        rating: 4.9,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      
      // Dragon Palace - Chinese
      FoodItem(
        id: '4',
        name: 'General Tso\'s Chicken',
        description: 'Crispy chicken in sweet and tangy sauce with steamed rice',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?w=400&h=300&fit=crop',
        category: 'Main Course',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Soy', 'Gluten'],
      ),
      FoodItem(
        id: '5',
        name: 'Kung Pao Chicken',
        description: 'Diced chicken with peanuts, vegetables, and chili peppers in savory sauce',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=400&h=300&fit=crop',
        category: 'Main Course',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Peanuts', 'Soy'],
      ),
      FoodItem(
        id: '6',
        name: 'Vegetable Lo Mein',
        description: 'Soft noodles stir-fried with mixed vegetables in savory sauce',
        price: 11.99,
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=300&fit=crop',
        category: 'Noodles',
        rating: 4.4,
        isVegetarian: true,
        allergens: ['Gluten', 'Soy'],
      ),
      
      // Sakura Sushi Bar
      FoodItem(
        id: '7',
        name: 'California Roll',
        description: 'Crab, avocado, and cucumber wrapped in seaweed and rice',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop',
        category: 'Sushi',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Shellfish'],
      ),
      FoodItem(
        id: '8',
        name: 'Salmon Nigiri (6 pieces)',
        description: 'Fresh salmon over seasoned sushi rice',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=400&h=300&fit=crop',
        category: 'Sushi',
        rating: 4.9,
        isVegetarian: false,
        allergens: ['Fish'],
      ),
      FoodItem(
        id: '9',
        name: 'Dragon Roll',
        description: 'Eel and cucumber inside, avocado and eel sauce on top',
        price: 15.99,
        imageUrl: 'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?w=400&h=300&fit=crop',
        category: 'Sushi',
        rating: 4.8,
        isVegetarian: false,
        allergens: ['Fish', 'Soy'],
      ),
      
      // Burger Junction
      FoodItem(
        id: '10',
        name: 'Classic Cheeseburger',
        description: 'Beef patty with cheese, lettuce, tomato, onion, and our special sauce',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400&h=300&fit=crop',
        category: 'Burgers',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '11',
        name: 'BBQ Bacon Burger',
        description: 'Double beef patty with bacon, BBQ sauce, onion rings, and cheddar cheese',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=400&h=300&fit=crop',
        category: 'Burgers',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '12',
        name: 'Crispy Chicken Sandwich',
        description: 'Fried chicken breast with mayo, lettuce, and pickles on brioche bun',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1606755962773-d324e2d53014?w=400&h=300&fit=crop',
        category: 'Sandwiches',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Gluten', 'Eggs'],
      ),
    ];
  }

  static List<FoodItem> getMoreFoodItems() {
    return [
      // Spice Garden - Indian
      FoodItem(
        id: '13',
        name: 'Butter Chicken',
        description: 'Tender chicken in creamy tomato-based curry sauce with basmati rice',
        price: 15.99,
        imageUrl: 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&h=300&fit=crop',
        category: 'Main Course',
        rating: 4.8,
        isVegetarian: false,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: '14',
        name: 'Vegetable Biryani',
        description: 'Fragrant basmati rice with mixed vegetables and aromatic spices',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1563379091339-03246963d51a?w=400&h=300&fit=crop',
        category: 'Rice',
        rating: 4.6,
        isVegetarian: true,
        allergens: [],
      ),
      FoodItem(
        id: '15',
        name: 'Chicken Tikka Masala',
        description: 'Grilled chicken in rich, creamy tomato curry with naan bread',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400&h=300&fit=crop',
        category: 'Main Course',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Dairy', 'Gluten'],
      ),
      
      // Casa Mexicana
      FoodItem(
        id: '16',
        name: 'Chicken Quesadilla',
        description: 'Grilled chicken and cheese in flour tortilla with salsa and sour cream',
        price: 11.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299585323-38174c4a6471?w=400&h=300&fit=crop',
        category: 'Mexican',
        rating: 4.5,
        isVegetarian: false,
        allergens: ['Gluten', 'Dairy'],
      ),
      FoodItem(
        id: '17',
        name: 'Beef Burrito Bowl',
        description: 'Seasoned beef with rice, beans, lettuce, cheese, and guacamole',
        price: 13.99,
        imageUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400&h=300&fit=crop',
        category: 'Bowls',
        rating: 4.6,
        isVegetarian: false,
        allergens: ['Dairy'],
      ),
      FoodItem(
        id: '18',
        name: 'Fish Tacos (3 pieces)',
        description: 'Grilled fish with cabbage slaw, pico de gallo, and chipotle sauce',
        price: 14.99,
        imageUrl: 'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=400&h=300&fit=crop',
        category: 'Tacos',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Fish', 'Gluten'],
      ),
      
      // Green Bowl - Healthy
      FoodItem(
        id: '19',
        name: 'Quinoa Power Bowl',
        description: 'Quinoa with roasted vegetables, avocado, and tahini dressing',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400&h=300&fit=crop',
        category: 'Bowls',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Sesame'],
      ),
      FoodItem(
        id: '20',
        name: 'Grilled Salmon Salad',
        description: 'Fresh salmon over mixed greens with cherry tomatoes and lemon vinaigrette',
        price: 16.99,
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=300&fit=crop',
        category: 'Salads',
        rating: 4.7,
        isVegetarian: false,
        allergens: ['Fish'],
      ),
      FoodItem(
        id: '21',
        name: 'Acai Bowl',
        description: 'Acai berry blend topped with granola, fresh berries, and honey',
        price: 9.99,
        imageUrl: 'https://images.unsplash.com/photo-1511690743698-d9d85f2fbf38?w=400&h=300&fit=crop',
        category: 'Breakfast',
        rating: 4.6,
        isVegetarian: true,
        allergens: ['Nuts'],
      ),
      
      // Sweet Dreams Bakery
      FoodItem(
        id: '22',
        name: 'Chocolate Lava Cake',
        description: 'Warm chocolate cake with molten center, served with vanilla ice cream',
        price: 7.99,
        imageUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.9,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: '23',
        name: 'New York Cheesecake',
        description: 'Classic creamy cheesecake with graham cracker crust and berry compote',
        price: 6.99,
        imageUrl: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.8,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
      FoodItem(
        id: '24',
        name: 'Tiramisu',
        description: 'Italian dessert with coffee-soaked ladyfingers and mascarpone cream',
        price: 8.99,
        imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=400&h=300&fit=crop',
        category: 'Desserts',
        rating: 4.7,
        isVegetarian: true,
        allergens: ['Gluten', 'Dairy', 'Eggs'],
      ),
    ];
  }

  static List<FoodItem> getAllFoodItems() {
    return [...getFoodItems(), ...getMoreFoodItems()];
  }
}
