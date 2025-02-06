//
//  MenuBarView.swift
//  hubber-macos
//
//  Created by Cosmin Cosan - work on 04.02.2025.
//

import SwiftUI

struct MenuBarView: View {
    @State var items: [Message] = [.linkedin, .telegram, .whatsapp]
    @State var isEditing = false
    
    var body: some View {
        VStack(spacing: .zero) {
            topView
            baseContentView
            bottomView
        }
        .padding(.horizontal, 5)
    }
}

//MARK: - view components
extension MenuBarView {
    private var baseContentView: some View {
        ScrollView(showsIndicators: false) {
//            VStack(spacing: 10) {
                ForEach(items, id: \.id) { item in
                    CustomMessageView(
                        message: item,
                        isEditing: $isEditing,
                        isExpanded: .constant(false),
                        onDelete: { message in
                            items = items.filter({ $0 != message })
                        }
                    )
                }
//            }
        }
        .frame(minWidth: 350, minHeight: 350)
//        .overlay(alignment: .bottom, content: {
//            shadowView
//        })
    }
    
//    @ViewBuilder
//    private var shadowView: some View {
//        Rectangle()
//            .fill(.gray.opacity(0.2))
//            .frame(height: 21)
//            .shadow(color: .gray, radius: 8, x: 0, y: 3)
//    }
    
    private var topView: some View {
        HStack(spacing: .zero) {
            Text("Hubber")
                .font(.title2)
                .opacity(0.1)
            
            Spacer()
            
            editButton
        }
    }
    
    private var editButton: some View {
        Button {
            withAnimation(.default.speed(6)) {
                isEditing.toggle()
            }
        } label: {
            Text(isEditing ? "Done" : "Edit")
                .padding()
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private var bottomView: some View {
        VStack(spacing: .zero) {
            addAccountButton
            
            HStack(spacing: 20) {
                rateUsButton
                Divider()
                quitButton
            }
            .frame(height: 30)
        }
        .padding(.vertical, 5)
    }
    
    private var addAccountButton: some View {
        Button {
            items.append(.linkedin)
        } label: {
            Text("Add an account")
        }
        .padding()
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private var rateUsButton: some View {
        Button {
            
        } label: {
            Text("Rate us")
                .padding()
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private var quitButton: some View {
        Button {
            NSApplication.shared.terminate(nil)
        } label: {
            Text("Quit")
                .padding()
        }
        .buttonStyle(BorderlessButtonStyle())
        //        .keyboardShortcut("q")
    }
}

//    private var firstButton: some View {
//        Button("Sign in") {
//
//        }
//        .keyboardShortcut("1")
//    }
//
//    private var secondButton: some View {
//        Button("Sign out") {
//            currentNumber = "2"
//        }
//        .keyboardShortcut("2")
//    }

//MARK: - preview
#Preview("MenuBarView") {
    MenuBarView()
}
