import 'package:Products/model/user_model.dart';
import 'package:Products/repository/login_repository.dart';
import 'package:Products/service/storage_service.dart';
import 'package:Products/utils/router/routers.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
// import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/encryptor_service.dart';
import '../utils/constants.dart';
import '../widgets/custom_dialog/custom_snack_bar.dart';
import '../widgets/custom_dialog/top_snack_bar.dart';

// @Injectable()
class LoginViewModel {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> loginFormKey;

  late LoginRepository repository;
  late EncryptorService encryptor;
  late StorageService storageService;

  LoginViewModel() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    loginFormKey = GlobalKey<FormState>();

    // repository = GetIt.I.get<LoginRepository>();
    repository = LoginRepository();
    // encryptor = GetIt.I.get<EncryptorService>();
    encryptor = DataHelper.encryptorService;
    // storageService = GetIt.I.get<StorageService>();
    storageService = DataHelper.storageService;
  }

  Future<void> loginUser(BuildContext context) async {
    final json = {
      "id": 15,
      "username": "kminchelle",
      "email": "kminchelle@qq.com",
      "firstName": "Jeanne",
      "lastName": "Halvorson",
      "gender": "female",
      "image": "https://robohash.org/autquiaut.png?size=50x50&set=set1",
      "token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvYXV0cXVpYXV0LnBuZz9zaXplPTUweDUwJnNldD1zZXQxIiwiaWF0IjoxNjM1NzczOTYyLCJleHAiOjE2MzU3Nzc1NjJ9.n9PQX8w8ocKo0dMCw3g8bKhjB8Wo7f7IONFBDqfxKhs"
    };

    User user = User.fromJson(json);
    User encryptedUser = await encryptUser(user);

    //Encrypted Box
    saveUserDatabase(encryptedUser);

    //Show custom dialog
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message:
            "Great job, Welcome ${usernameController.text} in Products Website",
      ),
    );

    //Go to Products
    await Future.delayed(const Duration(milliseconds: 3000));
    GoRouter.of(context).pushNamed(Routers.productsName);

    ////////// Auth User api is stopped so , using current response
    // try{
    //    final Response response = await repository.loginUser(usernameController.text.toString(), passwordController.text.toString());
    //
    //    if(response.statusCode == 200 || response.statusCode == 201){
    //
    //      User user = User.fromJson(response.data);
    //      User encryptedUser = await encryptUser(user);
    //
    //      //Encrypted Box
    //      saveUserDatabase(encryptedUser);
    //
    //
    //      //Show custom dialog
    //      showTopSnackBar(
    //        context,
    //        CustomSnackBar.success(
    //          message:
    //          "Great job, Welcome ${usernameController.text} in Products Website",
    //        ),
    //      );
    //
    //
    //      //Go to Products
    //      await Future.delayed(const Duration(milliseconds: 3000));
    //      GoRouter.of(context).pushNamed(Routers.productsName);
    //
    //    }
    //    else {
    //      debugPrint('DebugPrint:');
    //
    //      //Show custom dialog
    //      showTopSnackBar(
    //        context,
    //        const CustomSnackBar.error(
    //          message:
    //          "Something is wrong  , check your request one more time",
    //        ),
    //      );
    //    }
    // }
    // catch(e){
    //   ErrorModel errorModel = ExceptionHandler().handle(e , message404: 'Account is not exists');
    //   debugPrint('errorLogin: code-${errorModel.code} , message-${errorModel.message}');
    //   debugPrint('check_error_$e}');
    //
    //   //Show custom dialog
    //   showTopSnackBar(
    //     context,
    //     const CustomSnackBar.error(
    //       message:
    //       "Something is wrong  , check your request one more time",
    //     ),
    //   );
    // }
  }

  Future<User> encryptUser(User user) async {
    return User(
      id: user.id,
      username: await encryptor.encryptMyMessage(user.username),
      email: await encryptor.encryptMyMessage(user.email),
      firstName: await encryptor.encryptMyMessage(user.firstName),
      lastName: await encryptor.encryptMyMessage(user.lastName),
      gender: await encryptor.encryptMyMessage(user.gender),
      image: await encryptor.encryptMyMessage(user.image),
      token: await encryptor.encryptMyMessage(user.token),
    );
  }

  void saveUserDatabase(User encryptedUser) {
    User? checkUser = storageService.userStorage.getUser();

    if (checkUser == null) {
      debugPrint('user is not exists => save new one');
      storageService.userStorage.saveUser(encryptedUser);
    } else {
      debugPrint('user is exists => do not do any thing');
    }
  }

  void goRegister(BuildContext context) =>
      GoRouter.of(context).pushNamed(Routers.registerName);

  Future<void> launchLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    }
  }
}
