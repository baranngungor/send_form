import 'package:send_form/send_form.dart';
import 'package:flutter/material.dart';

class SendForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<FieldModel> fields;
  final String sendFormTitle,
      sendFormButtonText,
      sendFormURL,
      token,
      errorTitle,
      errorMessage;
  final TextStyle? sendFormTitleStyle, sendFormButtonTextStyle;
  final Color sendFormAppBarColor;
  final ButtonStyle sendFormButtonStyle;
  final bool automaticallyImplyLeading;
  final Widget? appBarLeading;
  const SendForm(
      {Key? key,
      required this.formKey,
      required this.fields,
      required this.sendFormTitle,
      required this.sendFormButtonText,
      required this.sendFormAppBarColor,
      required this.sendFormButtonStyle,
      required this.sendFormURL,
      required this.token,
      required this.errorTitle,
      required this.errorMessage,
      this.sendFormTitleStyle,
      this.sendFormButtonTextStyle,
      this.appBarLeading,
      this.automaticallyImplyLeading = true})
      : super(key: key);

  SizedBox verticalSpace(double height) => SizedBox(height: height);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            leading: appBarLeading,
            backgroundColor: sendFormAppBarColor,
            title: Text(sendFormTitle, style: sendFormTitleStyle)),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  Flexible(
                      child: ListView.separated(
                    itemCount: fields.length,
                    itemBuilder: (context, index) {
                      final fieldData = fields[index];
                      switch (fieldData.fieldType) {
                        case 'text':
                          return Column(
                            children: [
                              TextFormField(
                                decoration: fieldData.textFieldStyle,
                                controller: fieldData.controller,
                                textInputAction: fieldData.textInputAction,
                                maxLines: fieldData.maxLines ?? 1,
                                onChanged: (value) {
                                  fieldData.fieldValue = value;
                                },
                                validator: (value) {
                                  return value == null ||
                                          value.toString().trim().length == 0
                                      ? fieldData.validatorErrorMessage
                                      : null;
                                },
                              ),
                              if (fields.length == index + 1)
                                buildSendButton(context)
                            ],
                          );
                        case 'checkBox':
                          return Column(
                            children: [
                              CheckboxListTile(
                                title: Text(fieldData.checkBoxText ?? ''),
                                value: fieldData.checkBoxValue,
                                onChanged: (value) {
                                  fieldData.checkBoxValue = value;
                                },
                              ),
                              if (fields.length == index + 1)
                                buildSendButton(context)
                            ],
                          );
                        case 'dropDown':
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                  decoration: fieldData.textFieldStyle,
                                  isExpanded: true,
                                  items: List.generate(
                                      fieldData.dropdownButtons!.length,
                                      (index) => DropdownMenuItem(
                                            value: fieldData
                                                    .dropdownButtons![index]
                                                ['value'],
                                            child: Text(fieldData
                                                    .dropdownButtons![index]
                                                ['text']),
                                          )),
                                  validator: (value) {
                                    return value == null ||
                                            value.toString().trim().length == 0
                                        ? fieldData.validatorErrorMessage
                                        : null;
                                  },
                                  onChanged: (value) {
                                    fieldData.fieldValue = value.toString();
                                  }),
                              if (fields.length == index + 1)
                                buildSendButton(context)
                            ],
                          );
                        default:
                          return Container();
                      }
                    },
                    separatorBuilder: (context, index) => verticalSpace(10),
                  )),
                ],
              )),
        ));
  }

  Widget buildSendButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          var data = {};
          for (var i = 0; i < fields.length; i++) {
            data[fields[i].variableName.toString()] = fields[i].fieldValue;
          }
          await SendFormController().sendFormCall(
              context, sendFormURL, data, token, errorTitle, errorMessage);
        }
      },
      style: sendFormButtonStyle,
      child: Text(sendFormButtonText, style: sendFormButtonTextStyle),
    );
  }
}
