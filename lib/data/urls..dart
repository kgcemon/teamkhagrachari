class ApiUrl {
  static String mainUrl = "https://api.khagrachariplus.com/api/v1";
  static String categoryUrl = "$mainUrl/services-catagory";
  static String categoryDetailsUrl = "$mainUrl/services?servicesCatagory=";
  static String newsApiUrl = "https://khagrachariplus.com/loadnewskgc.php?key=hasanul";
  static String bloodUrl = "$mainUrl/users/all-donnor?isDonor=true";
  static String notice = "$mainUrl/notice";
  static String loginUrls = "$mainUrl/auth/login";
  static String profileUrl = "$mainUrl/users/profile";
  static String registerUrls = "$mainUrl/auth/register";
  static String sliderImgUrls = "$mainUrl/banner";
  static String addUserServicesUrl = "$mainUrl/services";
  static String userProfileUpdateUrl = "$mainUrl/users/profile/update/";
  static String privacyPolicyLink = "$mainUrl/users/profile/update/";
  static String userServicesUrl = "$mainUrl/services/get-my-services";
  static String scrollTextUrl = "$mainUrl/scroll-text";
  static String viewCountUrl = "$mainUrl/services/update-view";
  static String buySellCategoryUrl  = "$mainUrl/product-categorys";
  static String popUpUrls  = "$mainUrl/notice/allnotice";
  static String addProductUrl  = "$mainUrl/products";
  static String leaderBordUrl  = "$mainUrl/users/find-top-balances";
  static String productsUrls(String catId)=> "$mainUrl/products?page=1&limit=55&categoryId=$catId&status=Approved";
}