import 'package:auto_route/auto_route.dart';

import 'package:trabcon_flutter/presentation/pages/jobs/jobs_page.dart';
import 'package:trabcon_flutter/presentation/pages/my_data/my_data_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    //AutoRoute(page: SplashPage),

    //AutoRoute(page: SignInPage, path: "signin"),
    //AutoRoute(page: SignUpPage, path: "sign-up"),
    //AutoRoute(page: ForgotPasswordPage, path: "forgot-password"),
    //AutoRoute(page: ChangePasswordPage, path: "change-password"),
    AutoRoute(
      page: MyDataPage,
      path: "my-data",
      initial: true,
    ),
    //AutoRoute(page: ProfilePage, path: "profile"),
    AutoRoute(page: JobsPage, path: "jobs")
  ],
)
class $AppRouter {}
