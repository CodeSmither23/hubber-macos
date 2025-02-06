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
    @State private var arrowOpacity = 1.0
    @State private var animationAmount = 1.0

    var body: some View {
        VStack(spacing: .zero) {
            topView
            Divider()
            
            if items.isEmpty {
                placeholderView
            } else {
                baseContentView
            }
            
            bottomView
        }
        .frame(width: 400)
    }
}

//MARK: - view components
extension MenuBarView {
    private var baseContentView: some View {
        ScrollView(showsIndicators: false) {
            ForEach(items, id: \.id) { messageItem in
                ZStack(alignment: .trailing) {
                    CustomMessageView(
                        message: messageItem,
                        isExpanded: .constant(false)
                    )
                    
                    if isEditing {
                        deleteButton(with: messageItem)
                    }
                }
                
                if messageItem == items.last {
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
        .frame(minHeight: 350)
        .padding(.horizontal, 8)
        .padding(.top, 10)
    }
    
    private func deleteButton(with message: Message) -> some View {
        Button {
            items = items.filter{ $0 != message }
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.red)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.trailing, 20)
    }
    
    private var topView: some View {
        HStack(spacing: .zero) {
            Text("Hubber")
                .font(.title2)
                .opacity(0.1)
                .padding(.leading, 5)
            
            Spacer()
            
            if !items.isEmpty {
                editButton
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 5)
    }
    
    private var editButton: some View {
        Button {
            withAnimation(.default.speed(6)) {
                isEditing.toggle()
            }
        } label: {
            Text(isEditing ? "Done" : "Edit")
                .padding(.horizontal)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private var bottomView: some View {
        VStack(spacing: .zero) {
            Divider()
            addAccountButton
            
            HStack(spacing: 20) {
                rateUsButton
                Divider()
                quitButton
            }
            .frame(height: 30)
            .padding(.bottom, 5)
        }
    }
    
    private var placeholderView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(.userIcon)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .foregroundStyle(.blue)
            
            Text("Please add an account by pressing on the button below!")
                .multilineTextAlignment(.center)
                .font(.callout)
            
            Image(.arrowPointingDown)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundStyle(.cyan)
                .opacity(arrowOpacity)
                .offset(y: animationAmount)
                .onAppear {
                    withAnimation {
                        animateArrow()
                    }
                }
            
            Spacer()
        }
    }
    
    private func animateArrow() {
        guard animationAmount < 40 else {
            animateArrow2()
            return
        }
        animationAmount += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
            animateArrow()
        }
    }
    
    private func animateArrow2() {
        guard animationAmount > 1 else {
            animateArrow()
            return
        }
        
        animationAmount -= 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
            animateArrow2()
        }
    }
    
    private func resetAnimation() {
        animationAmount = 0
        arrowOpacity = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            arrowOpacity = 1
            animateArrow()
        }
    }
    
    private var addAccountButton: some View {
        Button {
            items.append(.linkedin)
        } label: {
            Text("Add an account")
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.vertical, 15)
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






struct ToDoItemModel {
    var id = UUID()
    var color : Color
}

struct ToDoItemView : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.clear)
            .frame(height: 40)
    }
}


struct ContentView : View {
    @State private var stacked = true
    
    var todos : [ToDoItemModel] = [
        .init(color: .green),
        .init(color: .pink),
        .init(color: .orange),
        .init(color: .blue)
    ]
    
    func offsetForIndex(_ index : Int) -> CGFloat {
        CGFloat((todos.count - index - 1) * (stacked ? 4 : 45))
    }
    
    private var stackHeight : CGFloat {
        stacked ? CGFloat(40 + todos.count * 4) : CGFloat(todos.count * 45)
    }
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ForEach(Array(todos.reversed().enumerated()), id: \.1.id) { (index, item) in
                    ToDoItemView()
                        .background(item.color)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .offset(x: 0, y: offsetForIndex(index))
                        .zIndex(Double(index))
                }
            }
            .frame(height: stackHeight)
            Spacer()
        }
        .onTapGesture {
            withAnimation {
                stacked.toggle()
            }
        }
    }
}

#Preview("gg") {
    ContentView()
}
