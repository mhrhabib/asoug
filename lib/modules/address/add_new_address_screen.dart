import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../core/common/widgets/custom_text_form_field.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Address'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LabeledTextField(label: 'Name', hintText: 'name'),
            LabeledTextField(label: 'Email', hintText: 'email'),
            LabeledTextField(label: 'Phone', hintText: 'phone'),
            LabeledTextField(label: 'Address', hintText: 'address'),
            LabeledTextField(label: 'Address 2', hintText: 'address'),
            LabeledTextField(label: 'Country', hintText: 'country'),
            LabeledTextField(label: 'States', hintText: 'states'),
            LabeledTextField(label: 'City', hintText: 'city'),
            Gap(12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {},
              label: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.check, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8),
          CustomTextFormField(
            hintText: hintText,
            controller: controller,
            obscureText: obscureText,
            textInputType: keyboardType,
            textInputAction: textInputAction,
          ),
        ],
      ),
    );
  }
}
