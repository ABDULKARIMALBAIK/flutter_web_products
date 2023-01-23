import 'dart:math';

import 'package:Products/widgets/adaptive_widgets/adaptive_image.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_link.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_rich_text.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:url_launcher/link.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../notifier/register_notifier.dart';
import '../utils/constants.dart';
import '../utils/localization/app_localizations.dart';
import '../utils/resources_path.dart';
import '../utils/router/routers.dart';
import '../utils/urls.dart';
import '../view_model/register_view_model.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key) {
    // viewModel = GetIt.I.get<RegisterViewModel>();
    viewModel = RegisterViewModel();
  }

  late RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<ImagePickNotifier>(create: (context) => viewModel.imagePickNotifier),
        ChangeNotifierProvider<UpdateDropZoneNotifier>(
            create: (context) => viewModel.updateDropZone),
      ],
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //////////////////////// * Login System  * ////////////////////////
                  _dataPage(context),

                  //////////////////////// * Image  * ////////////////////////
                  _imagePage(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _imagePage(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: AdaptiveImage(
          key: UniqueKey(),
          imageName: 'image${Random().nextInt(100000)}',
          width: 690,
          height: 690,
          altImage: 'Register Page image',
          srcImage: ResourcesPath.productCatalogueImage,
          hint: 'Register Page image',
          label: 'Register Page image',
          value: 'Register Page image',
        ),
      ),
    );
  }

  _dataPage(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //////////////////////// * Title * ////////////////////////
              const SizedBox(
                height: 15,
              ),
              _title(context),
              const SizedBox(
                height: 10,
              ),

              //////////////////////// * Subtitle * ////////////////////////
              _subtitle(context),
              const SizedBox(
                height: 40,
              ),

              //////////////////////// * ImageUser * ////////////////////////
              _userImage(context),

              //////////////////////// * All Remained Elements  * ////////////////////////
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //////////////////////// * TextFields  * ////////////////////////
                    _textFields(context),

                    //////////////////////// * Button  * ////////////////////////
                    _button(context),
                    const SizedBox(
                      height: 40,
                    ),

                    //////////////////////// * privacy terms text  * ////////////////////////
                    _termsPrivacy(context),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _title(BuildContext context) {
    return AdaptiveText(
      text: AppLocalizations.of(context)!.translate('register_header_title'),
      headerText: "Join to us",
      headerType: TextRendererStyle.header3,
      style: Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
      hint: "Join to us",
      label: "Join to us",
      value: "Join to us",
    );
  }

  _subtitle(BuildContext context) {
    return AdaptiveText(
      text: AppLocalizations.of(context)!.translate('register_header_subtitle'),
      headerText:
          "You enjoy with us by register your data and become a member and take some benefits, Please fill the fields :",
      headerType: TextRendererStyle.header6,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w200),
      textAlign: TextAlign.start,
      maxLines: 3,
      hint:
          "You enjoy with us by register your data and become a member and take some benefits, Please fill the fields :",
      label:
          "You enjoy with us by register your data and become a member and take some benefits, Please fill the fields :",
      value:
          "You enjoy with us by register your data and become a member and take some benefits, Please fill the fields :",
    );
  }

  _userImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: ChangeNotifierProvider<ImagePickNotifier>(
        create: (context) => viewModel.imagePickNotifier,
        builder: (context, child) {
          return Consumer<ImagePickNotifier>(
              builder: (context, pickImage, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //////////////////////// * ImageUser * ////////////////////////
                WidgetCircularAnimator(
                  innerColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  outerColor: Theme.of(context).primaryColor,
                  // size: ,  //Default is 200
                  // outerAnimation: ,  //Default is Curve.linear
                  // innerAnimation: ,  //Default is Curve.linear
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor),
                      child: pickImage.isPicked
                          ? ClipOval(
                              child: Image.memory(pickImage.pickedImage!,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover),
                            )
                          : Center(
                              child: FaIcon(
                                FontAwesomeIcons.person,
                                color: Theme.of(context).primaryColor,
                                size: 60,
                              ),
                            )),
                ),
                const SizedBox(
                  height: 20,
                ),

                //////////////////////// * Image Picker * ////////////////////////
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shadowColor: Theme.of(context).primaryColor,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () async {
                    final image = await viewModel.pickImage(context);
                    pickImage.pickImageFile(image!, '');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        AppLocalizations.of(context)!
                            .translate('login_pick_image_gallery'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                //////////////////////// * DropZone * ////////////////////////
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Consumer<UpdateDropZoneNotifier>(
                      builder: (context, dropZone, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 460,
                        height: 320,
                        padding: const EdgeInsets.all(10),
                        color: dropZone.isHover
                            ? (DataHelper.isDark
                                ? Colors.green[300]
                                : Colors.green[500])
                            : (DataHelper.isDark
                                ? Colors.red[300]
                                : Colors.red[500]),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          color: Colors.white,
                          strokeWidth: 3,
                          padding: EdgeInsets.zero,
                          dashPattern: const [8, 4],
                          radius: const Radius.circular(10),
                          child: Stack(
                            children: [
                              //Drop widget
                              SizedBox(
                                width: 460,
                                height: 320,
                                child: DropzoneView(
                                  operation: DragOperation.copy,
                                  cursor: CursorType.Default,
                                  onError: (String? s) =>
                                      debugPrint('error happened !!!!\n $s'),
                                  onHover: () => viewModel.updateDropZone
                                      .changeState(true),
                                  onLeave: () => viewModel.updateDropZone
                                      .changeState(false),
                                  onLoaded: () => viewModel.updateDropZone
                                      .changeState(false),
                                  onCreated: (controller) => viewModel
                                      .dropZoneViewController = controller,
                                  onDrop: (dynamic file) async {
                                    await viewModel.dropZoneImage(
                                        context, file);
                                    viewModel.updateDropZone.changeState(false);
                                  },
                                ),
                              ),

                              //Upload image and text
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.upload,
                                        color: Colors.white, size: 80),
                                    const SizedBox(height: 8),
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                          'signUp_text_drop_upload_image'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            );
          });
        },
      )),
    );
  }

  _textFields(BuildContext context) {
    return SizedBox(
      width: 450,
      child: AutofillGroup(
        child: Form(
          key: viewModel.registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //////////////////////// * Username  * ////////////////////////
              Semantics(
                child: UsernameTextField(viewModel),
                hint: 'Username Text Field',
                label: 'Username Text Field',
                value: 'Username Text Field',
                textField: true,
                selected: true,
              ),
              const SizedBox(
                height: 20,
              ),

              //////////////////////// * Email  * ////////////////////////
              Semantics(
                child: EmailTextField(viewModel),
                hint: 'Email Text Field',
                label: 'Email Text Field',
                value: 'Email Text Field',
                textField: true,
                selected: true,
              ),
              const SizedBox(
                height: 20,
              ),

              //////////////////////// * Password  * ////////////////////////
              Semantics(
                child: PasswordTextField(viewModel),
                hint: 'password Text Field',
                label: 'password Text Field',
                value: 'password Text Field',
                textField: true,
                selected: true,
              ),
              const SizedBox(
                height: 20,
              ),

              //////////////////////// * PhoneNumber  * ////////////////////////
              Semantics(
                child: PhoneNumberTextField(viewModel),
                hint: 'Phone Number Text Field',
                label: 'Phone Number Text Field',
                value: 'Phone Number Text Field',
                textField: true,
                selected: true,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _button(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Center(
        child: AdaptiveLink(
          link: Routers.productsRoute,
          linkText: 'button link to Product Page',
          target: LinkTarget.self,
          hint: 'button link to Product Page',
          label: 'button link to Product Page',
          value: 'button link to Product Page',
          widget: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(25),
              primary: Theme.of(context).primaryColor,
              shadowColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
            ),
            child: Text(
              AppLocalizations.of(context)!.translate('register_header_button'),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              // Post data
            },
          ),
        ),
      ),
    );
  }

  _termsPrivacy(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Center(
          child: AdaptiveRichText(
        textSpanChildren: [
          TextSpan(
              text: AppLocalizations.of(context)!
                  .translate('login_header_accept'),
              style: Theme.of(context).textTheme.caption!),
          TextSpan(
            text:
                AppLocalizations.of(context)!.translate('home_footer_privacy'),
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).primaryColor),
            mouseCursor: SystemMouseCursors.click,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //Here launch link to html
                viewModel.launchLink(ConstUrls.privacyPolicy);
              },
          ),
          TextSpan(
              text: AppLocalizations.of(context)!.translate('login_and'),
              style: Theme.of(context).textTheme.caption!),
          TextSpan(
            text: AppLocalizations.of(context)!.translate('home_terms_service'),
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).primaryColor),
            mouseCursor: SystemMouseCursors.click,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                //Here launch link to html
                viewModel.launchLink(ConstUrls.termsService);
              },
          ),
          TextSpan(
              text: AppLocalizations.of(context)!.translate('login_for_that'),
              style: Theme.of(context).textTheme.caption!),
        ],
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
        headerText: 'Accepting Privacy Policy - Terms of Service',
        headerType: TextRendererStyle.paragraph,
        label: 'Accepting Privacy Policy - Terms of Service',
        hint: 'Accepting Privacy Policy - Terms of Service',
        value: 'Accepting Privacy Policy - Terms of Service',
      )),
    );
  }
}

