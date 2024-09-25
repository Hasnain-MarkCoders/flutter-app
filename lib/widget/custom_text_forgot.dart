import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/color_utils.dart';

class CustomTextForgot extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool? isPreffixIcon;
  final bool? isContentPedding;
  final TextEditingController? textEditingController;
  final void Function(String)? onchange;
  final TextInputType? textInputType;

  const CustomTextForgot(
      {Key? key,
      this.title,
      this.icon,
      this.isContentPedding = false,
      this.onchange,
      this.textEditingController,
      this.isPreffixIcon,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.only(top: 6,left: 32,right: 32),
      padding: EdgeInsets.only(left: 12,right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: HexColor(AppColor.LIGHT_GRAY),
      ),
      alignment: Alignment.center,
      child: TextField(
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
        obscureText: false,
        keyboardType: TextInputType.text,
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final Function? onTap;
  final Function? onChanged;
  final Function? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final Function? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;

  // final LanguageProvider languageProvider;

  CustomTextField({
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSuffixTap,
    this.fillColor,
    this.onSubmit,
    this.onChanged,
    this.capitalization = TextCapitalization.none,
    this.isCountryPicker = false,
    this.isShowBorder = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl,
    this.prefixIconUrl,
    this.isSearch = false,
    // this.languageProvider
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: Theme.of(context).textTheme.headline2?.copyWith(
          color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 16),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
            ]
          : null,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        hintStyle: Theme.of(context)
            .textTheme
            .headline2
            ?.copyWith(fontSize: 12, color: AppColor.grey),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon
            ? Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Image.asset(widget.prefixIconUrl ?? ""),
              )
            : const SizedBox.shrink(),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle)
                : widget.isIcon
                    ? IconButton(
                        onPressed: () {},
                        // onPressed: widget.onSuffixTap??(){},
                        icon: Image.asset(
                          widget.suffixIconUrl ?? '',
                          width: 15,
                          height: 15,
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      )
                    : null
            : null,
      ),
      // onTap: widget.onTap,
      // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
      //     : widget.onSubmit != null ? widget.onSubmit(text) : null,
      // onChanged: widget.onChanged,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
