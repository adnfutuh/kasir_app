import 'package:kasir_app/models/categories.dart';
import 'package:kasir_app/models/item_model.dart';

class Dummy {
  static final List<Item> itemList = [
    Item(
      productId: 1,
      name: 'Healthy noodle with spinach leaf',
      description:
          'This dish features a delicious blend of soft noodles and fresh spinach leaves, offering a nutritious and light meal. The noodles are made from high-quality, low-calorie ingredients, rich in fiber to help you feel satisfied without the guilt. The spinach adds a burst of essential nutrients like iron, vitamins A and K, and folate, making it a great choice for boosting your health.With its fresh, light flavor, this meal is perfect for those looking for a healthy and flavorful option. Whether for lunch or dinner, it’s a fantastic choice for anyone looking to eat well and maintain a balanced lifestyle.',
      imageUrl: 'assets/images/image1.png',
      rating: 4.5,
      category: Categories.main,
      price: 3.29,
      stock: 22,
    ),
    Item(
      productId: 2,
      name: 'Salted Pasta with mushroom sauce',
      description:
          'This dish features a savory combination of perfectly cooked pasta paired with a rich and creamy mushroom sauce. The pasta is tender and absorbs the delicious, earthy flavors of the sauce, which is made from fresh mushrooms, aromatic herbs, and a velvety base. Each bite offers a balance of umami and richness, with the mushrooms adding depth and a natural sweetness. Topped with a sprinkle of grated cheese, this meal is a comforting, satisfying option perfect for any time of day. Whether you\'re craving something indulgent or simply looking for a flavorful meal, this dish is a wonderful choice.',
      imageUrl: 'assets/images/image2.png',
      rating: 4.7,
      category: Categories.main,
      price: 2.69,
      stock: 11,
    ),
    Item(
      productId: 3,
      name: 'Beef dumpling in hot and sour soup',
      description:
          'This dish combines tender, flavorful beef dumplings with a bold and tangy hot and sour soup. The dumplings are stuffed with seasoned ground beef, creating a savory bite with every spoonful. The soup itself is a perfect balance of spicy heat and tangy vinegar, with a hint of sweetness to round out the flavor profile. Infused with aromatic herbs and spices, the broth is both invigorating and comforting. The dish is often garnished with fresh herbs and a dash of chili oil for an extra kick, making it a warm, satisfying choice for anyone seeking a flavorful, hearty meal.',
      imageUrl: 'assets/images/image3.png',
      rating: 4.7,
      category: Categories.main,
      price: 2.99,
      stock: 16,
    ),
    Item(
      productId: 4,
      name: 'Hot spicy fried rice with omelet',
      description:
          'This dish offers a perfect blend of bold and spicy flavors, featuring fragrant fried rice stir-fried with a rich, savory combination of spices. It is topped with a perfectly cooked omelet, which adds a silky texture and a savory depth to the dish. The rice is infused with a delightful mix of seasonings, vegetables, and a hint of heat, making it a flavorful and satisfying meal. Whether you\'re craving something spicy for lunch or dinner, this dish delivers a satisfying combination of heat, richness, and texture, sure to delight your taste buds.',
      imageUrl: 'assets/images/image4.png',
      rating: 4.6,
      category: Categories.main,
      price: 3.49,
      stock: 13,
    ),
    Item(
      productId: 5,
      name: 'Spicy seasoned seafood noodles',
      description:
          'This dish combines tender noodles with a variety of fresh seafood, all tossed in a spicy, aromatic sauce. The seasoning brings a perfect balance of heat, tang, and savory flavors, enhancing the natural sweetness of the seafood. The noodles are cooked to perfection, absorbing all the bold flavors from the sauce, while the seafood, including shrimp, squid, and other delicacies, adds a delightful texture and richness to the dish. It’s an ideal choice for those who enjoy a spicy, flavorful meal with a satisfying mix of textures and tastes.',
      imageUrl: 'assets/images/image5.png',
      rating: 4.5,
      category: Categories.main,
      price: 2.29,
      stock: 20,
    ),
    Item(
      productId: 6,
      name: 'Spicy instant noodle with special omelet',
      description:
          'This dish features a satisfying bowl of instant noodles, perfectly seasoned with a bold, spicy broth that brings a kick of heat. The noodles are tender yet firm, absorbing the rich, flavorful sauce. Topped with a special omelet, the eggs add a creamy and savory contrast to the spice, creating a balanced and comforting meal. It\'s a quick, flavorful choice for those who crave a spicy, hearty dish with a touch of indulgence from the omelet, making it ideal for any time of the day.',
      imageUrl: 'assets/images/image6.png',
      rating: 4.8,
      category: Categories.main,
      price: 3.59,
      stock: 17,
    ),
  ];
}