// ignore: must_be_immutable
class UsernameTextField extends StatelessWidget {
  UsernameTextField(this.viewModel, {Key? key}) : super(key: key);

  RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          width: 450,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextFormField(
            enableSuggestions: true,
            readOnly: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            maxLines: 1,
            autofocus: false,
            autocorrect: true,
            cursorColor: Theme.of(context).primaryColor,
            controller: viewModel.usernameController,
            autofillHints: const [AutofillHints.username],
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!
                  .translate('login_username_textField_hint'),
              errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
              icon: FaIcon(
                FontAwesomeIcons.person,
                color: Theme.of(context).primaryColor,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'Please fill username field';
              }
              return null;
            },
          )),
    );
  }
}

// ignore: must_be_immutable
class EmailTextField extends StatelessWidget {
  EmailTextField(this.viewModel, {Key? key}) : super(key: key);

  RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
          width: 450,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextFormField(
            enableSuggestions: true,
            readOnly: false,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            autofocus: false,
            autocorrect: true,
            cursorColor: Theme.of(context).primaryColor,
            controller: viewModel.emailController,
            autofillHints: const [AutofillHints.email],
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!
                  .translate('register_email_textField_hint'),
              errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
              icon: FaIcon(
                FontAwesomeIcons.envelope,
                color: Theme.of(context).primaryColor,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return 'Please fill username field';
              }
              return null;
            },
          )),
    );
  }
}

