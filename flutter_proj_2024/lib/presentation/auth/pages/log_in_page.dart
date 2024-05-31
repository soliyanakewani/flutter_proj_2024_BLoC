import 'package:flutter/material.dart';
import 'package:flutter_proj_2024/shared/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
         // Determine screen size
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,   // Center the column
          children: <Widget>[
            Container(
              width: screenSize.width, // Use screen width
              height: screenSize.height * 0.45,
              decoration: const BoxDecoration(
                image:  DecorationImage(
                  image: AssetImage('lib/images/bgc_hotel.jpeg'),
                  fit: BoxFit.cover, // Cover the container with the image
                ),
                borderRadius: BorderRadius.only( // Make bottom border curvy
                  bottomRight: Radius.circular(300),
                ),
              ),
            ),
            const SizedBox(height: 10), // Proper spacing
            // Title/Login Text
            const Text(
              'Log in',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            

           
            TextFieldWidget(hintText: "Email",obscure: false,),
            const SizedBox(height: 30),

            TextFieldWidget(hintText: 'Password',obscure: true,),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ const Text(
                'Don\'t have an account? ',
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 65, 65),
                  fontSize: 14,
                  fontWeight: FontWeight.w200,

                ),
              ),

              GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup_page');
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 65, 65),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
              ]
            ),

            const SizedBox(height: 30),

            ElevatedButton(onPressed:() {
                 Navigator.pushNamed(context, '');
              }, 
              child:const Text(
                'L O G I N' ,
                style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 93, 64, 50)),
              ),)
            ],
          
         
          
        ),
      ),
    );
  }
}
