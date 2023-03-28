//
//  DetailView.swift
//  CSE335Lab6
//
//  Created by Arjun Dadhwal on 3/27/23.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var picture:String
    var name:String
    var description:UIImage
    
    var body: some View {
        Text(name).font(.system(size: 36))
    Text(picture)
    Text(description)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(picture:"Hi", name:"Hi", description:"A")
    }
}
