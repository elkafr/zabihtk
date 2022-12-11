import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zabihtk/l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  String get languageSymbol {
    return Intl.message('Language Symbol');
  }

  String get ourVision {
    return Intl.message('Our Vision');
  }

  String get next {
    return Intl.message('Next');
  }

  String get previous {
    return Intl.message('Previous');
  }

  String get finish {
    return Intl.message('Finish');
  }

  String get login {
    return Intl.message('Login');
  }

  String get email {
    return Intl.message('Email');
  }

  String get password {
    return Intl.message('Password');
  }

  String get forgetPassword {
    return Intl.message('Forget Password');
  }

  String get clickHere {
    return Intl.message('Click Here');
  }

  String get hasAccount {
    return Intl.message('Has Account');
  }

  String get register {
    return Intl.message('Register');
  }

  String get skip {
    return Intl.message('Skip');
  }

  String get phonoNoValidation {
    return Intl.message('Phone No Validation');
  }

  String get emailValidation {
    return Intl.message('Email Validation');
  }

  String get passwordValidation {
    return Intl.message('Password Validation');
  }

  String get name {
    return Intl.message('Name');
  }

  String get nameValidation {
    return Intl.message('Name Validation');
  }

  String get passwordVerify {
    return Intl.message('Password Verify');
  }

  String get passwordVerifyValidation {
    return Intl.message('Password Verify Validation');
  }

  String get passwordNotIdentical {
    return Intl.message('Password Not Identical');
  }

  String get phoneNo {
    return Intl.message('Phone No');
  }

  String get iAccept {
    return Intl.message('I Accept');
  }

  String get terms {
    return Intl.message('Terms');
  }

  String get sendMessageToMobile {
    return Intl.message('Send Message To Mobile');
  }

  String get save {
    return Intl.message('Save');
  }

  String get send {
    return Intl.message('Send');
  }

  String get acceptTerms {
    return Intl.message('Accept Terms');
  }

  String get codeToRestorePassword {
    return Intl.message('Code To Restore Password');
  }

  String get enterCodeToRestorePassword {
    return Intl.message('Enter Code To Restore Password');
  }

  String get restorePassword {
    return Intl.message('Restore Password');
  }

  String get confirmNewPassword {
    return Intl.message('Confirm New Password');
  }

  String get accountActivationCode {
    return Intl.message('Account Activation Code');
  }

  String get enterCodeToActivateAccount {
    return Intl.message('Enter Code To Activate Account');
  }

  String get confirmationOfActivation {
    return Intl.message('Confirmation Of Activation');
  }

  String get home {
    return Intl.message('Home');
  }

  String get orders {
    return Intl.message('Odrers');
  }

  String get favourite {
    return Intl.message('Favourite');
  }

  String get cart {
    return Intl.message('Cart');
  }

  String get account {
    return Intl.message('Account');
  }

  String get personalInfo {
    return Intl.message('Personal Info');
  }

  String get about {
    return Intl.message('About');
  }

  String get contactUs {
    return Intl.message('Contact Us');
  }

  String get language {
    return Intl.message('Language');
  }

  String get logOut {
    return Intl.message('Log out');
  }

  String get enter {
    return Intl.message('Enter');
  }

  String get editInfo {
    return Intl.message('Edit Info');
  }

  String get editPassword {
    return Intl.message('Edit Password');
  }

  String get oldPassword {
    return Intl.message('Old Password');
  }

  String get newPassword {
    return Intl.message('New  Password');
  }

  String get messageTitle {
    return Intl.message('Message Title');
  }

  String get messageDescription {
    return Intl.message('Message Description');
  }

  String get textValidation {
    return Intl.message('Text Validation');
  }

  String get or {
    return Intl.message('OR');
  }

  String get arabic {
    return Intl.message('Arabic');
  }

  String get english {
    return Intl.message('English');
  }

  String get wantToLogout {
    return Intl.message('Want to logout ?');
  }

  String get ok {
    return Intl.message('Ok');
  }

  String get cancel {
    return Intl.message('Cancel');
  }

  String get baladiaTuraif {
    return Intl.message('Baladia Turaif');
  }

  String get aouonTuraif {
    return Intl.message('Aouon Turaif');
  }

  String get search {
    return Intl.message('Search');
  }

  String get noResults {
    return Intl.message('No Results');
  }

  String get noDepartments {
    return Intl.message('No Departments');
  }

  String get sr {
    return Intl.message('SR');
  }

  String get addToCart {
    return Intl.message('Add To Cart');
  }

  String get productDetails {
    return Intl.message('Product Details');
  }

  String get allProductDetails {
    return Intl.message('All Product Details');
  }

  String get firstLogin {
    return Intl.message('First Login');
  }

  String get productsNo {
    return Intl.message('Products No');
  }

  String get totalPrice {
    return Intl.message('Total Price');
  }

  String get applicationValue {
    return Intl.message('Application Value');
  }

  String get completePurchase {
    return Intl.message('Complete Purchase');
  }

  String get amount {
    return Intl.message('Amount');
  }

  String get purchaseRequestHasSentSuccessfully {
    return Intl.message('Purchase Request Has sent Successfully');
  }

  String get waiting {
    return Intl.message('Waiting');
  }

  String get processing {
    return Intl.message('Processing');
  }

  String get done {
    return Intl.message('Done');
  }

  String get canceled {
    return Intl.message('Canceled');
  }

  String get orderDetails {
    return Intl.message('Order Details');
  }

  String get cancelOrder {
    return Intl.message('Cancel Order');
  }

  String get wantToCancelOrder {
    return Intl.message('Want To Cancel Order?');
  }

  String get wantToBeginOrder {
    return Intl.message('هل تريد بدء توصيل الطلب ؟');
  }

  String get wantToEndOrder {
    return Intl.message('هل تريد تأكيد توصيل الطلب ؟');
  }

  String get orderNo {
    return Intl.message('Order No');
  }

  String get store {
    return Intl.message('Store');
  }

  String get orderPrice {
    return Intl.message('Order Price');
  }

  String get orderDate {
    return Intl.message('Order Date');
  }

  String get orderReceiptTime {
    return Intl.message('Order Receipt Time');
  }

  String get orderStatus {
    return Intl.message('Order Status');
  }

  String get editOrder {
    return Intl.message('Edit Order');
  }

  String get saveChanges {
    return Intl.message('Save Changes');
  }

  String get addNewProduct {
    return Intl.message('Add New Product');
  }

  String get addToOrder {
    return Intl.message('AddToOrder');
  }

  String get noResultIntoCart {
    return Intl.message('No Result Into Cart');
  }

  String get sorry {
    return Intl.message('Sorry');
  }

  String get updateScreen {
    return Intl.message('update screen');
  }

  String get reconnectInternet {
    return Intl.message('reconnect Internet');
  }

  String get scanRouter {
    return Intl.message('scan Router');
  }

  String get sorryNoInternet {
    return Intl.message('sorryNoInternet');
  }

  String get notifications {
    return Intl.message('Notifications');
  }

  String get activateCode {
    return Intl.message('activate Code');
  }

  String get activation {
    return Intl.message('Activation');
  }

  String get fromStore {
    return Intl.message('From Store');
  }

  String get noNotifications {
    return Intl.message('No Notifications');
  }

  String get customerOpinions {
    return Intl.message('Customer Opinions');
  }

  String get bankAccounts {
    return Intl.message('Bank Accounts');
  }

  String get sacrificeDescription {
    return Intl.message('Sacrifice Description');
  }

  String get size {
    return Intl.message('Size');
  }

  String get number {
    return Intl.message('Number');
  }

  String get anotherOptions {
    return Intl.message('Another Options');
  }

  String get total {
    return Intl.message('Total');
  }

  String get croping {
    return Intl.message('Croping');
  }

  String get encupsulation {
    return Intl.message('Encapsulation');
  }

  String get headAndSeat {
    return Intl.message('Head And Seat');
  }

  String get rumenAndInsistence {
    return Intl.message('Rumen And Insistence');
  }

  String get confirmOrder {
    return Intl.message('Confirm Order');
  }

  String get delete {
    return Intl.message('Delete');
  }

  String get detect {
    return Intl.message('Detect');
  }

  String get detectLocation {
    return Intl.message('Detect Location');
  }

  String get enterPhoneNo {
    return Intl.message('Enter Phone No');
  }

  String get current {
    return Intl.message('Current');
  }

  String get addRate{
    return Intl.message('Add Rate');
  }

  String get addYourRateNow{
    return Intl.message('Add Your Rate Now');
  }

   String get rateNow{
    return Intl.message('Rate Now');
  }


   String get accountOwner{
    return Intl.message('Account Owner');
  }

   String get iban{
    return Intl.message('IBAN');
  }

   String get accountNumber{
    return Intl.message('Account Number');
  }


 String get addYourExperience{
    return Intl.message('Add Your Experience');
  }

   String get addNow{
    return Intl.message('Add Now');
  }

  String  get city{
 return Intl.message('City');
}

 String get cityValidation {
    return Intl.message('City Validation');
  }


 String get createAccount {
    return Intl.message('Create Account');
  }



 String get writeCodeHere{
    return Intl.message('Write Code Here');
  }

