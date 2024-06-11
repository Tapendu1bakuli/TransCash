import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../device_manager/colors.dart';
import '../device_manager/screen_constants.dart';
import '../device_manager/strings.dart';
import '../device_manager/text_styles.dart';
import 'phone_field_widget.dart';

enum Type {
  passWord,
  name,
  phone,
  phoneWithPrefix,
  email,
  otp,
  amount,
  search,
  message
}

// ignore: must_be_immutable
class RequireTextField extends StatefulWidget {
  final Function()? onChanged;
  final TextEditingController controller;
  final Type type;
  final caption;
  var errorFree;
  final FocusNode? myFocusNode;
  final hintText;
  final prefixText;
  final mobileNumber;
  final readWriteStatus;
  final onTap;
  final labelText;
  final autoValidate;
  final autoSubmit;
  final verified;
  final suggestions;
  final autoKey;
  final isPast;
  final double? boxHeight;
  final double? boxWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isReadOnly;
  final bool showDecoration;
  final bool showDecorationForCall;
  final validationFunction;

  RequireTextField({
    Key? key,
    required this.type,
    required this.controller,
    this.onChanged,
    this.prefixText,
    this.caption,
    this.errorFree,
    this.myFocusNode,
    this.hintText,
    this.mobileNumber,
    this.readWriteStatus,
    this.onTap,
    this.labelText,
    this.autoValidate,
    this.autoSubmit,
    this.verified = false,
    this.suggestions,
    this.autoKey,
    this.isPast = false,
    this.boxHeight,
    this.boxWidth,
    this.suffixIcon,
    this.prefixIcon,
    this.validationFunction,
    this.isReadOnly = false,
    this.showDecoration = false,
    this.showDecorationForCall = false,
  }) : super(key: key);

  @override
  _RequireTextFieldState createState() => _RequireTextFieldState();
}

class _RequireTextFieldState extends State<RequireTextField> {
  late TextEditingController _controller;
  late Type type;

  var _value;

  bool _errorFree = true;

  bool validate = false;

  get errorFree => _errorFree;

  Type get _type => widget.type;
  var searchTextField;

  TextEditingController get _thisController => widget.controller;
  late GlobalKey<NavigatorState> navigatorKey;
  bool indicator = true;

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey<NavigatorState>();
    if (widget.controller == null) {
      _controller = TextEditingController(text: '');
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    if (widget.mobileNumber != null) {
      _thisController.text = widget.mobileNumber;
    }
  }

  void _handleControllerChanged() {
    if (_thisController.text != _value || _value.trim().isNotEmpty)
      didChange(_thisController.text);
  }

  void didChange(var value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void didUpdateWidget(RequireTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleControllerChanged);
      widget.controller.addListener(_handleControllerChanged);

      if (widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      }
      _thisController.text = widget.controller.text;
      if (oldWidget.controller == null) _controller;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case Type.passWord:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: indicator,
            obscuringCharacter: '●',
            style: Theme.of(context).textTheme.displaySmall,
            decoration: InputDecoration(
              filled: true,
                suffixIcon: InkWell(
                  onTap: toggle,
                  child: Icon(
                    indicator ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
                fillColor: Theme.of(context).dialogBackgroundColor,
                hintStyle: Theme.of(context).textTheme.displaySmall,
                hintText: widget.hintText,
                labelText: widget.labelText,
                labelStyle: Theme.of(context).textTheme.displaySmall,
                errorText: validatePassword),
          );
        }

      case Type.phone:
        {
          return widget.isReadOnly
              ? Stack(
                  children: <Widget>[
                    PhoneFieldWidget(
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      initialValue: getPhoneNumber(_thisController.text).number,
                      onSaved: (phone) {
                        _thisController.text = phone!.completeNumber;
                      },
                      validator: (input) =>
                          !GetUtils.isPhoneNumber(input!.completeNumber)
                              ? "Should be a valid phone".tr
                              : null,
                    ),
                    Container(
                      height: ScreenConstant.screenHeightEleven,
                      color: Colors.transparent,
                    ),
                  ],
                )
              : PhoneFieldWidget(
            style: Theme.of(context).textTheme.displaySmall,
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  initialCountryCode: getPhoneNumber(_thisController.text).number,
                  initialValue: getPhoneNumber(_thisController.text).number,
                  onSaved: (phone) {
                    _thisController.text = phone!.completeNumber;
                  },
                  validator: (input) =>
                      !GetUtils.isPhoneNumber(input!.completeNumber)
                          ? "Should be a valid phone".tr
                          : null,
                );
        }

      case Type.name:
        {
          return TextFormField(
            readOnly: widget.isReadOnly,
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
                suffixIcon: GetUtils.isAlphabetOnly(_thisController.text)
                    ? const Icon(
                        Icons.check,
                        color: AppColors.primaryColorDash,
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).dialogBackgroundColor,
                hintStyle: Theme.of(context).textTheme.labelSmall,
                hintText: widget.hintText,
                labelText: widget.labelText,
                labelStyle: Theme.of(context).textTheme.labelSmall,
                errorText: validateName),
          );
        }

