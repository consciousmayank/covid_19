
import 'history.dart';

class SelectedStateModel {
  bool isExpanded;
  String header;
  List<StatesModel> bodyModel;

  SelectedStateModel({this.isExpanded: false, this.header, this.bodyModel});
}

class StatesModel {
  final Regional singleState;

  StatesModel({this.singleState});
}