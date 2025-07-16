import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/custom_toast.dart';
import 'styles/login_form_styles.dart';

class LoginForm extends StatefulWidget {
  final Function(String) onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.onLogin,
    this.isLoading = false,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _errorText = null;
    });
    if (_phoneController.text.isNotEmpty) {
      String cleanNumber = _phoneController.text.replaceAll(' ', '');
      if (cleanNumber.length < 7) {
        setState(() {
          _errorText = 'Phone number must be at least 7 digits';
        });
        return;
      }
      if (cleanNumber.length > 9) {
        setState(() {
          _errorText = 'Phone number must be maximum 9 digits';
        });
        return;
      }
      widget.onLogin(cleanNumber);
    } else {
      // Show custom toast from right side
      CustomToast.showTopToast(context, 'Please enter a phone number');
    }
  }

  void _formatPhoneNumber(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length > 9) {
      digitsOnly = digitsOnly.substring(0, 9);
    }
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 6) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }
    if (formatted != value) {
      _phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: LoginFormStyles.horizontalPadding,
      child: Column(
        children: [
          const Text(
            'Hi!\nEnter your phone\nnumber to log in:',
            textAlign: TextAlign.center,
            style: LoginFormStyles.titleTextStyle,
          ),
          SizedBox(height: LoginFormStyles.titleBottomSpacing),
          Container(
            width: LoginFormStyles.inputContainerWidth,
            height: LoginFormStyles.inputContainerHeight,
            decoration: LoginFormStyles.inputContainerDecoration,
            child: Row(
              children: [
                Container(
                  padding: LoginFormStyles.countryCodePadding,
                  child: const Center(
                    child: Text(
                      '+46',
                      style: LoginFormStyles.countryCodeTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    onChanged: (v) {
                      _formatPhoneNumber(v);
                      if (_errorText != null) {
                        setState(() {
                          _errorText = null;
                        });
                      }
                    },
                    decoration: LoginFormStyles.textFieldDecoration,
                    textAlignVertical: TextAlignVertical.center,
                    style: LoginFormStyles.inputTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if (_errorText != null) ...[
            SizedBox(height: LoginFormStyles.errorTopSpacing),
            Text(
              _errorText!,
              style: LoginFormStyles.errorTextStyle,
            ),
          ],
          SizedBox(height: LoginFormStyles.buttonTopSpacing),
          SizedBox(
            width: LoginFormStyles.buttonWidth,
            height: LoginFormStyles.buttonHeight,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _handleLogin,
              style: LoginFormStyles.elevatedButtonStyle,
              child: widget.isLoading
                  ? SizedBox(
                      width: LoginFormStyles.loadingIndicatorSize,
                      height: LoginFormStyles.loadingIndicatorSize,
                      child: CircularProgressIndicator(
                        strokeWidth: LoginFormStyles.loadingIndicatorStrokeWidth,
                        valueColor: AlwaysStoppedAnimation<Color>(LoginFormStyles.loadingIndicatorColor),
                      ),
                    )
                  : Text(
                      'Log in',
                      style: LoginFormStyles.buttonTextStyle,
                    ),
            ),
          ),
        ],
      ),
    );
  }
} 