import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onepiconeword/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
late final AnimationController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }
  bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => firstpage(),));
          },
          child: Lottie.network(
              'https://assets7.lottiefiles.com/packages/lf20_cvuo6gcv.json'),
        ),

      ),
    );
  }
}


// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.network(
//             'https://assets3.lottiefiles.com/packages/lf20_sdsq6yiq.json'),
//       ),
//     );
//   }
// }
