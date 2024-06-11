class GlobalKeys {
  static const String GOOGLE = "google.com";
  static const String BASE_URL = "transcash.technoexponent.net";
  static const String APIV1 = "/api/";
  static const String PROFILE_UPDATE = "profile/";
  static const String VERIFY_EMAIL = "sendVerifyMail/";
  static const String UPDATEPROFILE = "update-profile";

  static const String otpSendToEmailBaseUrl = "$BASE_URL+$VERIFY_EMAIL";


  static const String registration = "new_register";
  static const String logIn = "login";
  static const String userDetails = "get-user";
  static const String verifyOtp = "verify-otp";
  static const String passwordUpdate = "update-password";
  static const String profileUpdate = "$PROFILE_UPDATE$UPDATEPROFILE";
  static const String forgotPassword = "forget-password";
  static const String forgotPasswordReset = "forget-password-reset";
  static const String forgotPasswordVerifyOtp = "forget-password-verify-otp";
  static const String forgotPasswordResendOTP = "forget-password-resend-otp";
  static const String registerResendOTP = "verify-resend-otp";
  //static const String verifyNumber = "verifyUserContact";
  static const String verifyNumber = "verify-contact";
  static const String addCard = "add-card";
  static const String fetchSavedCards = "fatch-all-card";
  static const String addMoneyToWallet = "add-money";
  static const String fetchAllNotification = "all-notification";
  static const String payMoney = "pay-money";
  static const String deleteCard = "delete-card";
  static const String deleteNotification = "delete-notification";
  static const String allTransactions = "transaction-history";
  static const String userTransactionDetails = "user-transaction";
  static const String addMoneyUsingPaypal = "add-money-in-wallet";
  static const String moneyRequest = "money-withdraw";
  static const String addBank = "add-bank";
  static const String fetchSavedBanks = "fatch-all-bank";
}
