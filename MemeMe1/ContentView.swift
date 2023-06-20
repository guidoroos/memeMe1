//
//  ContentView.swift
//  MemeMe1
//
//  Created by Guido Roos on 18/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showImagePicker = false
    @State private var showCamera = false
    @State private var showShareSheet = false
    
    @State private var selectedImage: UIImage?
    @State private var memeImage: UIImage?
    
    @State private var showToolbar = true
    
    @State private var topText: String = "Top"
    @State private var bottomText: String = "Bottom"
    
    
    init() {
        UIToolbar.changeAppearance(color: UIColor.gray.withAlphaComponent(0.05)
        )
    }
    
    var body: some View {
        ZStack() {
            if let image = selectedImage {
                
                GeometryReader { geometry in
                    
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.horizontal)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            
            VStack(alignment:.center) {
                CustomTextField( text: $topText)
                    .disabled(selectedImage == nil)
                Spacer()
                CustomTextField(text: $bottomText)
                    .disabled(selectedImage == nil)
            }
        }.background(Color.black)
            .onChange(of: memeImage) { value in
                showShareSheet = true
            }
        
            .toolbar {
                if showToolbar {
                    CustomToolbarContent(
                        selectedImage: $selectedImage,
                        topText: $topText,
                        bottomText: $bottomText,
                        showCamera: $showCamera,
                        showImagePicker: $showImagePicker,
                        onClickShare: {
                            memeImage = generateMemedImage()
         
                        }
                    )
                }
            }
        
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    selectedImage = image
                }
            }
            .sheet(isPresented: $showCamera) {
                ImagePicker(sourceType: .camera) { image in
                    selectedImage = image
                }
            }
            .sheet(
                isPresented: $showShareSheet
            ) {
                                if let memeImage = memeImage {
                                    ShareSheet(activityItems: [memeImage])
                                }
                
            }
    }
    
    func generateMemedImage() -> UIImage {
        //no idea on how to only do this rendering after hiding toolbar is applied to UI

        let renderer = UIGraphicsImageRenderer(size: UIScreen.main.bounds.size)
        
        let image = renderer.image { _ in
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let window = windowScene.windows.first {
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }
        }
        
        return image
        
    }
    
}

struct CustomToolbarContent: ToolbarContent {
    @Binding var selectedImage: UIImage?
    @Binding var topText: String
    @Binding var bottomText: String
    @Binding var showCamera: Bool
    @Binding var showImagePicker:Bool
    var onClickShare: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(
            placement: .cancellationAction
        ) {
            Button(action: onClickShare ) {
                Image(systemName: "square.and.arrow.up")
                    .disabled(selectedImage ==  nil)
            }
        }
        
        ToolbarItem(
            placement: .confirmationAction
        ) {
            Button(action: {
                selectedImage = nil
                topText = "Top"
                bottomText = "Bottom"
            }) {
                Text("Cancel")
            }
            .disabled(selectedImage == nil)
        }
        
        ToolbarItem(
            placement: .bottomBar
        ) {
            HStack(spacing: 40) {
                Button(action: { showCamera = true }) {
                    Image(systemName: "camera.fill")
                        .foregroundColor(Color.gray)
                }
                .disabled(!ImagePicker.isCameraAvailable())
                
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Album")
                }
                
            }
        }
    }
}

struct CustomTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(DefaultTextFieldStyle())
            .padding()
            .foregroundColor(.white)
            .shadow(color: .black, radius: 3)
            .font(Font.custom("HelveticaNeue-CondensedBlack", size: 40))
            .multilineTextAlignment(.center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
