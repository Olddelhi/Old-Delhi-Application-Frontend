import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/responses/add_address_response.dart';
import 'package:old_delhi_food/app/responses/category_response.dart';
import 'package:old_delhi_food/app/responses/get_cart_response.dart';
import 'package:old_delhi_food/app/responses/pincode_response.dart';
import 'package:old_delhi_food/app/responses/product_detail_response.dart';
import 'package:old_delhi_food/app/responses/shop_response.dart';
import 'package:old_delhi_food/app/responses/signup_response.dart';
import 'package:old_delhi_food/app/responses/specfic_category_response.dart';
import 'package:old_delhi_food/app/services/end_points.dart';
import 'package:old_delhi_food/app/ui/checkout/checout_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/shared_preferns.dart';
import '../responses/get_address_response.dart';
import '../responses/get_all_product_respobse.dart' as allproduct;
import '../responses/get_banner_response.dart';
import '../responses/get_orders_response.dart';
import '../responses/profile_response.dart';
import '../responses/status_response.dart';
import '../ui/cart_screen/cart_controller.dart';
import '../ui/profile/profile_controller.dart';
import '../utils/app_pages.dart';
import 'http_services.dart';

class ApiResponse {
  Future<SignupResponse?> login(
      String email, String mobileText, String password) async {
    try {
      var res = await httpService.post(endPoint: EndPoints.login, data: {
        "email": email.trim().toString(),
        "password": password.trim().toString()
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        return SignupResponse.fromJson(res.data);
      } else {
        Get.snackbar(
          "Alert",
          res.data['message'].toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print(e.toString());
      // Get.snackbar("Alert", e.toString());
    }
    return null;
  }

  Future<bool> forgotPassword(String email) async {
    try {
      var res =
          await httpService.post(endPoint: EndPoints.forgotPassword, data: {
        "email": email.trim().toString(),
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      } else {
        Get.snackbar(
          "Alert",
          res.data['message'].toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );

        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
      // Get.snackbar("Alert", e.toString());
    }
  }

  Future<bool> resetPassword(String email, String otp, String password) async {
    try {
      var res = await httpService.post(endPoint: EndPoints.resetPass, data: {
        "email": email.trim().toString(),
        "otp": otp,
        "password": password
      });
      print(res.statusCode);
      if (res.statusCode == 200) {
        return true;
      } else {
        Get.snackbar(
          "Alert",
          res.data['message'].toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );

        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
      // Get.snackbar("Alert", e.toString());
    }
  }

  Future<bool?> signup(
      String name, String email, String mobileText, String password) async {
    try {
      var res = await httpService.post(endPoint: EndPoints.signup, data: {
        "name": name.trim().toString(),
        "phoneNumber": mobileText.trim().toString(),
        "email": email.trim().toString(),
        "password": password.trim().toString()
      });

      print("res ${res.data}");
      if (res.statusCode == 200) {
        return true;
      } else {
        Get.snackbar(
          "Alert",
          res.data['message'].toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  Future<SignupResponse?> verifyOtp(
      String email, String mobile, String otp) async {
    try {
      var res = await httpService.post(endPoint: EndPoints.verifyOtp, data: {
        "email": email,
        "otp": otp,
      });
      print("res from otp ${res.statusCode}");
      print("res from otp ${res.data['message']}");
      if (res.statusCode == 200) {
        return SignupResponse.fromJson(res.data);
      } else {
        Get.snackbar(
          "Alert",
          res.data['message'].toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }

    return null;
  }

  Future<CategoryResponse?> getAllCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: EndPoints.category,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("status code from category ${res.statusCode}");
      if (res.statusCode == 200) {
        return CategoryResponse.fromJson(res.data);
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
      print(e.toString());
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString(SharedPrefs.keys.authToken,'');
      // Get.toNamed(AppPages.loginScreen);
    }
    return null;
  }

  Future getAllProduct() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: EndPoints.getProduct,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
      print("errorrrrrr$e");
    }
    return null;
  }

  Future getAllProductAtOnce() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      List<allproduct.Datum> allProducts = [];

      int page = 1;
      int limit = 150; // Define your page limit here
      while (true) {
        var res = await httpService.get(
          endPoint: "${EndPoints.getProduct}?page=$page&limit=$limit",
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (res.statusCode == 200) {
          var productList = allproduct.Product.fromJson(res.data);
          allProducts.addAll(productList.data);

          // If the number of items fetched is less than the limit, it means there are no more pages
          if (productList.data.length < limit) {
            break;
          } else {
            page++; // Increment page number for the next request
          }
        } else {
          throw Exception('Failed to fetch products');
        }
      }

      return allProducts;
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
      print("errorrrrrr$e");
    }
    return null;
  }

  Future<ShopResponse?> getShopList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: EndPoints.shopList,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("status from shop api ${res.statusCode}");
      if (res.statusCode == 200) {
        return ShopResponse.fromJson(res.data);
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future getFilterShop(query) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: "product?search=$query",
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("status from filter api ${res.statusCode}");
      if (res.statusCode == 200) {
        return res.data['data'];
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<List<StatusData>?> getStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: EndPoints.status,
        //   options: Options(
        //   headers:  <String, String>{
        //     'Authorization': 'Bearer $token',
        //   },
        // ),
      );

      print("status from status api ${res.statusCode}");
      if (res.statusCode == 200) {
        final List<dynamic> data = res.data['data'];
        List<StatusData> dataList =
            data.map((item) => StatusData.fromJson(item)).toList();
        return dataList;
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<List<BannerModel>?> getBanner() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      var res = await httpService.get(
        endPoint: EndPoints.banner,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("status from banner api ${res.statusCode}");
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data'];
        return data.map((json) => BannerModel.fromJson(json)).toList();
      }
    } catch (e) {
      print(e.toString());
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<SpecificCategoryResponse?> getSpecificCategory(
      category, fromShop, int page) async {
    String productUrl = "product?page=$page&limit=10&category=";
    String shopUrl = "product?page=$page&limit=10&shop=";

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.get(
          endPoint:
              fromShop == true ? shopUrl + category : productUrl + category,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));
      if (res.statusCode == 200) {
        return SpecificCategoryResponse.fromJson(res.data);
      }
    } catch (e) {
      print(e.toString());
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  // Future<SpecificCategoryResponse?> getSpecificCategory(
  //     category, fromShop) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var token = prefs.getString(SharedPrefs.keys.authToken);
  //     var res = await httpService.get(
  //         endPoint: fromShop == true
  //             ? EndPoints.shop + category
  //             : EndPoints.product + category,
  //         options: Options(
  //           headers: <String, String>{
  //             'Authorization': 'Bearer $token',
  //           },
  //         ));
  //     if (res.statusCode == 200) {
  //       return SpecificCategoryResponse.fromJson(res.data);
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Alert",
  //       e.toString(),
  //       colorText: Colors.white,
  //       backgroundColor: Colors.red,
  //     );
  //   }
  //   return null;
  // }

  Future<ProductDetailResponse?> getItemDetail(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.get(
          endPoint: EndPoints.productDetail + id,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));

      if (res.statusCode == 200) {
        return ProductDetailResponse.fromJson(res.data);
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<bool?> addToCart(Map<String, Object> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.post(
          endPoint: EndPoints.addToCart,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ),
          data: data);

      print("status cocde from add to cart ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<GetCartResponse?> getCartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.get(
        endPoint: EndPoints.addToCart,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("status from cart ${res.statusCode}${res.data['message']}");
      if (res.statusCode == 200) {
        return GetCartResponse.fromJson(res.data);
      }
      if (res.data['message'] == 'jwt expired') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(SharedPrefs.keys.authToken, '');
        Get.offAll(AppPages.loginScreen);
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  removeCartItem(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.delete(
        endPoint: EndPoints.addToCart + id,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (res.statusCode == 200) {
        Get.find<CartController>().deleteItem.value = false;
        Get.find<CartController>().itemsBeingDeleted.remove(id);

        Get.snackbar(
          "Alert",
          'Success',
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        // return GetCartResponse.fromJson(res.data);
      }
    } catch (e) {
      Get.find<CartController>().deleteItem.value = false;
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  removeUserCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.delete(
        endPoint: EndPoints.clearCart,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (res.statusCode == 200) {
        // Get.snackbar("Alert", 'Success');
        // return GetCartResponse.fromJson(res.data);
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<AddAddressResponse?> addAddress(Map<String, String?> data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.post(
          endPoint: EndPoints.userAddress,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ),
          data: data);

      print("resposne formad${res.data}${res.statusCode}");
      if (res.statusCode == 200) {
        return AddAddressResponse.fromJson(res.data);
      } else if (res.statusCode == 400) {
        Get.snackbar(
          "Alert",
          "Enter valid address",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  Future<GetAddressResponse?> getAddress() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.get(
          endPoint: EndPoints.userAddress,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));
      print("staus from address ${res.statusCode}");
      if (res.statusCode == 200) {
        return GetAddressResponse.fromJson(res.data);
      }
    } catch (e) {
      // Get.snackbar(
      //   "Alert",
      //   e.toString(),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    }
    return null;
  }

  Future<bool> editAddress(id, name, phone, pincodeId, locality, address, city,
      landmark, state, alternatePhone) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.put(
          endPoint: EndPoints.editAddress + id,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "name": name,
            "mobile": phone,
            "pincode": pincodeId,
            "locality": locality,
            "address": address,
            "city": city,
            "landmark": landmark,
            "state": state,
            "alternatePhone": alternatePhone
          });

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  Future<bool> deleteAddress(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.delete(
          endPoint: EndPoints.editAddress + id,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));
      print("staus from address ${res.statusCode}");
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return false;
  }

  Future<dynamic> verifyPincode(pincode) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.get(
          endPoint: EndPoints.pincode + pincode,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));

      print("staus from address ${res.statusCode}");
      if (res.statusCode == 200) {
        return PincodeResponse.fromJson(res.data);
      } else if (res.data['message'] == 'Invalid Pincode') {
        Get.snackbar(
          "Alert",
          "Enter valid pincode",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  //used this to fetch all order of user
  fetchOrders(int pageNumber, int pageSize) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      final response = await httpService.get(
          endPoint: "${EndPoints.order}?page=$pageNumber&size=$pageSize",
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        return OrderResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

//used to mark favourite
  Future<void> addToFavorites(String productItemId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.post(
        endPoint: EndPoints.addToFavorites,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "productItemId": productItemId,
        },
      );
      if (res.statusCode == 200) {
        Get.snackbar(
          "Alert",
          "Added to favourite",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        // Handle success
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  } //used to mark favourite

  Future<void> removeFromFavorites(String productItemId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.delete(
        endPoint: "${EndPoints.addToFavorites}/$productItemId",
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (res.statusCode == 200) {
        Get.snackbar(
          "Alert",
          "Removed from favourite",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        // Handle success
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<ProfileResponse> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(SharedPrefs.keys.authToken);
    final response = await httpService.get(
      endPoint: EndPoints.profile,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      // print(response.data);
      return ProfileResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String bio,
    required String image,
    required String email,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      final response = await httpService.patch(
        endPoint: EndPoints.updateProfile,
        data: {
          "fullName": fullName,
          "bio": '$bio  ',
          "image": image,
          "email": email,
        },
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.find<ProfileController>().fetchProfile();
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar(
          "Alert",
          "Profile updated",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );

        // Profile updated successfully
      } else if (response.statusCode == 404) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString(SharedPrefs.keys.authToken);
          final response = await httpService.post(
            endPoint: EndPoints.updateProfile,
            data: {
              "fullName": fullName,
              "bio": bio,
              "image": image,
              "email": email
            },
            options: Options(
              headers: <String, String>{
                'Authorization': 'Bearer $token',
              },
            ),
          );
          print(response.statusCode);
          if (response.statusCode == 201) {
            Get.snackbar(
              "Alert",
              "Profile created",
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
            // Profile updated successfully
          } else {
            throw Exception('Failed to update profile');
          }
        } catch (e) {
          throw Exception('Failed to update profile: $e');
        }
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> createProfile({
    required String fullName,
    required String bio,
    required String image,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      final response = await httpService.post(
        endPoint: EndPoints.updateProfile,
        data: {
          "fullName": fullName,
          "bio": bio,
          "image": image,
        },
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Profile updated successfully
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Future<Map<String, dynamic>>
  // Future<void> placeOrder(String addressId, String paymentMethod,addressData,date ,startTime,endTime) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var token = prefs.getString(SharedPrefs.keys.authToken);
  //     final response = await httpService.post(
  //       endPoint: EndPoints.order,
  //       data: {
  //         'addressId': addressId,
  //         'paymentMethod': paymentMethod,
  //           "deliveryDate": date,
  //           "startingDeliveryTime": startTime,
  //           "endingDeliveryTime": endTime,
  //           "billingAddress": addressData,
  //       },
  //       options: Options(
  //         headers: <String, String>{
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //     print("ddd${response.statusCode}");
  //     if (response.data['status']==true) {
  //       Get.snackbar("Alert", "Order Placed ",colorText: Colors.white,
  //         backgroundColor: Colors.red,);
  //       // final responseData = json.decode(response.data);
  //
  //       // Order placed successfully
  //      if(paymentMethod=='RAZORPAY') {
  //        if (response.data.containsKey('data') && response.data['data'].containsKey('razorpayOrder')) {
  //         Get.find<CheckoutController>().makePayment(100, response.data['data']['razorpayOrder']);
  //         Get.find<CheckoutController>().orderId = response.data['data']['order']['id'];     // Return the razorpayOrder data
  //         return response.data['data']['razorpayOrder'];
  //       } else {
  //         throw Exception('Razorpay order not found in response');
  //       }
  //     }
  //     } else {
  //       // Get.snackbar("Alert", "Order Not Placed");
  //       // Handle error
  //       throw Exception('Failed to place order:${response.data} ');
  //     }
  //   } catch (e) {
  //     Get.snackbar("Alert", "Order Not Placed Yet", colorText: Colors.white,
  //       backgroundColor: Colors.red,);
  //     throw Exception('Failed to place order: $e');
  //     // Handle network error
  //   }
  // }

  Future<void> placeOrder(String addressId, String paymentMethod, addressData,
      date, startTime, endTime) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.order),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'addressId': addressId,
          'paymentMethod': paymentMethod,
          "deliveryDate": date,
          "startingDeliveryTime": startTime,
          "endingDeliveryTime": endTime,
          "billingAddress": addressData,
        }),
      );

      print("ddd${response.statusCode}");
      print("ddd${response.body}");

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          if (paymentMethod == 'RAZORPAY') {
            if (responseData.containsKey('data') &&
                responseData['data'].containsKey('razorpayOrder')) {
              Get.find<CheckoutController>()
                  .makePayment(100, responseData['data']['razorpayOrder']);
              Get.find<CheckoutController>().orderId =
                  responseData['data']['order']['id'];
              return responseData['data']['razorpayOrder'];
            } else {
              throw Exception('Razorpay order not found in response');
            }
          }
          Get.snackbar("Alert", "Order Placed ",
              colorText: Colors.white, backgroundColor: Colors.red);
        } else {
          throw Exception('Failed to place order: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Failed to place order. Server returned status code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      Get.snackbar("Alert", "Order Not Placed Yet",
          colorText: Colors.white, backgroundColor: Colors.red);
      throw Exception('Failed to place order: $e');
    }
  }

  Future<bool> successRazorpayTransaction(
      orderId, razorOrderId, razorPaymentId, razorSignature) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      final response = await httpService.post(
        endPoint: EndPoints.paymentSuccess + orderId,
        data: {
          "razorpay_order_id": razorOrderId,
          "razorpay_payment_id": razorPaymentId,
          "razorpay_signature": razorSignature
        },
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print("ddd${response.statusCode}");
      if (response.statusCode == 200) {
        return true;
      } else {
        // Get.snackbar("Alert", "Order Not Placed");
        // Handle error
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Alert",
        "Failed payment",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
      // Handle network error
    }
  }

  Future<Map<String, dynamic>> getCheckOutDetails(String addressId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      var res = await httpService.post(
          endPoint: EndPoints.checkoutDetails,
          options: Options(
            headers: <String, String>{
              'Authorization': 'Bearer $token',
            },
          ),
          data: {
            "addressId": addressId,
            "paymentMethod": "RAZORPAY",
          });
      print(res.statusCode);
      if (res.statusCode == 200) {
        // Return the parsed response data
        return res.data;
      } else if (res.statusCode == 400) {
        // Handle status code 400
        final responseData = res.data;
        final message = responseData is Map
          ? responseData["message"]?.toString() ?? ''
          : '';
        final unavailableItems = responseData is Map &&
            responseData["data"] is List
          ? responseData["data"] as List
          : <dynamic>[];
        if (unavailableItems.isNotEmpty) {
          // If data is present, fetch product name
          final firstItem = unavailableItems.first;
          final product = firstItem is Map
            ? firstItem["productItem"] is Map
              ? firstItem["productItem"]["product"]
              : null
            : null;
          final productName = product is Map
            ? product["name"]?.toString() ?? ''
            : '';
          print("Message: $message");
          print("Product Name: $productName");
          Get.snackbar(
            "Alert",
          productName.isEmpty
            ? message
            : "$productName is not deliverable on selected address",
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
        } else {
          print("Message: $message");
        }
      }
      // Return an empty map if the response does not match any condition
      return {};
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Alert",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      // Return an empty map in case of an exception
      return {};
    }
  }

  Future<dynamic> fetchFavoriteItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);

      final response = await httpService.get(
        endPoint: EndPoints.addToFavorites,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch favorite items: $e');
    }
  }

  setDefaultAddress(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString(SharedPrefs.keys.authToken);
      final response = await httpService.get(
        endPoint: EndPoints.defaultAddress + id,
        options: Options(
          headers: <String, String>{
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to set default address: $e');
    }
  }
}
