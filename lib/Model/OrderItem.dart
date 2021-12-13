

class OrderItem {
  final int order_id;
  final int product_id;
  final double item_price;
  final int item_quantity;
  final double item_total_price;

  OrderItem({
    this.order_id,
    this.product_id,
    this.item_price,
    this.item_quantity,
    this.item_total_price,
  }){
    //print('new product was created');
  }

  @override
  String toString() {
    return "Order Item {order id: ${this.order_id}, product id: ${this.product_id}, item quantity: ${this.item_quantity}, item total price: ${this.item_total_price},}";
  }
}

