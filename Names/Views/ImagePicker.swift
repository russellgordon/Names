//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Russell Gordon on 2021-04-18.
//

import Foundation
import SwiftUI

/*
 Full explanation here:
 
 https://www.hackingwithswift.com/books/ios-swiftui/importing-an-image-into-swiftui-using-uiimagepickercontroller
 
 Tip: This ImagePicker view is completely reusable – you can put this Swift file to one side and use it on other projects easily. If you think about it, all the complexity of wrapping the view is contained inside ImagePicker.swift, which means if you do choose to use it elsewhere it’s just a matter of showing a sheet and binding an image.
 
 */
struct ImagePicker: UIViewControllerRepresentable {
    
    // Whether to show the image picker or not
    @Environment(\.presentationMode) var presentationMode
    
    // The image that we will send back to SwiftUI
    @Binding var image: UIImage?
    
    // Acts as a delegate for UIImagePickerController
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        // This co-ordinator's parent is the ImagePicker structure – we need a connection to the parent to send the image back up to SwiftUI through the property wrapped with @Binding
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // Triggered when the user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // Set the selected image as the ImagePicker (the parent's) image
            // This in turn gets sent back to SwiftUI
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            // Dismiss the image picker
            parent.presentationMode.wrappedValue.dismiss()
            
        }
    }

    // Designate this instance of ImagePicker as the parent for the Co-ordinator class instance
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        // Make an image picker controller
        let picker = UIImagePickerController()
        
        //  tell the UIImagePickerController that when something happens it should tell our coordinator
        picker.delegate = context.coordinator
        
        // Send back the image picker
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