String get notReachAndResend{
  return Intl.message('Not Reach....Resend');
}

String get sendRetrievalCode{
  return Intl.message('Send Retrieval Code');
}

String get enterPhoneNumberToSendPasswordRecoveryCode{
  return Intl.message('Enter Phone Number To Send Password Recovery Code');
}

String get codeActivationValidation{
  return Intl.message('Code Activation Validation');
}

String get changePasswordToRestoreItNow{
  return Intl.message('Change Password To Restore It Now');
}

String get detectYourLocation{
  return Intl.message('Detect Your Location');
}

String get confirmLocation{
  return Intl.message('Confirm Location');
}

String get pleaseEnterYourLocation{
  return Intl.message('Please Enter Your Location');
}

String get congratulation{
  return Intl.message('Congratulations');
}

String get accountCreatedSuccessFully{
  return Intl.message('Account Created SuccessFully');
}

String get notFound{
  return Intl.message('Not Found');
}

String get youCanConnectWithUS{
   return Intl.message('You Can Connect With Us');
}

  String get choosePaymentMethods {
    return Intl.message('Choose Payment Methods');
  }

  String get cardsAndBankAccounts {
    return Intl.message('Cards And Bank Accounts');
  }

  String get orderConfirmation {
    return Intl.message('Order Confirmation');
  }
  

  String get paymentWhenReceiving {
    return Intl.message('Payment When Receiving');
  }

    String get bankName {
    return Intl.message('Bank Name');
  }

   String get accountnameHolder {
    return Intl.message('Account Name Holder');
  }

 String get paymentMethods {
    return Intl.message('Payment Methods');
  }

   String get  hawalaimage {
    return Intl.message('Hawala Image');
  }

    String get  notAvailableDueToPrecautionaryMeasures {
    return Intl.message('Not available due to precautionary measures');
  }

    String get  bankValidation {
    return Intl.message('Bank Validation');
  }

  
    String get  accountOwnerValidation {
    return Intl.message('Account  Owner Validation');
  }

    String get  accountNumberValidation {
    return Intl.message('Account  Number Validation');
  }

   String get  ibanValidation {
    return Intl.message('Iban Validation');
  }



  String get  changeCity {
    return Intl.message('Change city');
  }


   String get  hawalaImageValidation {
    return Intl.message('Hawala Image Validation');
  }


 String get  detectImg {
    return Intl.message('Detect Image');
  }

 String get  paymentByWireTransfer {
    return Intl.message('Payment By Wire Transfer');
  }

