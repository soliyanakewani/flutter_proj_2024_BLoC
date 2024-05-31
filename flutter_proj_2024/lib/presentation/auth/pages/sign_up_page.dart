import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/signup/bloc/signup_bloc.dart';
import 'package:flutter_proj_2024/application/signup/bloc/signup_event.dart';
import 'package:flutter_proj_2024/application/signup/bloc/signup_state.dart';
import 'package:flutter_proj_2024/shared/widgets/text_field_widget.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo; 
import 'package:flutter_proj_2024/infrastructure/auth/sevices/auth_service.dart'; // Adjust the import path as necessary


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<bool> _isSelected = [true, false];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService(
   mongo.DbCollection(mongo.Db('your_db_uri'), 'users'), 
    'your_jwt_secret',);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: BlocProvider(
        create: (context) => SignUpBloc(authService: authService),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.325,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/bgc_hotel.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(400),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 65, 65),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ToggleButtons(
                  isSelected: _isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                        _isSelected[buttonIndex] = buttonIndex == index;
                      }
                    });
                  },
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('ADMIN'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('User'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Full Name",
                obscure: false,
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Email",
                obscure: false,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Password",
                obscure: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                hintText: "Confirm Password",
                obscure: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an Account?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 65, 65),
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login_page');
                    },
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 65, 65),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    final route = _isSelected[0] ? '/admin_page' : '/booking_page';
                    Navigator.pushNamed(context, route);
                  } else if (state is SignUpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign Up Failed: ${state.errorMessage}')),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is SignUpLoading
                        ? null
                        : () {
                            final name = _nameController.text;
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final confirmPassword = _confirmPasswordController.text;

                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passwords do not match')),
                              );
                              return;
                            }

                            final isAdmin = _isSelected[0];
                            context.read<SignUpBloc>().add(
                                  SignUpSubmitted(
                                    name: name,
                                    email: email,
                                    password: password,
                                    isAdmin: isAdmin,
                                  ),
                                );
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 93, 64, 50),
                      ),
                    ),
                    child: state is SignUpLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
