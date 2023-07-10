

import 'utils/export_files.dart';
import 'helper/get_di.dart' as di;

void main() async {
  setPathUrlStrategy();
  await dotenv.load(
    fileName: Environment.fileName,
  );

  await di.init();

  if (kDebugMode) {
    print(Environment.baseUrl);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme: ThemeData.light(),
      initialRoute: RouteHelper.getSplashRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
    );
  }
}
