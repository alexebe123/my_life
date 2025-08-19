import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => ApiServiceFirebase.instance,
    lazy: false,
  ),
  
];