// ignore: must_be_immutable
class PhoneNumberTextField extends StatelessWidget {
  PhoneNumberTextField(this.viewModel, {Key? key}) : super(key: key);

  RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        width: 450,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: IntlPhoneField(
          readOnly: false,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          autofocus: false,
          cursorColor: Theme.of(context).primaryColor,
          controller: viewModel.emailController,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!
                .translate('register_phone_textField_hint'),
            errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200),
            icon: FaIcon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).primaryColor,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) {
            debugPrint('number_${phone.number}');
            debugPrint('countryCode_${phone.countryCode}');
            debugPrint('countryISOCode_${phone.countryISOCode}');

            viewModel.phoneNumberController = phone.completeNumber;
          },
        ),
        // child: TextFormField(
        //   enableSuggestions: true,
        //   readOnly: false,
        //   textInputAction: TextInputAction.next,
        //   keyboardType: TextInputType.emailAddress,
        //   maxLines: 1,
        //   autofocus: false,
        //   autocorrect: true,
        //   cursorColor: Theme.of(context).primaryColor,
        //   controller: viewModel.emailController,
        //   autofillHints: const [AutofillHints.email],
        //   style: Theme.of(context).textTheme.bodyText1,
        //   decoration: InputDecoration(
        //     hintText: AppLocalizations.of(context)!.translate('login_email_textField_hint'),
        //     errorStyle: const TextStyle(
        //         color: Colors.red,
        //         fontSize: 10,
        //         fontStyle: FontStyle.italic,
        //         fontWeight: FontWeight.w200),
        //     icon: FaIcon(
        //       FontAwesomeIcons.envelope,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     border: InputBorder.none,
        //     focusedBorder: InputBorder.none,
        //     enabledBorder: InputBorder.none,
        //     floatingLabelBehavior: FloatingLabelBehavior.never,
        //   ),
        //   validator: (email) {
        //     if (email == null || email.isEmpty) {
        //       return 'Please fill username field';
        //     }
        //     return null;
        //   },
        // )
      ),
    );
  }
}

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  PasswordTextField(this.viewModel, {Key? key}) : super(key: key);

  bool isSecurePassword = true;
  RegisterViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        width: 450,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(29),
        ),
        child: TextFormField(
          autofillHints: const [AutofillHints.password],
          controller: widget.viewModel.passwordController,
          obscureText: widget.isSecurePassword,
          autocorrect: true,
          enableSuggestions: true,
          readOnly: false,
          textInputAction: TextInputAction.done,
          cursorColor: Theme.of(context).primaryColor,
          style: Theme.of(context).textTheme.subtitle1,
          onEditingComplete: () => TextInput.finishAutofillContext(),
          decoration: InputDecoration(
            icon: FaIcon(
              FontAwesomeIcons.key,
              color: Theme.of(context).primaryColor,
            ),
            suffix: GestureDetector(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: FaIcon(
                  widget.isSecurePassword
                      ? FontAwesomeIcons.eye //Icons.visibility
                      : FontAwesomeIcons.eyeSlash,
                  color: Theme.of(context).primaryColor,
                ),
              ), //Icons.visibility_off,
              onTap: () {
                widget.isSecurePassword = !widget.isSecurePassword;
                setState(() {});
              },
            ),
            hintStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .color!
                    .withOpacity(0.5)),
            errorStyle: const TextStyle(
                color: Colors.red,
                fontSize: 10,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never, //always
            hintText: AppLocalizations.of(context)!
                .translate('login_password_textField_hint'),
          ),
          keyboardType: TextInputType.text,
          validator: (password) {
            if (password == null || password.isEmpty) {
              return 'Please fill password field';
            }
            return null;
          },
        ),
      ),
    );
  }
}