      case Type.phoneWithPrefix:
        {
          return TextFormField(
            readOnly: widget.isReadOnly,
            controller: _thisController,
            keyboardType: TextInputType.phone,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).dialogBackgroundColor,
              prefixText: widget.prefixText,
              hintStyle: Theme.of(context).textTheme.labelSmall,
              hintText: AppLabels.mobileNumberHintText.tr,
              labelText: AppLabels.mobileNumber.tr,
              labelStyle: Theme.of(context).textTheme.labelSmall,
            ),
          );
        }

      case Type.email:
        {
          return TextFormField(
            readOnly: widget.isReadOnly,
            controller: _thisController,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: Theme.of(context).textTheme.labelSmall,
            decoration: InputDecoration(
                suffixIcon: GetUtils.isEmail(_thisController.text)
                    ? const Icon(
                        Icons.check,
                        color: AppColors.primaryColorDash,
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).dialogBackgroundColor,
                hintStyle: Theme.of(context).textTheme.labelSmall,
                hintText: widget.hintText,
                labelText: widget.labelText,
                labelStyle: Theme.of(context).textTheme.labelSmall,
                errorText: validateEmail),
          );
        }

      case Type.otp:
        {
          return BoxEntryTextField(
            textColor: Theme.of(context).indicatorColor,
            cursorColor: AppColors.completedButtonColor,
            showFieldAsBox: false,
            boxColor: Theme.of(context).indicatorColor,
            boxHeight: widget.boxHeight ?? ScreenConstant.sizeXXXL,
            boxWidth: widget.boxWidth ?? ScreenConstant.sizeXXXL,
            onSubmit: (String pin) {
              setState(() {
                _thisController.text = pin;
              });
            }, // end onSubmit
          );
        }

      case Type.amount:
        {
          return TextFormField(
            style: Theme.of(context).textTheme.labelSmall,
            //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
            controller: _thisController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Color(0xFFD0D0D0),
                ),
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.labelSmall,
              fillColor: Theme.of(context).dialogBackgroundColor,
              errorText: validateAmount
            ),
          );
        }

      case Type.search:
        {
          return TextFormField(
            onChanged: (String value){
              widget.onChanged!();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: AppColors.appPrimaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: AppColors.appPrimaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: AppColors.appPrimaryColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(
                  color: AppColors.appPrimaryColor,
                ),
              ),
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              hintStyle: TextStyles.searchHint,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryIconColor,
                size: ScreenConstant.texIconSize,
              ),
              hintText: widget.hintText,
              fillColor: AppColors.appCommonBGColor,
            ),
          );
        }
      case Type.message:
        {}
        return TextFormField(
          style: Theme.of(context).textTheme.displaySmall,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(10),
            hintStyle: Theme.of(context).textTheme.displaySmall,
            hintText: widget.hintText,
            fillColor: Theme.of(context).dialogBackgroundColor,
          ),
        );
      default:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.smallHintText,
            decoration: InputDecoration(
              hintStyle: TextStyles.lowerSubTitle,
              hintText: widget.hintText,
            ),
          );
        }
    }
  }

  void toggle() {
    setState(() {
      indicator = !indicator;
    });
  }

  String? get validateEmail {
    final text = _thisController.value.text;
    if (text.isEmpty) {
      return null;
    }
    if (GetUtils.isEmail(text)) {
      return null;
    } else {
      return AppLabels.validateEmail.tr;
    }
  }

  String? get validatePhone {
    final text = _thisController.value.text;
    if (text.isEmpty) {
      return null;
    }
    if (GetUtils.isPhoneNumber(text)) {
      return null;
    } else {
      return AppLabels.validatePhone.tr;
    }
    // return null if the text is valid
    return null;
  }

  String? get validatePassword {
    final value = _thisController.value.text;
    String pattern =
        r"(^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&.*':;â‚¬#])[A-Za-z\d@$!%*?&.*':;â‚¬#]{8,}$)";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return null;
    } else if (value.length < 8) {
      return AppLabels.validateEmailOrPassword.tr;
    }
    return null;
  }

  String? get validateAmount {
    final value = _thisController.value.text;
    if(value.isEmpty){
      return null;
    }else if(GetUtils.isNum(value) && double.parse(value)<1){
      return AppLabels.amountRequired.tr;
    }
  }

  String? get validateName {
    final value = _thisController.value.text;
    if (value.isEmpty) {
      return null;
    } else if (value.length < 3) {
      return AppLabels.nameRequired.tr;
    }
    return null;
  }
}

