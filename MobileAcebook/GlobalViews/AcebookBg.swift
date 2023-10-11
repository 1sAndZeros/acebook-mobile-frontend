//
//  AcebookBg.swift
//  MobileAcebook
//
//  Created by Rikie Patrick on 11/10/2023.
//

import SwiftUI

struct AcebookBg: View {
    var body: some View {
        LinearGradient(colors: [Color("Secondary"), Color("Primary"), Color("Primary")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct AcebookBg_Previews: PreviewProvider {
    static var previews: some View {
        AcebookBg()
    }
}
