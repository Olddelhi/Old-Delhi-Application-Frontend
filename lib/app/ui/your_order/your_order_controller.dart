import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../responses/get_orders_response.dart';
import '../../services/api_response.dart';

class YourOrderController extends GetxController {
  var isLoading = true.obs;
  Rx<OrderResponse>? orderResponse;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  final itemsPerPage = 10;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onReady() {
    super.onReady();
    fetchOrders();
    update();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  RxBool sortByLatest = true.obs;

  void toggleSort(bool latest) {
    sortByLatest.value = latest;
    sortOrders();
  }

  void sortOrders() {
    if (orderResponse?.value.data == null) return;

    orderResponse!.value.data?.sort((a, b) {
      DateTime dateA = DateTime.parse(
          a.createdAt); // assuming your order model has `createdAt`
      DateTime dateB = DateTime.parse(b.createdAt);
      return sortByLatest.value
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    // Trigger UI update
    orderResponse!.refresh();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Load more data if at the end of the list
      fetchNextPage();
    }
  }

  List<String> getProductNames(List<OrderItem>? orderItems) {
    List<String> productNames = [];

    if (orderItems != null) {
      for (var orderItem in orderItems) {
        productNames.add(orderItem.productItem.product.name);
        for (var config in orderItem.productItem.productConfig) {
          productNames.add(orderItem.productItem.product.name);
        }
      }
    }

    return productNames;
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      OrderResponse? fetchedOrders = await ApiResponse().fetchOrders(
        currentPage.value,
        itemsPerPage,
      );
      if (fetchedOrders != null) {
        if (currentPage.value == 1) {
          orderResponse = fetchedOrders
              .obs; // For the first page, replace the existing list
        } else {
          // For subsequent pages, append the new orders to the existing list
          orderResponse!.value.data?.addAll(fetchedOrders.data!);
        }

        // orderResponse = fetchedOrders.obs;
        totalPages.value = fetchedOrders.totalPage;
        print("DKDKLDJSKLJDSK${orderResponse!.value}");
        sortOrders();

        isLoading.value = false;
        update();
      }
    } catch (e) {
      isLoading.value = false;
      print('Error fetching favorite items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to fetch next page of orders
  Future<void> fetchNextPage() async {
    print("hereee11 ${currentPage.value}");
    print("hereee1total1 ${totalPages.value}");

    if (currentPage.value < totalPages.value) {
      print("hereee");
      currentPage.value++; // Increment page number to fetch next page
      print("hereeess ${currentPage.value}");

      await fetchOrders(); // Call the fetchOrders method to fetch the next page
    } // Call the fetchOrders method to fetch the next page
  }
}