class BoxEntryTextField extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final ValueChanged<String> onSubmit;
  final double fieldWidth;
  final double fontSize;
  final bool isTextObscure;
  final bool showFieldAsBox;
  final Color
      cursorColor; // Leaving the data type dynamic for adding Color or Material Color
  final Color boxColor;
  final Color textColor;
  final Color fillColor;
  final double? boxHeight;
  final double? boxWidth;

  const BoxEntryTextField({
    Key? key,
    this.lastPin,
    this.fields = 4,
    required this.onSubmit,
    this.fieldWidth = 40.0,
    this.fontSize = 20.0,
    this.isTextObscure = false,
    this.showFieldAsBox = true,
    this.cursorColor = AppColors
        .white, // Adding a Material Color so that if the user want black, it get accepted too
    this.boxColor = AppColors.white,
    this.textColor = AppColors.titleBlack,
    this.fillColor = AppColors.textBoxColor,
    this.boxHeight,
    this.boxWidth,
  }) : super(key: key);

  @override
  State createState() {
    return BoxEntryTextFieldState();
  }
}

class BoxEntryTextFieldState extends State<BoxEntryTextField> {
  final List<String> _pin = <String>[];
  final List<FocusNode> _focusNodes = <FocusNode>[];
  final List<TextEditingController> _textControllers =
      <TextEditingController>[];

  Widget textFields = Container();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.fields; i++) {
      _textControllers.add(TextEditingController());
      _pin.add("");
      _focusNodes.add(FocusNode());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textFields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    for (var t in _textControllers) {
      t.dispose();
    }
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context, i == 0);
    });

    FocusScope.of(context).requestFocus(_focusNodes[0]);

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  void clearTextFields() {
    for (var tEditController in _textControllers) {
      tEditController.clear();
    }
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context, [bool autofocus = false]) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i].text = widget.lastPin![i];
      }
    }

    _focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {}
    });

    //final String lastDigit = _textControllers[i].text;

    return Container(
      width: widget.boxWidth,
      height: widget.boxHeight,
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        textAlign: TextAlign.center,
        cursorColor: widget.cursorColor,
        maxLength: 1,
        autofocus: autofocus,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.textColor,
            // color: Colors.black,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            filled: widget.showFieldAsBox ? true : false,
            fillColor: widget.fillColor,
            counterText: "",
            contentPadding: const EdgeInsets.only(top: 5),
            enabledBorder: widget.showFieldAsBox
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  )
                : UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).indicatorColor),
            ),
            focusedBorder: widget.showFieldAsBox
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: widget.boxColor),
                    borderRadius: BorderRadius.circular(10),
                  )
                : UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i].unfocus();
            if (_pin[i] == '') {
              if(i!=0){
                FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
              }
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i].unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String digit) => digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String digit) => digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textFields;
  }
}
