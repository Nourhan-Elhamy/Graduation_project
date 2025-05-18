import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_colors.dart';

import '../../data/models/orders_models.dart';
class OrderDetailsPage extends StatelessWidget {
  final OrderDetail orderDetail;

  const OrderDetailsPage({Key? key, required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSizeSmall = width * 0.035;
    final fontSizeMedium = width * 0.04;
    final fontSizeLarge = width * 0.045;

    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        title: const Text('Orders Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Number + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Order :${orderDetail.id}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeLarge,
                              color: AppColors.grey
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.circle, size: 20, color: Colors.amberAccent),
                          const SizedBox(width: 4),
                          Text(
                            orderDetail.status,
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: fontSizeSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.03),



                  SizedBox(height: width * 0.025),


                  Text("Delivery Address: ${orderDetail.shippingAddress}",
                      style: TextStyle(fontSize: fontSizeMedium,color: AppColors.grey)),
                  SizedBox(height: width * 0.05),

                  // Order Details Title
                  Row(
                    children: [
                      Icon(Icons.receipt_long,color: AppColors.blue),
                      SizedBox(width: width * 0.02),
                      Text(
                        "Order Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeMedium,
                            color: AppColors.grey
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.03),

                  // Table Header
                  Container(
                    padding: EdgeInsets.symmetric(vertical: width * 0.02),
                    color: Colors.grey.shade100,
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Medicine Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSmall,color: AppColors.grey))),
                        Expanded(child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSmall,color: AppColors.grey))),
                        Expanded(child: Text("Unit Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSmall,color: AppColors.grey))),
                        Expanded(child: Text("Subtotal", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSmall,color: AppColors.grey))),
                      ],
                    ),
                  ),

                  // Table Rows
                  ...orderDetail.items.map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: width * 0.015),
                      child: Row(
                        children: [
                          // الصورة + اسم الدواء
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                // صورة الدواء
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    item.medicineImage, // أو من assets: "assets/images/medicine.png"
                                    width: width * 0.1,
                                    height: width * 0.1,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported, size: width * 0.08),
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                // اسم الدواء
                                Expanded(
                                  child: Text(
                                    item.medicineName,
                                    style: TextStyle(fontSize: fontSizeSmall),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // الكمية
                          Expanded(
                            child: Text(
                              "${item.quantity}",
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                          ),

                          // السعر
                          Expanded(
                            child: Text(
                              "${item.price}",
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                          ),

                          // الإجمالي
                          Expanded(
                            child: Text(
                              "${(item.price * item.quantity)}",
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  Divider(thickness: 1, height: width * 0.08),

                  // Total
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Total Price: ${orderDetail.totalAmount} EGP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeMedium,
                        color: AppColors.blue
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
