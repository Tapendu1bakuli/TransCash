/*
 * File name: phone_field_widget.dart
 * Last modified: 2022.02.04 at 14:21:01
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sizing/sizing.dart';

import '../device_manager/colors.dart';

class PhoneFieldWidget extends StatelessWidget {
  const PhoneFieldWidget(
      {Key? key,
      this.onSaved,
      this.onChanged,
      this.validator,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.labelText,
      this.obscureText = false,
      this.suffixIcon,
      this.style,
      this.textAlign,
      this.suffix,
      this.initialCountryCode,
      this.countries})
      : super(key: key);

  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<PhoneNumber>? onChanged;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final bool obscureText;
  final String? initialCountryCode;
  final List<String>? countries;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText ?? "",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: textAlign ?? TextAlign.start,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: IntlPhoneField(
              key: key,
              onSaved: onSaved,
              onChanged: onChanged,
              validator: validator,
              initialValue: initialValue ?? '',
              initialCountryCode: initialCountryCode ?? 'IN',
              showDropdownIcon: false,
              pickerDialogStyle: PickerDialogStyle(
                countryCodeStyle: Theme.of(context).textTheme.displaySmall,
                  searchFieldCursorColor: Theme.of(context).indicatorColor,
                  countryNameStyle: Theme.of(context).textTheme.displaySmall,
                  //backgroundColor: Theme.of(context).backgroundColor,
                  searchFieldInputDecoration: InputDecoration(
                      labelText: "Search country",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 15.fss),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).indicatorColor,
                      ))),
              style: style ?? Theme.of(context).textTheme.displaySmall,
              textAlign: textAlign ?? TextAlign.start,
              disableLengthCheck: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                filled: true,
                //fillColor: Theme.of(context).backgroundColor,
                hintText: hintText ?? '',
                hintStyle: Get.textTheme.bodySmall,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: suffixIcon,
                suffix: suffix,
                errorText: errorText,
              )),
        ),
      ],
    );
  }
}

PhoneNumber getPhoneNumber(String phoneNumber) {
  if (phoneNumber != null && phoneNumber.isNotEmpty) {
    phoneNumber = phoneNumber.replaceAll(' ', '');
    String? dialCode1;
    String? dialCode2;
    String? dialCode3;
    if (phoneNumber.length >= 2) {
      dialCode1 = phoneNumber.substring(1, 2);
    }
    if (phoneNumber.length >= 3) {
      dialCode2 = phoneNumber.substring(1, 3);
    }
    if (phoneNumber.length >= 4) {
      dialCode3 = phoneNumber.substring(1, 4);
    }
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].dialCode == dialCode1) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode1!,
            number: phoneNumber.substring(2));
      } else if (countries[i].dialCode == dialCode2) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode2!,
            number: phoneNumber.substring(3));
      } else if (countries[i].dialCode == dialCode3) {
        return PhoneNumber(
            countryISOCode: countries[i].code,
            countryCode: dialCode3!,
            number: phoneNumber.substring(4));
      }
    }
  }
  return new PhoneNumber(countryISOCode: "US", countryCode: '1', number: '');
}
