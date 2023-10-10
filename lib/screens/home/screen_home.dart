



import 'package:flutter/material.dart';
import 'package:moneymanegment_app/screens/add_transaction/screen_add_trancations.dart';
import 'package:moneymanegment_app/screens/category/category_add_popup.dart';
import 'package:moneymanegment_app/screens/category/screen_category.dart';
import 'package:moneymanegment_app/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanegment_app/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifer = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifer,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifer.value == 0) {
            print('Add transactions');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
             print('Add category');
             showCategoryPopup(context);
            // final _sample = CategoryModel(
            //     id: DateTime.now().microsecondsSinceEpoch.toString(),
            //     name: 'Travel',
            //     type: CategoryType.expense,
            // );
            // CategoryDb().insertCategory(_sample);
          }
        },
        child: Icon(Icons.add),
        splashColor: Colors.red,
      ),
    );
  }
}