String get  nameOfTransferAccountHolder {
    return Intl.message('Name of the transfer account holder');
  }
  String get  accountNumberOfTransferHolder {
    return Intl.message('Account Number of the transfer holder');
  }
    String get  bankAccountDetails {
    return Intl.message('Bank Account Details');
  }

  String get  driverLogin {
    return Intl.message('Driver Login');
  }

  String get  driverAdress {
    return Intl.message('العنوان');
  }

  String get  driverDrivers {
    return Intl.message('عدد التوصيلات');
  }

  String get  clientName {
    return Intl.message('العميل');
  }

  String get  clientLocation {
    return Intl.message('الموقع');
  }

  String get  locationFollow {
    return Intl.message('تتبع موقع العميل');
  }

  String get  beginOrder {
    return Intl.message('بدء التوصيل');
  }

  String get  endOrder {
    return Intl.message('تم التوصيل');
  }

  String get  notify {
    return Intl.message('الاشعارات');
  }

  String get  cash {
    return Intl.message('كاش');
  }


  String get  visa {
    return Intl.message('دفع الكتروني');
  }


  String get  transfer {
    return Intl.message('تحويل بنكي');
  }

  String get  transferDate {
    return Intl.message('بيانات التحويل');
  }

  String get  soon {
    return Intl.message(' قريبا');
  }

  String get  clickNext {
    return Intl.message('قم بالضغط على الزرار التالى لاكمال الطلب');
  }

  String get  Deliver {
    return Intl.message('Deliver');
  }

// Please enter the account number of the transfer holder

//من فضلك ادخل اسم صاحب حساب الحوالة
/*
 من فضلك ادخل رقم حساب صاحب الحوالة 
4- من فضلك ارفق صورة الحوال
*/




}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
