import 'package:auto_route/annotations.dart';
import 'package:trabcon_flutter/presentation/pages/change_password/change_password_page.dart';
import 'package:trabcon_flutter/presentation/pages/forgot_password/forgot_pasword_page.dart';
import 'package:trabcon_flutter/presentation/pages/jobs/jobs_page.dart';
import 'package:trabcon_flutter/presentation/pages/my_data/my_data_page.dart';
import 'package:trabcon_flutter/presentation/pages/profile/profile.dart';
import 'package:trabcon_flutter/presentation/pages/sign-in/sign_in_page.dart';
import 'package:trabcon_flutter/presentation/pages/sign-up/sign_up_page.dart';
import 'package:trabcon_flutter/presentation/pages/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage),
    AutoRoute(page: SignInPage, path: "signin"),
    AutoRoute(page: SignUpPage, path: "sign-up"),
    AutoRoute(page: ForgotPasswordPage, path: "forgot-password"),
    AutoRoute(page: ChangePasswordPage, path: "change-password"),
    AutoRoute(page: MyDataPage, path: "my-data", initial: true),
    AutoRoute(page: ProfilePage, path: "profile"),
    AutoRoute(page: JobsPage, path: "jobs")
  ],
)
class $AppRouter {}
