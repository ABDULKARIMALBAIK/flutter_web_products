import 'dart:math';

import 'package:Products/widgets/adaptive_widgets/adaptive_image.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_link.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_rich_text.dart';
import 'package:Products/widgets/adaptive_widgets/adaptive_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get_it/get_it.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:url_launcher/link.dart';

import '../utils/localization/app_localizations.dart';
import '../utils/resources_path.dart';
import '../utils/router/routers.dart';
import '../utils/urls.dart';
import '../view_model/login_view_model.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key) {
    // viewModel = GetIt.I.get<LoginViewModel>();
    viewModel = LoginViewModel();
  }

  late LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                //////////////////////// * Image  * ////////////////////////
                _imagePage(context),

                //////////////////////// * Login System  * ////////////////////////
                _widgetPages(context),
              ],
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
          width: 635,
          height: 635,
          altImage: 'Login Page image',
          srcImage: ResourcesPath.manageOrderImage,
          hint: 'Login Page image',
          label: 'Login Page image',
          value: 'Login Page image',
        ),
      ),
    );
  }

  _widgetPages(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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

              //////////////////////// * TextFields  * ////////////////////////
              _textFields(context),

              //////////////////////// * Button  * ////////////////////////
              _button(context),
              const SizedBox(
                height: 30,
              ),

              //////////////////////// * Register Link  * ////////////////////////
              _registerLink(context),
              const SizedBox(
                height: 40,
              ),

              //////////////////////// * privacy terms text  * ////////////////////////
              _privacyTermsLink(context),
            ],
          ),
        ),
      ),
    );
  }

  _title(BuildContext context) {
    return AdaptiveText(
      text: AppLocalizations.of(context)!.translate('login_header_title'),
      headerText: "Welcome Again",
      headerType: TextRendererStyle.header3,
      style: Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
      hint: "Welcome Again",
      label: "Welcome Again",
      value: "Welcome Again",
    );
  }

  _subtitle(BuildContext context) {
    return SizedBox(
      width: 600,
      child: AdaptiveText(
        text: AppLocalizations.of(context)!.translate('login_header_subtitle'),
        headerText:
            "We are happy because you are interesting for our services, Please Enter fill the fields",
        headerType: TextRendererStyle.header6,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w200),
        textAlign: TextAlign.center,
        maxLines: 3,
        hint:
            "We are happy because you are interesting for our services, Please Enter fill the fields",
        label:
            "We are happy because you are interesting for our services, Please Enter fill the fields",
        value:
            "We are happy because you are interesting for our services, Please Enter fill the fields",
      ),
    );
  }

  _textFields(BuildContext context) {
    return SizedBox(
      width: 450,
      child: AutofillGroup(
        child: Form(
          key: viewModel.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //////////////////////// * username  * ////////////////////////
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

              //////////////////////// * password  * ////////////////////////
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
              AppLocalizations.of(context)!
                  .translate('home_header_button_login'),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              await viewModel.loginUser(context);
            },
          ),
        ),
      ),
    );
  }

  _registerLink(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: AdaptiveText(
                text:
                    AppLocalizations.of(context)!.translate('login_new_member'),
                headerText: "New Member",
                headerType: TextRendererStyle.header3,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                hint: "New Member",
                label: "New Member",
                value: "New Member",
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Flexible(
              child: AdaptiveLink(
                link: Routers.registerRoute,
                linkText: 'go to register Page',
                target: LinkTarget.self,
                hint: 'go to register Page',
                label: 'go to register Page',
                value: 'go to register Page',
                widget: Text(
                  AppLocalizations.of(context)!.translate('login_register'),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  viewModel.goRegister(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _privacyTermsLink(BuildContext context) {
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

  LoginViewModel viewModel;

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
class PasswordTextField extends StatefulWidget {
  PasswordTextField(this.viewModel, {Key? key}) : super(key: key);

  bool isSecurePassword = true;
  LoginViewModel viewModel;

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
