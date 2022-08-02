## Features

This package acts as a form builder.
It allows the data to be received from the elements of the form to be sent via HTTP POST. You need to provide a URL for this.

## Getting started

You need to create the elements of your form in a list of data model named Field Model.

For form validation, you should create a GlobalKey and send it to SendForm.

You can give FieldType.Text, FieldType.Checkbox and FieldType.Dropdown types to fieldType variable name in this form builder FieldModel.

When using dropdown, you need to define a list of DropdownModel with 'text' and 'value' keys in the dropdownButtons variable. The text key represents the label of the dropdown element, and the value key represents the data to be sent to the URL in the POST operation.

## Usage

```dart
GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController addressDescriptionController = TextEditingController();
  late List<FieldModel> fields = [
    FieldModel(
        fieldType: FieldType.Text,
        variableName: 'addressTitle',
        controller: addressTitleController,
        textInputAction: TextInputAction.next,
        validatorErrorMessage: 'Can\'t be empty.',
        textFieldStyle: const InputDecoration(
            labelText: 'Address Title', border: OutlineInputBorder())),
    FieldModel(
        fieldType: FieldType.Text,
        variableName: 'addressDescription',
        controller: addressDescriptionController,
        textInputAction: TextInputAction.next,
        validatorErrorMessage: 'Can\'t be empty.',
        textFieldStyle: const InputDecoration(
            labelText: 'Address Description', border: OutlineInputBorder())),
    FieldModel(
        fieldType: FieldType.Dropdown,
        variableName: 'city',
        textInputAction: TextInputAction.next,
        validatorErrorMessage: 'Can\'t be empty.',
        textFieldStyle: const InputDecoration(
            labelText: 'City', border: OutlineInputBorder()),
        dropdownButtons: [
          DropdownModel(
            text: 'Istanbul',
            value: 'istanbul',
          ),
          DropdownModel(
            text: 'London',
            value: 'london',
          ),
          DropdownModel(
            text: 'Berlin',
            value: 'berlin',
          ),
        ])
  ];

    @override
  Widget build(BuildContext context) {
    return SendForm(
      formKey: formKey,
      fields: fields,
      sendFormTitle: 'Address Add',
      sendFormButtonText: 'Save',
      sendFormAppBarColor: Colors.green,
      sendFormTitleStyle: const TextStyle(color: Colors.white),
      sendFormButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
      sendFormButtonTextStyle: const TextStyle(color: Colors.white),
      sendFormURL: 'YOUR URL',
      errorTitle: 'Warning',
      errorMessage: 'THIS MESSAGE WILL BE ERROR MODAL\'S CONTENT',
      token: 'YOUR URL\'S HEADER TOKEN',
      automaticallyImplyLeading: false,
      appBarLeading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context)),
    );
  }
```
