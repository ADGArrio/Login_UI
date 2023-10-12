//
//  UploadScreen.swift
//  X-RAI
//
//  Created by Arrio Gonsalves on 4/14/23.
//

import Foundation
import SwiftUI

import SwiftUI

struct UploadScreen: View {
    @State private var showImagePicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            Image(systemName: "icloud.and.arrow.up")
                .font(.system(size: 250))
            if image != nil {
                image!
                    .resizable()
                    .scaledToFit()
            } else {
                Button(action: {
                    self.showImagePicker = true
                }) {
                    Text("Upload X-Ray Image File")
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: self.$inputImage, isShown: self.$showImagePicker)
                        .onDisappear() {
                            if let inputImage = inputImage {
                                self.image = Image(uiImage: inputImage)
                            }
                        }
                }
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var isShown: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(parent: self)
    }

    class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}
