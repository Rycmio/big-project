import './product.dart';

class Products {
  static List<Product> items = [
    Product(
      id: 'food1',
      imageUrl:
          'https://cdns.klimg.com/merdeka.com/i/w/news/2021/08/27/1345870/content_images/670x335/20210827142321-1-ilustrasi-bakso-009-tantri-setyorini.jpg',
      name: 'Bakso',
      price: 15000,
      status: true,
      kindOfFood: KindOfFood.Food,
    ),
    Product(
      id: 'food2',
      imageUrl:
          'https://merahputih.com/media/7b/e2/24/7be2245ab4a3a5d334eefc1879d376d2.jpg',
      name: 'Es Jeruk Kecil',
      price: 5000,
      status: true,
      kindOfFood: KindOfFood.Drinks,
    ),
    Product(
      id: 'food3',
      imageUrl:
          'https://awsimages.detik.net.id/customthumb/2015/01/10/297/132450_coverfatbubble2.jpg?w=700&q=90',
      name: 'Es Serut Matcha',
      price: 10000,
      status: true,
      kindOfFood: KindOfFood.Desert,
    ),
  ];
}
