import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload profile image
  Future<String?> uploadProfileImage(XFile? imageFile,String username) async {
    try {

      // make a unique name for each image using the username
      final imageName =
          '${username}_${DateTime.now().millisecondsSinceEpoch}';
      //Get a reference to storage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      //Get a reference to profile_image directory
      Reference referenceDirImages = referenceRoot.child('profile_images');
      //Create a reference for the image to be stored
      Reference referenceImageToUpload = referenceDirImages.child(imageName);
      if(imageFile != null){
        //Store the file
        await referenceImageToUpload.putFile(File(imageFile.path));
        //Success: get the download URL
        String imageUrl = await referenceImageToUpload.getDownloadURL();
        return imageUrl;
      }else{
        print('Image not picked');
        return null;
      }

    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  // Retrieve profile image URL
  Future<String?> getProfileImageUrl(String email) async {
    try {

      final storageRef = _storage.ref().child('profile_images/$email');
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;

    } catch (e) {
      print('Error retrieving profile image URL: $e');
    }
    return null;
  }
}

/*
 * Step 1. Pick/Capture an image   (image_picker)
 * Step 2. Upload the image to Firebase storage
 * Step 3. Get the URL of the uploaded image
 * Step 4. Store the image URL inside the corresponding document of the database.
 * Step 5. Display the image on the list
 *
 * * */


