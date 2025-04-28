import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:asoug/core/common/widgets/custom_elevated_button.dart';

import 'reset_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String email;

  const VerificationScreen({super.key, required this.email});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  bool isLoading = false;
  bool _canResend = false;
  int _resendCountdown = 30;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _startResendCountdown() {
    _canResend = false;
    _resendCountdown = 30;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;

      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          _canResend = true;
        }
      });
      return true;
    });
  }

  Future<void> _verifyCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // Simulate API verification
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => isLoading = false);
        // Navigate to next screen or show success
      }
    }
  }

  Future<void> _resendCode() async {
    setState(() => _canResend = false);
    _startResendCountdown();

    // Simulate resend API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification code resent to ${widget.email}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Enter 4 Digit Code',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter 4 digit code that you received on your email (${widget.email}).',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              Center(
                child: Pinput(
                  controller: _pinController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length != 4) {
                      return 'Please enter the 4-digit code';
                    }
                    return null;
                  },
                  showCursor: true,
                  onCompleted: (pin) => _verifyCode(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email not received?',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: _canResend ? _resendCode : null,
                    child: _canResend ? const Text('Resend code') : Text('Resend in $_resendCountdown'),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Continue',
                    buttonTextStyle: const TextStyle(color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen(email: widget.email),
                        ),
                      );
                    },
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
