import 'dart:typed_data';

import 'package:Products/notifier/register_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
// import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/user_model.dart';
import '../repository/register_repository.dart';
import '../service/encryptor_service.dart';
import '../service/storage_service.dart';
import '../utils/constants.dart';
import '../utils/router/routers.dart';
import '../widgets/custom_dialog/custom_snack_bar.dart';
import '../widgets/custom_dialog/top_snack_bar.dart';

// @Injectable()
class RegisterViewModel {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late DropzoneViewController dropZoneViewController;
  late String phoneNumberController;
  late GlobalKey<FormState> registerFormKey;
  late ImagePickNotifier imagePickNotifier;
  late UpdateDropZoneNotifier updateDropZone;

  late RegisterRepository repository;
  late EncryptorService encryptor;
  late StorageService storageService;

  RegisterViewModel() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = '';
    registerFormKey = GlobalKey<FormState>();
    imagePickNotifier = ImagePickNotifier();
    updateDropZone = UpdateDropZoneNotifier();

    // repository = GetIt.I.get<RegisterRepository>();
    // encryptor = GetIt.I.get<EncryptorService>();
    // storageService = GetIt.I.get<StorageService>();

    repository = RegisterRepository();
    encryptor = DataHelper.encryptorService;
    storageService = DataHelper.storageService;
  }

  Future<void> registerUser(BuildContext context) async {
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
    //   final Response response = await repository.registerUser(usernameController.text, passwordController.text);
    //
    //   if(response.statusCode == 200 || response.statusCode == 201){
    //
    //
    //     User user = User.fromJson(response.data);
    //     User encryptedUser = await encryptUser(user);
    //
    //     //Encrypted Box
    //     saveUserDatabase(encryptedUser);
    //
    //     //Show custom dialog
    //     showTopSnackBar(
    //       context,
    //       CustomSnackBar.success(
    //         message:
    //         "Great job, Welcome ${usernameController.text} in Products Website",
    //       ),
    //     );
    //
    //
    //     //Go to Products
    //     await Future.delayed(const Duration(milliseconds: 3000));
    //     GoRouter.of(context).pushNamed(Routers.productsName);
    //   }
    //   else {
    //     //Show custom dialog
    //     showTopSnackBar(
    //       context,
    //       const CustomSnackBar.error(
    //         message:
    //         "Something went wrong. Please check your data and try again",
    //       ),
    //     );
    //
    //     debugPrint('DebugPrint:');
    //   }
    // }
    // catch(e){
    //   ErrorModel errorModel = ExceptionHandler().handle(e , message404: 'Account is not exists');
    //   debugPrint('errorLogin: code-${errorModel.code} , message-${errorModel.message}');
    //
    //   //Show custom dialog
    //   showTopSnackBar(
    //     context,
    //     const CustomSnackBar.error(
    //       message:
    //       "Something went wrong. Please check your data and try again",
    //     ),
    //   );
    // }
  }

  Future<User> encryptUser(User user) async {
    return User(
      id: int.parse(await encryptor.encryptMyMessage(user.id.toString())),
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

  Future<Uint8List?> pickImage(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }

      //Some times in android version crush because the file is save temporary, so use other approach
      // final imageTemporary = File(image.path);

      //Use this for ImagePicker
      final Uint8List bytesImage = await image.readAsBytes();
      debugPrint('imageBytes_${bytesImage.length}');

      //cropImage(context , bytesImage , '');
      imagePickNotifier.pickImageFile(bytesImage, '');
      return bytesImage;
    } on Exception catch (e) {
      debugPrint(
          'failed to pick image maybe because he maybe denied the permission : $e');
    }
    return null;
  }

  Future<void> dropZoneImage(BuildContext context, dynamic file) async {
    try {
      final name = file.name;
      final mime = await dropZoneViewController.getFileMIME(file);
      final bytes = await dropZoneViewController.getFileSize(file);
      final url = await dropZoneViewController.createFileUrl(file);
      final imageData = await dropZoneViewController.getFileData(file);

      debugPrint('DropZoneName: $name');
      debugPrint('DropZoneMime: $mime');
      debugPrint('DropZoneBytes: $bytes');
      debugPrint('DropZoneUrl: $url');

      //cropImage(context, imageData, url);
      imagePickNotifier.pickImageFile(imageData, url);
    } catch (e) {
      debugPrint('DropZoneError: ');
    }
  }

  void cropImage(BuildContext context, Uint8List bytesImage, String url) async {
    // ImageCropping.cropImage(
    //   context: context,
    //   imageBytes: bytesImage,
    //   onImageDoneListener: (croppedImage){
    //
    //     debugPrint('Done Editing');
    //     debugPrint('test_${croppedImage.length}');
    //     imagePickNotifier.pickImageFile(croppedImage, url);
    //     debugPrint('Done State Management: ${imagePickNotifier.isPicked}');
    //
    //
    //   },
    //   onImageEndLoading: () => debugPrint('End loading'),
    //   onImageStartLoading: () => debugPrint('Start loading'),
    //   selectedImageRatio: ImageRatio.RATIO_1_1,
    //   visibleOtherAspectRatios: true,
    //   squareBorderWidth: 2,
    //   squareCircleColor: Theme.of(context).primaryColor,
    //   defaultTextColor: Theme.of(context).textTheme.subtitle1!.color as Color,
    //   selectedTextColor: Theme.of(context).primaryColor,
    //   colorForWhiteSpace: Theme.of(context).scaffoldBackgroundColor,
    // );
  }

  void goProducts(BuildContext context) =>
      GoRouter.of(context).pushNamed(Routers.registerName);

  Future<void> launchLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    }
  }
}
