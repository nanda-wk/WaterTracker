//
//  CustomTextField.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-19.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var value: String
    let label: LocalizedKey
    var keyboardType: UIKeyboardType = .default
    var error: LocalizedKey?

    var body: some View {
        VStack(alignment: .leading) {
            LocalizedText(label)
                .font(.subheadline)
                .fontWeight(.medium)

            TextField("", text: $value)
                .padding()
                .background(.blueBG)
                .clipShape(.rect(cornerRadius: 18))
                .keyboardType(keyboardType)

            if let error = error {
                LocalizedText(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    CustomTextField(value: .constant(""), label: .first_name, error: .error_textfield_blank)
        .environmentObject(UserPreferences())
}
