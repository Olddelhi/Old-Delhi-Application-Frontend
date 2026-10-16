import 'package:get/get.dart';
import 'package:old_delhi_food/app/responses/profile_response.dart';
import 'package:old_delhi_food/app/services/api_response.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var user = User(
    id: '',
    name: '',
    phoneNumber: '',
    isVerified: false,
    createdAt: '',
    updatedAt: '',
    profile: Profile(
      id: '', // Profile ID
      fullName: '', // Full name
      bio: '', // Bio information
    ),
    role: [],
  ).obs;

  final ApiResponse _profileApi = ApiResponse();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onReady(){
    fetchProfile();
    super.onReady();
  }

  void fetchProfile() async {
    try {
      isLoading.value = true;
      final profileResponse = await _profileApi.fetchProfile();
      if (profileResponse.status != null && profileResponse.status!) {
        if (profileResponse.data != null && profileResponse.data!.user!.profile != null) {
          print("heree profilee");
          final profile = profileResponse.data!.user!.profile!;
          user.value = profileResponse.data!.user!;
          // Assign profile values to user object
          user.update((val) {
            print("heree profilee $val");
            val!.name = profile.fullName ??profileResponse.data!.user!.name??'' ;
            val.phoneNumber = profileResponse.data!.user!.phoneNumber ?? '';
            val.email = profileResponse.data!.user!.email ?? '';
            val.profile!.bio = profile.bio ?? '';
          });
        }else{
          print("but heree");
          user.value = profileResponse.data!.user!;
          print("user profike ${user.value}");
        }
      } else {
        print(profileResponse.message); // Handle error message
      }
    } catch (e) {
      print(e.toString()); // Handle exceptions
    } finally {
      isLoading.value = false;
    }
  }
}
