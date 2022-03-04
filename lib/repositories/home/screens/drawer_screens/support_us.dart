import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/widgets/support_buttons.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/extensions/utility_strings.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class SupportUsPage extends StatefulWidget {
  const SupportUsPage({Key? key}) : super(key: key);

  @override
  State<SupportUsPage> createState() => _SupportUsPageState();
}

final _formKey = GlobalKey<FormState>();

class _SupportUsPageState extends State<SupportUsPage> {
  var publicKey = UtilityStrings.paymentRef;

  final plugin = PaystackPlugin();

  @override
  initState() {
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  String _email = '';
  String _number = '';
  String _name = '';
  String _amount = '';

  bool _isLoading = false;

  payOut() async {
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState!.save();

    try {
      Charge charge = Charge()
        ..amount = int.parse(_amount) * 100
        ..reference = _getReference('')
        ..email = _email;
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
      );

      if (response.status == true) {
        submitDetails(_name, _amount, _getReference(response.reference!)!,
            _email, _number);
      }

      setState(() {
        _isLoading = false;
      });
      var snackbar = SnackBar(
        content:
            "Your payment is successful! Thank you for supporting the MASS Movement"
                .obText,
        backgroundColor: primaryColor,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      _formKey.currentState!.reset();

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      var snackbar = SnackBar(
        content: "Something went wrong. Please try again".obText,
        backgroundColor: primaryColor,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _tHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: utilityAppBar(const Text(''), color: primaryColor),
      //  extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _tHeight * 0.4,
              width: double.infinity,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('donate2'.png),
                  ),
                  borderRadius: buttonBR,
                  boxShadow: kBoxShadow),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 'Or'.bigBold,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SupportTextField(
                    hint: 'JOe',
                    inputType: TextInputType.name,
                    onSubmitted: (s) {
                      setState(() {
                        _name = s!;
                      });
                    },
                  ),
                  SupportTextField(
                    hint: 'Joe@gmail.com',
                    inputType: TextInputType.emailAddress,
                    onSubmitted: (s) {
                      setState(() {
                        _email = s!;
                      });
                    },
                  ),
                  SupportTextField(
                    hint: '+23423456789',
                    inputType: TextInputType.number,
                    onSubmitted: (s) {
                      setState(() {
                        _number = s!;
                      });
                    },
                  ),
                  SupportTextField(
                    hint: '#20000',
                    inputType: TextInputType.number,
                    onSubmitted: (s) {
                      setState(() {
                        _amount = s!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? Center(child: loader)
                : SupportButton(onPressed: () => payOut()),
          ],
        ),
      ),
    );
  }

  String? _getReference(String ref) {
    return 'mobile-payment-${DateTime.now()}-$ref';
  }

  void submitDetails(String name, String amount, String ref, String email,
      String number) async {
    await FirebaseFirestore.instance.collection('paystackPayment').add({
      'name': name,
      'email': email,
      'reference': ref,
      'amount': amount,
      'number': number,
    });
  }
}
