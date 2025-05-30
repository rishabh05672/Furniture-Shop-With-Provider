import 'package:flutter/material.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool enabled;
  //final bool? obscureText;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    // this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: validator,
          keyboardType: keyboardType,
          enabled: enabled,
          style: AppConstants.bodyStyle,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppConstants.bodyStyle.copyWith(color: Colors.grey[400]),
            filled: true,
            fillColor: enabled ? Colors.grey[100] : Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
          ),
          elevation: 0,
        ),
        onPressed: isLoading ? null : onPressed,
        child:
            isLoading
                ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Or Continue With",
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }
}

class SocialAuthButton extends StatelessWidget {
  final String text;
  final String icons;
  final VoidCallback onPressed;
  const SocialAuthButton({
    super.key,
    required this.text,
    required this.icons,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icons, height: 24, width: 24),
          SizedBox(width: 12),
          Text(
            text,
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
