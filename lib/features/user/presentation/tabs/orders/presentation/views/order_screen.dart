import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/tabs/cart/presentation/views/checkout_screen.dart';

import '../../../cart/presentation/controller/cart_cubit.dart';
import '../../data/models/orders_models.dart';
import '../controller/orders_cubit.dart';
import '../controller/orders_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String selectedPayment ="";
  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  bool get isFormValid => addressController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          title: Text(
            "Place Order",
            style: TextStyle(color: AppColors.blue, fontSize: 18.sp),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocListener<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is OrderSuccess) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Order created successfully'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ); context.read<CartCubit>().clearCart();

                // ✅ الذهاب إلى الشيك أوت

                Navigator.push(context, MaterialPageRoute(builder: (c) {
                  return CheckoutScreen();
                }));
              } else if (state is OrderFailure) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                );
              }
            },
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),
                      _buildStyledInputField(
                        context: context,
                        controller: addressController,
                        label: 'Shipping Address',
                        hintText: 'Enter your address',
                        maxLines: 2,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 16.h),
                      _buildStyledInputField(
                        context: context,
                        controller: notesController,
                        label: 'Notes (optional)',
                        hintText: 'Add any notes (optional)',
                        maxLines: 2,
                      ),
                      SizedBox(height: 16.h),
                      _buildPaymentOptions(),
                      SizedBox(height: 24.h),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 70.h,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        color: AppColors.blue,
                        disabledColor: AppColors.blue,
                        onPressed: (state is OrderLoading)
                            ? null
                            : () {
                          final request = CreateOrderRequest(
                            shippingAddress: addressController.text.trim(),
                            paymentMethod: selectedPayment,
                            notes: notesController.text.trim(),
                          );
                          context.read<OrderCubit>().createOrder(request);
                        },
                        child: state is OrderLoading
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Placing Order...",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            ),
                          ],
                        )
                            : Text(
                          "Confirm Order",
                          style: TextStyle(
                              color: Colors.white, fontSize: 24.sp),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStyledInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    String? hintText,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    double calculatedHeight = maxLines == 1 ? 70.h : (50.h * maxLines) + 20.h;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: calculatedHeight,
          decoration: BoxDecoration(
            color: AppColors.iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChanged,
            style: TextStyle(fontSize: 14.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _customRadioTile(
          label: 'Credit Card',
          icon: Icons.credit_card,
          color: AppColors.blue,
          value: 'credit_card',
        ),
        _customRadioTile(
          label: 'Cash on Delivery',
          icon: Icons.money,
          color: Colors.green,
          value: 'cash_on_delivery',
        ),
      ],
    );
  }

  Widget _customRadioTile({
    required String label,
    required IconData icon,
    required Color color,
    required String value,
  }) {
    bool isSelected = selectedPayment == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : AppColors.blue.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : AppColors.grey),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isSelected ? color : AppColors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : AppColors.grey,
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 16.w, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}