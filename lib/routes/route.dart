import 'package:go_router/go_router.dart';
import 'package:kasir_app/screens/detail_screen.dart';
import 'package:kasir_app/screens/order_screen.dart';
import 'package:kasir_app/screens/product_screen.dart';
import 'package:kasir_app/models/dummy.dart';
import 'package:kasir_app/models/item_model.dart';

class RoutesConfig {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/product',
    routes: [
      GoRoute(
        path: '/product',
        builder: (context, state) => const ProductScreen(),
      ),
      GoRoute(
        path: '/detail/:productId',
        builder: (context, state) {
          final productIdString = state.pathParameters['productId'] ?? '';
          final productId = int.tryParse(productIdString) ?? 0;

          final item = _getItemById(productId);

          return DetailScreen(item: item);
        },
      ),
      GoRoute(
        path: '/order',
        builder: (context, state) => const OrderScreen(),
      ),
    ],
  );

  static Item _getItemById(int productId) {
    return Dummy.itemList.firstWhere(
      (item) => item.productId == productId,
      orElse: () => Dummy.itemList.first,
    );
  }
}
