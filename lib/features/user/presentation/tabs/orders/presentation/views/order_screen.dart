import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/features/user/presentation/tabs/cart/presentation/views/checkout_screen.dart';

import '../../data/models/orders_models.dart';
import '../controller/orders_cubit.dart';
import '../controller/orders_states.dart';
class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  String selectedPayment = 'credit_card';

  @override
  void dispose() {
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }

  bool get isFormValid => addressController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        centerTitle: true,
        title: Text(

          "Place Order",
          style: TextStyle(color: AppColors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OrderSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Order created successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
              Navigator.push(context, MaterialPageRoute(builder: (c){
                return CheckoutScreen();
              }));
            } else if (state is OrderFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.error}'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 16),
                _buildStyledInputField(
                  context: context,
                  controller: addressController,
                  label: 'Shipping Address',
                  hintText: 'Enter your address',
                  maxLines: 2,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                _buildStyledInputField(
                  context: context,
                  controller: notesController,
                  label: 'Notes (optional)',
                  hintText: 'Add any notes (optional)',
                  maxLines: 2,
                ),

                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedPayment,
                  items: const [
                    DropdownMenuItem(
                      value: 'credit_card',
                      child: Text('Credit Card'),
                    ),
                    DropdownMenuItem(
                      value: 'cash_on_delivery',
                      child: Text('Cash on Delivery'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  minWidth: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blueAccent,
                  disabledColor: AppColors.blue,
                  onPressed: (state is OrderLoading || !isFormValid)
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
                    children:  [

                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),

                      ),                      SizedBox(height: MediaQuery.of(context).size.height * 0.07,),

                      Text(
                        "Placing Order...",
                        style: TextStyle(
                            color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )
                      : const Text(
                    "Confirm Order",
                    style:
                    TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ],
            );
          },
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double calculatedHeight = maxLines == 1
        ? screenHeight * 0.07
        : (screenHeight * 0.05 * maxLines) + 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: calculatedHeight,
          decoration: BoxDecoration(
            color: AppColors.iconColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChanged,
            style: TextStyle(fontSize: screenWidth * 0.04),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
        ),
      ],
    );
  }


}
