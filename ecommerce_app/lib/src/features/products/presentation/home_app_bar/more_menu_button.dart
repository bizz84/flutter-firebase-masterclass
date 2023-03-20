import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:go_router/go_router.dart';

enum PopupMenuOption {
  signIn,
  orders,
  account,
  admin,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key, this.user, required this.isAdminUser});
  final AppUser? user;
  final bool isAdminUser;

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const ordersKey = Key('menuOrders');
  static const accountKey = Key('menuAccount');
  static const adminKey = Key('menuAdmin');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return <PopupMenuEntry<PopupMenuOption>>[
          if (user != null) ...[
            PopupMenuItem(
              key: ordersKey,
              value: PopupMenuOption.orders,
              child: Text('Orders'.hardcoded),
            ),
            PopupMenuItem(
              key: accountKey,
              value: PopupMenuOption.account,
              child: Text('Account'.hardcoded),
            ),
            if (isAdminUser)
              PopupMenuItem(
                key: adminKey,
                value: PopupMenuOption.admin,
                child: Text('Admin'.hardcoded),
              ),
          ] else
            PopupMenuItem(
              key: signInKey,
              value: PopupMenuOption.signIn,
              child: Text('Sign In'.hardcoded),
            ),
        ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            context.pushNamed(AppRoute.signIn.name);
          case PopupMenuOption.orders:
            context.pushNamed(AppRoute.orders.name);
          case PopupMenuOption.account:
            context.pushNamed(AppRoute.account.name);
          case PopupMenuOption.admin:
            context.pushNamed(AppRoute.admin.name);
        }
      },
    );
  }
}
