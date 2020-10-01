
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeDetectorMachine {

   Future<PickedFile> pickImage()async{
     var picker = ImagePicker();
      PickedFile pickedImage= await picker.getImage(source: ImageSource.camera);

      return pickedImage;
   }

   final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
  Future<Map> detectBarcodes()async{
    final FirebaseVisionImage visionImage =
    //FirebaseVisionImage.fromBytes(await pickImage(),null);
    FirebaseVisionImage.fromFile(File((await pickImage()).path));


    final List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);

    for (Barcode barcode in barcodes) {

      final Rect boundingBox = barcode.boundingBox;
      final List<Offset> cornerPoints = barcode.cornerPoints;

      final String rawValue = barcode.rawValue;

      final BarcodeValueType valueType = barcode.valueType;

      // See API reference for complete list of supported types
      String result = '';
      switch (valueType) {
        case BarcodeValueType.wifi:
          final String ssid = barcode.wifi.ssid;
          final String password = barcode.wifi.password;
          final BarcodeWiFiEncryptionType type = barcode.wifi.encryptionType;
          result = 'Wifi - ssid = $ssid  and password = $password';
          break;
        case BarcodeValueType.url:
          final String title = barcode.url.title;
          final String url = barcode.url.url;
          result = 'Url - title = $title  and url = $url';
          break;
        case BarcodeValueType.unknown:
          result = 'The barcode is unknown';
          break;
        case BarcodeValueType.contactInfo:
           var number= barcode.contactInfo.phones;
           var name= barcode.contactInfo.name;
          result = 'Contact - Name - $name -Numbers - $number';
          break;
        case BarcodeValueType.email:
          String address = barcode.email.address;
          result = 'Email - Address - $address ';
          break;
        case BarcodeValueType.isbn:
          var isbn = barcode.displayValue;
          result = 'Isbn - Barcode - $isbn';
          break;
        case BarcodeValueType.phone:
           var number= barcode.phone.number;
         result = 'Number = $number';
          break;
        case BarcodeValueType.product:

          result = 'Its a product and ${barcode.displayValue}';
          break;
        case BarcodeValueType.sms:
           var message = barcode.sms.message;
           var phone = barcode.sms.phoneNumber;
          result = 'sms -from $phone with a message -$message ';
          break;
        case BarcodeValueType.text:

          result = 'Its a text and ${barcode.displayValue}';
          break;
        case BarcodeValueType.geographicCoordinates:
          print('geographicCoordinates');
          break;
        case BarcodeValueType.calendarEvent:
           var summary= barcode.calendarEvent.summary;
          result = 'calendarEvent  - Summary - $summary';
          break;
        case BarcodeValueType.driverLicense:
          var firstName  = barcode.driverLicense.firstName;
          var lastName  = barcode.driverLicense.lastName;
          var middleName  = barcode.driverLicense.middleName;
          var birthDate  = barcode.driverLicense.birthDate;
          var gender  = barcode.driverLicense.gender;
          var city  = barcode.driverLicense.addressCity;

          result = 'driverLicense of $firstName $middleName $lastName \n born on $birthDate. The Gender is $gender and lives in $city';
          break;
      }

      barcodeDetector.close();
      return {'result':result,'display value':barcode.displayValue};
    }
  }

}
