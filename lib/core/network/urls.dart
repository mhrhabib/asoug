class Urls {
  static const baseUrl = 'https://demo.asoug.com/api/v1';
  static const loginUrl = '$baseUrl/sign';
  static const logoutUrl = '$baseUrl/logout';
  static const registerUrl = '$baseUrl/register';

  static const getUserUrl = '$baseUrl/me';
  static const forgotPasswordUrl = '$baseUrl/password/email';
  static const resetPasswordUrl = '$baseUrl/password/reset';
  static const updateProfileURl = '$baseUrl/profile';
  static const updatePasswordUrl = '$baseUrl/password/update';
  static const updateAvatarUrl = '$baseUrl/avatar/update';
  static const getAddressUrl = '$baseUrl/address';

  //products
  static const getFeaturedProductsUrl = '$baseUrl/featured-products?per_page=20';
  static const getProductsUrl = '$baseUrl/products?per_page=20';
}
