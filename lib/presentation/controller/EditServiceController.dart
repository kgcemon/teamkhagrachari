import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';

class EditServiceController extends GetxController {
  var name = ''.obs;
  var serviceProviderName = ''.obs;
  var addressDegree = ''.obs;
  var description = ''.obs;

  // Loading and error states
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Function to initialize the form with existing service data
  void initializeFields({

    required String serviceProviderName,
    required String addressDegree,
    required String description,
  }) {
    this.serviceProviderName.value = serviceProviderName;
    this.addressDegree.value = addressDegree;
    this.description.value = description;
  }

  // Function to update the service
  Future<bool> updateService(String serviceId) async {
    isLoading(true);
    hasError(false);
    errorMessage('');

    try {
      // Prepare the data to be updated
      Map<String, dynamic> updateData = {
        'name': name.value,
        'serviceProviderName': serviceProviderName.value,
        'addressDegree': addressDegree.value,
        'description': description.value,
        // Add other fields as necessary
      };

      // Make the PUT or PATCH request
      final response = await NetworkCaller.patchRequest(
        url: "https://api.khagrachariplus.com/api/v1/services/$serviceId",
        body: updateData, isMultipart: true, token: null,
      );

      if (response.responseCode == 200) {
        // Update was successful
        return true;
      } else {
        // Handle server errors
        hasError(true);
        errorMessage(response.responseData['message'] ?? 'Unknown error occurred.');
        return false;
      }
    } catch (e) {
      // Handle network or unexpected errors
      hasError(true);
      errorMessage(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }
}
