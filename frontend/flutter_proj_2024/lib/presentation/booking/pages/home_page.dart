
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/booking_bloc.dart';
import 'package:flutter_proj_2024/application/booking/bloc/home_bloc.dart';
import 'package:flutter_proj_2024/shared/widgets/appbar.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';
import 'package:go_router/go_router.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: screenSize.width,
                  height: screenSize.height * 0.3,
                  child: PageView(
                    children: state.images
                        .map((image) => Image.asset(
                              'assets/images/bgc_hotel.jpeg',
                              key: Key(image),
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'WELCOME  TO OASIS HOTEL!',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                '   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                style: TextStyle(
                  color: Color.fromARGB(255, 95, 65, 65),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.go('/booking_page');
              },
              child: Text(
                'B O O K',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 93, 64, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}