import 'package:flutter/material.dart';
import 'package:send_form/model/dropdown_model.dart';

enum FieldType { Text, Dropdown, Checkbox }

class FieldModel {
  String? variableName, validatorErrorMessage, checkBoxText, fieldValue;
  FieldType? fieldType;
  InputDecoration? textFieldStyle;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  int? maxLines;
  bool? checkBoxValue;
  List<DropdownModel>? dropdownButtons;

  FieldModel(
      {required this.variableName,
      required this.fieldType,
      this.controller,
      this.validatorErrorMessage,
      this.textFieldStyle,
      this.textInputAction,
      this.maxLines,
      this.checkBoxText,
      this.checkBoxValue,
      this.fieldValue,
      this.dropdownButtons});

  FieldModel.fromJson(Map<String, dynamic> json) {
    variableName = json['variableName'];
    fieldType = json['fieldType'];
    controller = json['controller'];
    validatorErrorMessage = json['validatorErrorMessage'];
    textFieldStyle = json['textFieldStyle'];
    textInputAction = json['textInputAction'];
    maxLines = json['maxLines'];
    checkBoxText = json['checkBoxText'];
    checkBoxValue = json['checkBoxValue'];
    fieldValue = json['fieldValue'];
    dropdownButtons = json['dropdownButtons'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variableName'] = variableName;
    data['fieldType'] = fieldType;
    data['controller'] = controller;
    data['validatorErrorMessage'] = validatorErrorMessage;
    data['textFieldStyle'] = textFieldStyle;
    data['textInputAction'] = textInputAction;
    data['maxLines'] = maxLines;
    data['checkBoxText'] = checkBoxText;
    data['checkBoxValue'] = checkBoxValue;
    data['fieldValue'] = fieldValue;
    data['dropdownButtons'] = dropdownButtons;
    return data;
  }
}
