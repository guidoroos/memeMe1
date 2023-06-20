//
//  RenderView.swift
//  MemeMe1
//
//  Created by Guido Roos on 20/06/2023.
//

import Foundation
import SwiftUI


struct RenderView: View {
    let image:UIImage
    let topText: String
    let bottomText:String

    var body: some View {
        ZStack() {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.horizontal)
            
            VStack(alignment:.center) {
                Text(topText)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .font(Font.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .multilineTextAlignment(.center)
                Spacer()
                Text(bottomText)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .font(Font.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .multilineTextAlignment(.center)
            }
        }
    }
    }




struct RenderView_Previews: PreviewProvider {
    static var previews: some View {
        RenderView(
            image: UIImage(systemName: "person.fill")!,
            topText: "Top",
            bottomText: "Bottom"
        )
    }
}
