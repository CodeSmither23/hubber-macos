//
//  Message.swift
//  hubber-macos
//
//  Created by Cosmin Cosan - work on 05.02.2025.
//

import Foundation
import SwiftUI

enum Message {
    case linkedin
    case telegram
    case whatsapp
    
    var id: UUID {
        UUID()
    }
    
    //    let time: CGFloat
    var timeString: String {
        "12m ago"
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .linkedin:
            "Linkedin"
        case .telegram:
            "Telegram"
        case .whatsapp:
            "Whatsapp"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .linkedin:
                .linkedinIcon
        case .telegram:
                .telegramIcon
        case .whatsapp:
                .whatsappIcon
        }
    }
}
