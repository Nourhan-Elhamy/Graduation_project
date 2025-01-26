import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../shared_widgets/custom_button.dart';
import '../../../../../shared_widgets/custom_text_filde.dart';


class RefillReminder extends StatelessWidget {
  const RefillReminder({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leadingWidth: screenWidth * 0.25,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: const Color(0xff9C4400),
              fontSize: screenHeight * 0.025,
            ),

          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [


              const Text(
                "Which medication should we remind you about?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(),
              SizedBox(height: screenHeight*0.02),
              const Text(
                "How often do you take this medication?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde( ),

              SizedBox(height: screenHeight*0.02),
              const Text(
                "When should we remind you to refill?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color:Colors.blueGrey),
              ),
              CustomTextFilde( ),
              SizedBox(height: screenHeight*0.02),

              const Text(
                "How should we notify you?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(),

              SizedBox(height: screenHeight*0.02),
              const Text(
                "Which pharmacy do you prefer for refills?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(),
              SizedBox(height: screenHeight*0.02),
              const Text(
                "Would you like us to automatically place an order for this medication?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.blueGrey),
              ),
              CustomTextFilde(),

              SizedBox(height: screenHeight*0.03),
              CustomButton(title: "Save", color: AppColors.blue, textcolor: AppColors.white,onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return RefillSuccess();
                }));
              },)

            ],
          ),
        ),
      ),
    );
  }
}


class RefillSuccess extends StatelessWidget {
  const RefillSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)
        ),
      ),

      body: Column(
        children: [
          Center(
            child: Image.asset("assets/images/2x/refillSuccess.png"),
          ),
          SizedBox(height: screenHeight*0.3),
          CustomButton(title: "Done!", color: AppColors.blue, textcolor: AppColors.white,onPressed: (){},)
        ],
      ),
    );
  }
}
