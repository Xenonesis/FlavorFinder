# FlavorFinder - Food Delivery App

A Flutter food delivery application called FlavorFinder featuring a complete ordering workflow with BLoC architecture, realistic UI design, and proper error handling.

## Features

- **Restaurant Browsing**: View a list of local restaurants with ratings, delivery times, and cuisine types
- **Menu Exploration**: Browse restaurant menus with categorized food items
- **Cart Management**: Add items to cart with quantity selection and special instructions
- **Order Workflow**: Complete checkout process with delivery details and payment selection
- **Order Confirmation**: Receive order confirmation with detailed order summary
- **Error Handling**: Comprehensive error handling throughout the application
- **Cross-Platform**: Works on mobile (iOS/Android) and web browsers
- **Responsive Design**: Beautiful, modern UI with smooth animations

## Architecture

This app follows the **Clean Architecture** principles with **BLoC** (Business Logic Component) pattern for state management:

```
lib/
├── core/
│   └── theme/                 # App-wide theming
├── features/
│   └── food_ordering/
│       ├── data/              # Data layer
│       │   ├── datasources/   # Mock data source
│       │   └── repositories/  # Repository implementations
│       ├── domain/            # Domain layer
│       │   ├── entities/      # Business entities
│       │   └── repositories/  # Repository interfaces
│       └── presentation/      # Presentation layer
│           ├── bloc/          # BLoC state management
│           ├── pages/         # UI pages
│           └── widgets/       # Reusable widgets
└── main.dart                  # App entry point
```

## Screenshots

### Restaurant List
![Restaurant List](https://via.placeholder.com/300x600/FF6B35/FFFFFF?text=Restaurant+List)

### Restaurant Menu
![Restaurant Menu](https://via.placeholder.com/300x600/FF6B35/FFFFFF?text=Restaurant+Menu)

### Shopping Cart
![Shopping Cart](https://via.placeholder.com/300x600/FF6B35/FFFFFF?text=Shopping+Cart)

### Checkout Process
![Checkout](https://via.placeholder.com/300x600/FF6B35/FFFFFF?text=Checkout)

### Order Confirmation
![Order Confirmation](https://via.placeholder.com/300x600/FF6B35/FFFFFF?text=Order+Confirmed)

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- iOS Simulator / Android Emulator / Web Browser (Chrome, Edge, Firefox)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd food_delivery_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
    ```bash
    flutter run
    ```
    
    To run on web browser:
    ```bash
    flutter run -d chrome  # For Chrome
    flutter run -d edge    # For Edge
    flutter run -d firefox # For Firefox

### Running Tests

Execute the unit tests for the BLoC components:

```bash
flutter test
```

For test coverage report:

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Technical Implementation

### State Management
- **BLoC Pattern**: Used for predictable state management
- **Repository Pattern**: Separates data access logic
- **Dependency Injection**: Clean separation of concerns

### Key BLoCs
- **RestaurantBloc**: Manages restaurant list state
- **CartBloc**: Handles shopping cart operations
- **OrderBloc**: Manages order placement workflow

### Data Layer
- **Mock Data Source**: Simulates API responses with realistic data
- **Repository Pattern**: Abstracts data access

### UI/UX Features
- **Material Design 3**: Modern, clean interface
- **Custom Theme**: Consistent color scheme and typography
- **Loading States**: Proper loading indicators
- **Error Handling**: User-friendly error messages
- **Form Validation**: Input validation for checkout
- **Responsive Design**: Adapts to different screen sizes

## Order Workflow

1. **Browse Restaurants**: Users see a list of available restaurants
2. **Select Restaurant**: Tap on a restaurant to view its menu
3. **Browse Menu**: View categorized food items with filters
4. **Add to Cart**: Select items with quantity and special instructions
5. **Review Cart**: Modify items, quantities, or remove items
6. **Checkout**: Enter delivery details and payment information
7. **Place Order**: Confirm order with loading state and error handling
8. **Order Confirmation**: Receive confirmation with order details

## SOLID Principles Implementation

- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Code is open for extension, closed for modification
- **Liskov Substitution**: Derived classes are substitutable for base classes
- **Interface Segregation**: Clients depend only on interfaces they use
- **Dependency Inversion**: High-level modules don't depend on low-level modules

## Error Handling

- **Network Errors**: Graceful handling of connection issues
- **Validation Errors**: Form validation with user feedback
- **Payment Errors**: Simulated payment failures with retry options
- **Loading States**: Clear indication of processing states

## Mock Data

The app uses realistic mock data including:
- 5 different restaurants with varied cuisines
- 14+ food items with detailed descriptions
- Proper restaurant information (ratings, delivery times, fees)
- Allergen information and dietary indicators

## Future Enhancements

- Real API integration
- User authentication
- Order tracking with live updates
- Push notifications
- Favorites and order history
- Payment gateway integration
- Restaurant reviews and ratings
- Location-based restaurant filtering

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, please contact [your-email@example.com](mailto:your-email@example.com)