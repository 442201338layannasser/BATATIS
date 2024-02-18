class AboutOrderModel {
  String resturantName = '';
  String resturantLoc = '';
  String orderType = '';
  String paymentMethod = '';
  String orderDate = '';
  String orderTime = '';

  String get getResturantName {
    return resturantName;
  }

  void setResturantName(String resttName) {
    resturantName = resttName;
  }

  void setOrderDate(String ordDate) {
    orderDate = ordDate;
  }

  String get getOrderDate {
    return orderDate;
  }

  String get getOrderTime {
    return orderTime;
  }

  void setOrderTime(String ordTime) {
    orderTime = ordTime;
  }

  String get getResturantLoc {
    return resturantLoc;
  }

  void setResturantLoc(String restLoc) {
    resturantLoc = restLoc;
  }

  void setOrderType(String ordType) {
    orderType = ordType;
  }

  String get getOrderType {
    return orderType;
  }

  void setPaymentMethod(String payMethod) {
    paymentMethod = payMethod;
  }

  String get getPaymentMethod {
    return paymentMethod;
  }

  // AboutOrderModel({
  //   required this.resturantName,
  //   required this.resturantLoc,
  //   required this.orderInfo,
  //   required this.paymentMethod,
  // });
}
//