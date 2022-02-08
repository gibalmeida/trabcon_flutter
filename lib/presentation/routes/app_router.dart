import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trabcon_flutter/presentation/pages/auth_gate/auth_gate.dart';

import 'package:trabcon_flutter/presentation/pages/jobs/jobs_page.dart';
import 'package:trabcon_flutter/presentation/pages/my_data/my_data_page.dart';

import 'package:trabcon_flutter/presentation/routes/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (FirebaseAuth.instance.currentUser != null) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
      // we redirect the user to our login page
      router.push(AuthGateRoute(onResult: (success) {
        // if success == true the navigation will be resumed
        // else it will be aborted
        resolver.next(success);
      }));
    }
  }
}

@MaterialAutoRouter(
  routes: <AutoRoute>[
    //AutoRoute(page: SplashPage),
    AutoRoute(page: AuthGate, path: "auth-gate"),
    //AutoRoute(page: SignInPage, path: "signin"),
    //AutoRoute(page: SignUpPage, path: "sign-up"),
    //AutoRoute(page: ForgotPasswordPage, path: "forgot-password"),
    //AutoRoute(page: ChangePasswordPage, path: "change-password"),
    AutoRoute(
        page: MyDataPage, path: "my-data", guards: [AuthGuard], initial: true),
    //AutoRoute(page: ProfilePage, path: "profile"),
    AutoRoute(page: JobsPage, path: "jobs")
  ],
)
class $AppRouter {}
