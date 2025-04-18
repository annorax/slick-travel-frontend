import 'package:auto_route/auto_route.dart';
import 'package:slick_travel_frontend/globals.dart';
import 'package:slick_travel_frontend/router/app_router.gr.dart';
import 'package:slick_travel_frontend/model/user.model.dart';
import 'package:slick_travel_frontend/model/user.state.dart';

@AutoRouterConfig(replaceInRouteName: "Page,")
class AppRouter extends RootStackRouter {

  @override
  late final List<AutoRouteGuard> guards = [
    AutoRouteGuard.simple((resolver, router) {
      User? user = userState.getValueSyncNoInit();
      if (user != null || resolver.route.name == Login.name || authProvider.isLoggedIn) {
        resolver.next();
      } else {
        resolver.redirectUntil(Login(onResult: (didLogin) => resolver.resolveNext(didLogin, reevaluateNext: false)));
      }
    }) 
  ];

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: Dashboard.page,
          initial: true,
          children: [
            AutoRoute(page: Items.page),
            AutoRoute(page: Products.page),
            AutoRoute(page: PurchaseOrders.page)
          ]
        ),
        AutoRoute(
          page: Login.page
        ),
      ];
}
