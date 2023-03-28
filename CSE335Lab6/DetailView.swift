//
//  DetailView.swift
//  CSE335Lab6
//
//  Created by Arjun Dadhwal on 3/27/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var picture:Data
    var name:String

    var description:String
    
    var body: some View {
        Text(name).font(.system(size: 36))
        Image(uiImage: UIImage(data:(picture ?? Data())) ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
    Text(description)
    }
}

/*struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
       // DetailView(picture:"Hi", name:"Hi", description:"A")
    }*/
//}
