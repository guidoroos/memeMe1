//
//  ImagePickerController.swift
//  MemeMe1
//
//  Created by Guido Roos on 18/06/2023.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
    
    static func isCameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func makeCoordinator() -> Coordinator {
        ImagePickerCoordinator(onImagePicked: onImagePicked)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let onImagePicked: (UIImage) -> Void
    
    init(onImagePicked: @escaping (UIImage) -> Void) {
        self.onImagePicked = onImagePicked
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            onImagePicked(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
