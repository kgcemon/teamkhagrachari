import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';

class EditServiceController extends GetxController {

  // Loading and error states
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;


  // Function to update the service
  Future<bool> updateService({
    required String serviceId,
    required String name,
    required String serviceProviderName,
    required String addressDegree,
    required String description,
  }) async {
    isLoading(true);
    hasError(false);
    errorMessage('');


    print(serviceProviderName);

    try {
      // Prepare the data to be updated
      Map<String, dynamic> updateData = {
        'name': name,
        'serviceProviderName': serviceProviderName,
        'addressDegree': addressDegree,
        'description': description,
        // Add other fields as necessary
      };

      // Make the PUT or PATCH request
      final response = await NetworkCaller.patchRequest(
        url: "https://api.khagrachariplus.com/api/v1/services/$serviceId",
        body: {
          'serviceProviderName': serviceProviderName,
          'addressDegree': addressDegree,
          'description': description,
          // Add other fields as necessary
        }, isMultipart: false, token: null,
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
