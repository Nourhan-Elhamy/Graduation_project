class CreateOrderRequest {
  final String shippingAddress;
  final String paymentMethod;
  final String notes;

  CreateOrderRequest({
    required this.shippingAddress,
    required this.paymentMethod,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'notes': notes,
    };
  }
}





class Order {
  final String id;
  final String status;
  final String shippingAddress;
  final String paymentMethod;
  final String notes;
  final String totalAmount;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.status,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.notes,
    required this.totalAmount,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final orderData = json['order'];
    final itemsList = (json['items'] as List)
        .map((item) => OrderItem.fromJson(item))
        .toList();

    return Order(
      id: orderData['id'],
      status: orderData['status'],
      shippingAddress: orderData['shippingAddress'],
      paymentMethod: orderData['paymentMethod'],
      notes: orderData['notes'],
      totalAmount: orderData['totalAmount'],
      items: itemsList,
    );
  }
}

class OrderItem {
  final String medicineName;
  final String image;
  final int quantity;
  final String price;

  OrderItem({
    required this.medicineName,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final medicine = json['medicine'];
    final orderItem = json['orderItem'];

    return OrderItem(
      medicineName: medicine['name'],
      image: medicine['image'],
      quantity: orderItem['quantity'],
      price: orderItem['price'],
    );
  }


}





















class OrderDetail {
  final String id;
  final String status;
  final String shippingAddress;
  final String paymentMethod;
  final String notes;
  final String totalAmount;
  final List<OrderItemDetail> items;

  OrderDetail({
    required this.id,
    required this.status,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.notes,
    required this.totalAmount,
    required this.items,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    final order = json['order'];
    final itemsJson = json['items'] as List;

    return OrderDetail(
      id: order['id'],
      status: order['status'],
      shippingAddress: order['shippingAddress'],
      paymentMethod: order['paymentMethod'],
      notes: order['notes'],
      totalAmount: order['totalAmount'],
      items: itemsJson.map((item) => OrderItemDetail.fromJson(item)).toList(),
    );
  }
}

class OrderItemDetail {
  final String medicineId;
  final String medicineName;
  final String medicineDescription;
  final String medicineImage;
  final int quantity;
  final String price;

  OrderItemDetail({
    required this.medicineId,
    required this.medicineName,
    required this.medicineDescription,
    required this.medicineImage,
    required this.quantity,
    required this.price,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    final orderItem = json['orderItem'];
    final medicine = json['medicine'];

    return OrderItemDetail(
      medicineId: medicine['id'],
      medicineName: medicine['name'],
      medicineDescription: medicine['description'],
      medicineImage: medicine['image'],
      quantity: orderItem['quantity'],
      price: orderItem['price'],
    );
  }
}

