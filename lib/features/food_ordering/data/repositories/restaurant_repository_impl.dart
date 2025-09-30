import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../datasources/mock_data_source.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final MockDataSource dataSource;

  RestaurantRepositoryImpl({required this.dataSource});

  @override
  Future<List<Restaurant>> getRestaurants() async {
    try {
      return MockDataSource.getRestaurants();
    } catch (e) {
      throw Exception('Failed to load restaurants: ${e.toString()}');
    }
  }
}