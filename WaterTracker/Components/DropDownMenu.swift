//
//  DropDownMenu.swift
//  WaterTracker
//
//  Created by Nanda WK on 2024-09-17.
//

import SwiftUI

struct  DropDownMenu: View {

    let options: [String]

    var menuWdith: CGFloat  =  150
    var buttonHeight: CGFloat  =  50
    var maxItemDisplayed: Int  =  3

    @Binding  var selectedOptionIndex: Int
    @Binding  var showDropdown: Bool

    @State  private  var scrollPosition: Int?

    var body: some  View {

        VStack {

            VStack(spacing: 0) {
                if (showDropdown) {
                    let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }

                                }, label: {
                                    HStack {
                                        Text(options[index])
                                        Spacer()
                                        if (index == selectedOptionIndex) {
                                            Image(systemName: "checkmark.circle.fill")

                                        }
                                    }

                                })
                                .padding(.horizontal, 20)
                                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)

                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <=  3)
                    .frame(height: scrollViewHeight)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }

                }
                // selected item
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack(spacing: nil) {
                        Text("Unit: \(options[selectedOptionIndex])")
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                    }
                })
                .padding(.horizontal, 20)
                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)

            }
            .foregroundStyle(.textBlack)
            .background(RoundedRectangle(cornerRadius: 10).fill(.textWhite))

        }
        .frame(width: menuWdith, height: buttonHeight, alignment: .bottom)
        .zIndex(100)

    }
}

#Preview {
    let fruits = ["Number of glass", "Number of ml"]
    DropDownMenu(options: fruits, selectedOptionIndex: .constant(0), showDropdown: .constant(true))
}
