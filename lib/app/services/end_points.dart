class EndPoints {
  EndPoints._();

  //static const baseUrl = "http://193.203.163.69:3000/";
  // static const baseUrl = "https://iamag.duckdns.org/";
  //static const baseUrl = "https://api.mountainroots.co.in/";
  static const baseUrl = "https://backend.mountainroots.co.in/";


  static const login = "auth/login";
  static const profile = "auth/me";
  static const signup = "auth/register/sendOtp";
  static const forgotPassword = "auth/forgotPassword";
  static const resetPass = "auth/resetPassword";
  static const verifyOtp = "auth/register/verifyOtp";
  static const category = "category";
  static const productDetail = "product/";
  static const addToCart = "user-card/";
  static const clearCart = "user-card/clear";
  static const shopList = "shop?page=1&limit=10";
  static const status = "status";
  static const banner = "banner";
  static const userAddress = "user-address";
  static const editAddress = "user-address/";
  static const product = "product?page=1&limit=10&category=";
  static const shop = "product?page=1&limit=10&shop=";
  static const allProduct = "product?page=1&limit=10";
  static const getProduct = "product";
  static const order = "order";
  static const paymentSuccess = "order/paymentSuccess/";
  static const addToFavorites = "user-favorite";
  static const updateProfile = "user/profile";
  static const uploadImage = "upload/image";
  static const pincode = "pin-code/";
  static const checkoutDetails = "order/checkout-details";
  static const defaultAddress = "user-address/default/";


}
