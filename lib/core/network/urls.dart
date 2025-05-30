class Urls {
  static const baseUrl = 'https://demo.asoug.com/api/v1';
  static const loginUrl = '$baseUrl/sign';
  static const logoutUrl = '$baseUrl/logout';
  static const registerUrl = '$baseUrl/register';

  static const getUserUrl = '$baseUrl/me';
  static const forgotPasswordUrl = '$baseUrl/app/password/email';
  static const resetPasswordUrl = '$baseUrl/app/password/reset';
  static const verifyEmailUrl = '$baseUrl/app/password/opt-verify';
  static const resendEmailUrl = '$baseUrl/app/password/resend-otp';
  static const updateProfileURl = '$baseUrl/profile';
  static const updatePasswordUrl = '$baseUrl/password/update';
  static const updateAvatarUrl = '$baseUrl/avatar/update';
  static const getAddressUrl = '$baseUrl/address';

  //products
  static const getFeaturedProductsUrl = '$baseUrl/featured-products?per_page=20';
  static const getProductsUrl = '$baseUrl/products?per_page=20';
  static const getProductsDetailsUrl = '$baseUrl/product/';
  //address
  static const addressUrl = '$baseUrl/address';
  static const addDefaultAddressUrl = '$baseUrl/set-default-address';
  //brands
  static const getBrandsUrl = '$baseUrl/top-brands';
  //settings
  static const getSettingsUrl = '$baseUrl/general-setting';
  //cart
  static const getCartUrl = '$baseUrl/cart';
  static const addCartUrl = '$baseUrl/cart';
  static const cartSummeryUrl = '$baseUrl/cart-summary';

  //coupons
  static const getCouponsUrl = '$baseUrl/apply-coupon';
  static const removeCouponsUrl = '$baseUrl/remove-coupon';

  //orders
  static const getOrdersUrl = '$baseUrl/orders';
  static const getOrderBuyerUrl = '$baseUrl/orders/buyer';

  //services
  static const getServicesUrl = '$baseUrl/services';
  static const getJoinOurTeamUrl = '$baseUrl/join-our-team';
  static const getMediaUrl = '$baseUrl/media';
  static const homeBannerUrl = '$baseUrl/home-banner';
  //about us
  static const aboutUsUrl = '$baseUrl/about-us';

  // media center
  static const getOurMission = '$baseUrl/our-mission';
  static const courseAndPrograms = '$baseUrl/course-and-programs';
  static const getOurGoals = '$baseUrl/our-goals';
  static const getOurTeam = '$baseUrl/our-team';
  //suppliers
  static const getSuppliersUrl = '$baseUrl/suppliers';
  static const getSupplierDetailsUrl = '$baseUrl/supplier-details';
  static const getSupplierProductsUrl = '$baseUrl/supplier-products/';

  //supplier login page
  static const supplierBanner = '$baseUrl/supplier-banner';
  static const supplierWhyUs = '$baseUrl/why-us';
  static const supplierProductVideo = '$baseUrl/product-video';
  static const supplierFaqs = '$baseUrl/supplier-faqs';

  //queries
  static const getQueriesUrl = '$baseUrl/customer-queries';
  static const postQueriesUrl = '$baseUrl/customer-queries/store';
  static const showQueriesDataUrl = '$baseUrl/customer-queries/show/';
  static const deleteQueriesDataUrl = '$baseUrl/customer-queries/destroy/';
  static const updateQueriesDataUrl = '$baseUrl/customer-queries/update/';

  //supports
  static const getSupportsTicketUrl = '$baseUrl/support-tickets';
  static const postSupportsTicketUrl = '$baseUrl/support-tickets/store';
  static const showSupportsTicketUrl = '$baseUrl/support-tickets/show/';
  static const deleteSupportsTicketUrl = '$baseUrl/support-tickets/destroy/';
  static const updateSupportsTicketUrl = '$baseUrl/support-tickets/update/';

  //contact us
  static const contactUsUrl = '$baseUrl/contact-us';
}
