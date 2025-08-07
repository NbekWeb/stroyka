import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/custom_toast.dart';
import '../timeline/home_page.dart';
import '../../components/auth/index.dart';

class SmsLoginPage extends StatefulWidget {
  const SmsLoginPage({super.key});

  @override
  State<SmsLoginPage> createState() => _SmsLoginPageState();
}

class _SmsLoginPageState extends State<SmsLoginPage> {
  bool _isLoading = false;
  bool _showCodeVerification = false;
  String _phoneNumber = '';
  
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  String? _errorText;
  bool _codeSent = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleLogin(String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        // Navigate directly to home page
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        CustomToast.showTopToast(context, 'Login failed: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleSendSms() {
    setState(() {
      _errorText = null;
    });
    
    String cleanNumber = _phoneController.text.replaceAll(' ', '');
    if (cleanNumber.isEmpty) {
      setState(() {
        _errorText = 'Please enter a phone number';
      });
      return;
    }
    
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
    
    setState(() {
      _phoneNumber = cleanNumber;
      _showCodeVerification = true;
    });
    
    // Show success toast
    CustomToast.showTopToast(context, 'SMS code sent to $_phoneNumber', type: ToastType.success);
  }

  void _sendSmsCode() {
    setState(() {
      _codeSent = true;
    });
    // Show success toast
    CustomToast.showTopToast(context, 'SMS code resent to $_phoneNumber', type: ToastType.success);
  }

  void _verifyCode() {
    String code = _codeControllers.map((controller) => controller.text).join('');
    
    if (code.length != 4) {
      setState(() {
        _errorText = 'Please enter the complete 4-digit code';
      });
      return;
    }
    
    // Here you would typically verify the code with your backend
    _handleLogin(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and flag
            SmsHeader(
              showCodeVerification: _showCodeVerification,
              onBackPressed: () {
                if (_showCodeVerification) {
                  setState(() {
                    _showCodeVerification = false;
                    _codeSent = false;
                    _errorText = null;
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _showCodeVerification ? _buildCodeVerification() : _buildPhoneInput(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return PhoneInputForm(
      phoneController: _phoneController,
      phoneFocusNode: _phoneFocusNode,
      errorText: _errorText,
      isLoading: _isLoading,
      onSendSms: _handleSendSms,
      onErrorClear: () {
        if (_errorText != null) {
          setState(() {
            _errorText = null;
          });
        }
      },
    );
  }

  Widget _buildCodeVerification() {
    return CodeVerificationForm(
      phoneNumber: _phoneNumber,
      codeControllers: _codeControllers,
      focusNodes: _focusNodes,
      errorText: _errorText,
      isLoading: _isLoading,
      onResendSms: _sendSmsCode,
      onVerifyCode: _verifyCode,
      onErrorClear: () {
        if (_errorText != null) {
          setState(() {
            _errorText = null;
          });
        }
      },
    );
  }
} 