import 'package:flutter/material.dart'
    show
        BuildContext,
        Scaffold,
        SafeArea,
        Widget,
        StatelessWidget,
        Key,
        Container,
        MediaQuery,
        Theme;
import '../utils/localization/app_localizations.dart' show AppLocalizations;
import '../utils/resources_path.dart';
import '../widgets/data_template.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DataTemplate().notFoundPage(
              context: context,
              text: AppLocalizations.of(context)!.translate('not_found_page'),
              style: Theme.of(context).textTheme.headline5,
              heightImage: 300,
              widthImage: 300,
              imageLinkAssets: ResourcesPath().notFoundPage),
        ),
      ),
    );
  }
}
