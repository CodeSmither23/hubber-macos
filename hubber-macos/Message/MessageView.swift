//
//  CustomMessageView.swift
//  hubber-macos
//
//  Created by Cosmin Cosan - work on 05.02.2025.
//

import SwiftUI

struct CustomMessageView: View {
    let message: Message
    @Binding var isEditing: Bool
    @Binding var isExpanded: Bool
    
    let onDelete: (_ message: Message) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            topView
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Willy Hobs")
                        .multilineTextAlignment(.leading)
                        .bold()
                    
                    Text("Hey, wanna join me for a coffee? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(isExpanded ? nil : 2)
                    
                    Text("2 more messages from Willy")
                        .font(.caption)
                        .opacity(0.3)
                        .padding(.top, 4)
                }
                
                Spacer()
            }
        }
        .padding([.horizontal, .bottom], 10)
        .background(.ultraThinMaterial.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//MARK: - view components
extension CustomMessageView {
    private var topView: some View {
        HStack {
            iconView
            titleView
            Spacer()
            timeView
            
            if isEditing {
                deleteButton
            }
        }
        .padding(.top, 10)
        .background(.ultraThinMaterial)
    }
    
    private var iconView: some View {
        Image(message.icon)
            .resizable()
            .frame(width: 20, height: 20)
    }
    
    private var titleView: some View {
        Text(message.title)
            .multilineTextAlignment(.leading)
    }
    
    private var timeView: some View {
        Text(message.timeString)
            .font(.callout)
    }
    
    private var deleteButton: some View {
        Button {
            onDelete(message)
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.horizontal, 10)
    }
}

//MARK: - preview
#Preview("CustomMessageView") {
//    VStack {
        CustomMessageView(
            message: Message.linkedin,
            isEditing: .constant(false),
            isExpanded: .constant(true),
            onDelete: { _ in }
        )
//        
//        CustomMessageView(
//            message: Message.telegram,
//            isEditing: .constant(true),
//            onDelete: { _ in }
//        )
//        
//        CustomMessageView(
//            message: Message.whatsapp,
//            isEditing: .constant(false),
//            onDelete: { _ in }
//        )
//    }
//    .padding(.vertical)
}
