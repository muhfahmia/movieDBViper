//
//  UserSwiftUI.swift
//  theMovieDBViper
//
//  Created by Muhammad Fahmi on 07/10/23.
//

import SwiftUI

struct UserSwiftUI: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("fahmi", bundle: nil)
                .resizable()
                .padding()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(uiColor: .lightGrayCustom), lineWidth: 3))
                .shadow(radius: 5)
            
            Text("Muh Fahmi Ardiyanto")
                .font(.largeTitle)
            Text("Junior iOS Developer")
                .font(.body)
                .foregroundColor(.gray)
            Text("fahmiardiyannto@yahoo.com")
                .font(.headline)
            Text("+6281315656535")
                .font(.headline)
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
                .shadow(radius: 2)
                .frame(height: 220)
                VStack {
                    Text("Hellow Code Reviewers, I am a junior iOS freelance worker. Before as Junior iOS Dev I am a Web Developer for 3 years experience.")
                        .padding()
                    
                    Text("If there is any information about jobs related to iOS development, I am interested in applying for the job")
                        .padding()
                }
                            
            }
            Spacer()
        
        }
        .padding()
        .navigationBarTitle("User Profile")
    }
}

#Preview {
    UserSwiftUI()
}
