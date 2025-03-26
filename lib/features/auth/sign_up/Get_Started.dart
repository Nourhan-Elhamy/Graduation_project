import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_images.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.9;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(AppImages.get_start,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20,),

            SizedBox(height: 35,),
            ElevatedButton(onPressed: (){
             // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoadingPage()),);
            },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(buttonWidth,59),



                    backgroundColor: AppColors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),

                    )),
                child:
                Text("Start",style: TextStyle(
                  fontSize: 24,

                ),)
            )

          ],
        ),
      ),


    );
  }
}