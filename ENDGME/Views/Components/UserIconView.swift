// Views/Components/UserIconView.swift

import SwiftUI

struct UserIconView: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width:  30, height:  30)
            .foregroundColor(.white)
            .onTapGesture {
                // Implement user profile or logout action
            }
    }
}

struct UserIconView_Previews: PreviewProvider {
    static var previews: some View {
        UserIconView()
    }
}
