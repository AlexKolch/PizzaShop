//
//  ImagePicker.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.11.2023.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss
    @Binding var selectedImage: UIImage
    var sourceType: UIImagePickerController.SourceType = .photoLibrary //Тип откуда брать картинку will deprecate .photoLibrary

    ///Создает и отправляет нам ImagePickerController
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self) //Отправляем в инит себя ImagePicker
    }
//Чтобы сконформить протоколу
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker //Родительская структура

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
///отвечает за перемещение картинки в @Binding var selectedImage
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.dismiss() //закрывание окна
        }
    }
}

