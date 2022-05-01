import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/products_gird.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../providers/product.dart' as cat;
import '../providers/cart.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen>
    with TickerProviderStateMixin {
  @override
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      key: _globalKey,
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              top: 40,
            ),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      _globalKey.currentState!.openDrawer();
                    }),
                Spacer(),
                Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch!,
                    value: cart.itemCount.toString(),
                  ),
                  child: IconButton(
                    iconSize: 28,
                    icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Login'),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                tabs: [
                  Tab(text: 'Makanan'),
                  Tab(text: 'Minuman'),
                  Tab(text: 'Dessert')
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ProductsGrid(
                    categoryProduct: cat.Category.Food,
                  ),
                  ProductsGrid(
                    categoryProduct: cat.Category.Drinks,
                  ),
                  ProductsGrid(
                    categoryProduct: cat.Category.Dessert,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
