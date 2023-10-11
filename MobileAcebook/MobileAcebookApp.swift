//
//  MobileAcebookApp.swift
//  MobileAcebook
//
//  Created by Josué Estévez Fernández on 30/09/2023.
//

import SwiftUI

@main
struct MobileAcebookApp: App {
    
    init() {
        printFonts()
      }
      func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
          print("-----")
          print("Font Family name -> [\(familyName)]")
          let names = UIFont.fontNames(forFamilyName: familyName)
          print("Font name => [\(names)] ")
        }
      }
    
    var body: some Scene {
        WindowGroup {
//            WelcomePageView()
            NewPostView()
        }
    }
}
