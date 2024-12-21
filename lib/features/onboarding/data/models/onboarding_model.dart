

import '../../../../core/utils/app_images.dart';

class OnboardingModel{

  final String image;
  final String title;
  final String desc;


  OnboardingModel({
  required this.image,
    required this.title,
    required this.desc
  });


}

List<OnboardingModel> onboardingmodel=[
  OnboardingModel(image: AppImages.onboardingimage1, title: "Find Medicines", desc: 'Easily find your prescribed medicines from a variety of registered pharmacies, no matter where you are.',),
  OnboardingModel(image: AppImages.onboardingimage2, title: "Select Pharmacy", desc: "Pick the pharmacy that suits you best. We've got trusted options and reliable options in our network."),
  OnboardingModel(image: AppImages.onboardingimage3, title: "Pharmacy Management",desc: "Easily manage orders and maintain an organized, top-notch service for customers. Update drug details manually or through file uploads for an up-to-date catalog.")
];