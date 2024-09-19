//
//  ProfileScreen.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-19.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) var dismiss

    @State private var firstName = "Nanda Win"
    @State private var lastName = "Kyu"
    @State private var email = "abc@xyz.com"
    @State private var age = "25"
    @State private var gender = Gender.male
    @State private var isPresentGenderPicker = false

    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.bottom, 30)

                CustomTextField(value: $firstName, label: .first_name)

                CustomTextField(value: $lastName, label: .last_name)

                CustomTextField(value: $email, label: .email, keyboardType: .emailAddress)

                CustomTextField(value: $age, label: .age, keyboardType: .numberPad)

                VStack(alignment: .leading) {
                    Text("Gender")
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Button {
                        isPresentGenderPicker.toggle()
                    } label: {
                        Text(gender.rawValue.capitalized)
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.blueBG)
                            .clipShape(.rect(cornerRadius: 18))
                    }
                }
            }
            .padding()
            .navigationTitle(.title_profile)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundStyle(.appPrimary)
                    }
                }
            }
            .sheet(isPresented: $isPresentGenderPicker) {
                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) { item in
                        Text(item.rawValue.capitalized)
                            .fontWeight(.medium)
                    }
                }
                .pickerStyle(.wheel)
                .presentationDetents([.height(200)])
            }
        }
    }
}

enum Gender: String, CaseIterable {
    case male
    case female
    case other
}

#Preview {
    NavigationStack {
        ProfileScreen()
            .environmentObject(UserPreferences())
    }
}
