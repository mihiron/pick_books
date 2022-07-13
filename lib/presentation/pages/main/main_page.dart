import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pick_books/extensions/context_extension.dart';
import 'package:pick_books/presentation/pages/app/book_page.dart';
import 'package:pick_books/presentation/pages/app/profile_page.dart';

import 'tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static Future<void> show(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushReplacement<void, void>(
        PageTransition(
          type: PageTransitionType.fade,
          child: const MainPage(),
          duration: const Duration(milliseconds: 500),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = useState<List<Widget>>([
      const BookPage(),
      const ProfilePage(),
    ]);

    final navigatorKeys = useState([
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ]);

    final selectedIndex = useState(0);

    return WillPopScope(
      onWillPop: () async {
        final keyTab = navigatorKeys.value[selectedIndex.value];
        if (keyTab.currentState != null && keyTab.currentState!.canPop()) {
          return !await keyTab.currentState!.maybePop();
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: List.generate(
            widgets.value.length,
            (index) => Offstage(
              offstage: index != selectedIndex.value,
              child: TabNavigator(
                navigatorKey: navigatorKeys.value[index],
                page: widgets.value[index],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'MyPage',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex.value,
          showSelectedLabels: !context.isIphoneMiniSize,
          showUnselectedLabels: !context.isIphoneMiniSize,
          onTap: (index) {
            selectedIndex.value = index;
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
