#if os(macOS)
//
//  RightClickable.swift
//  Minesweeper
//
//  Created by Juan Gómez on 21/01/24.
//
import Foundation
import SwiftUI


struct RightClickableSwiftUIView: NSViewRepresentable {
    
    var mouseDownEvent: (_ type: MouseEvent) -> Void
    
    func updateNSView(_ nsView: RightClickableView, context: NSViewRepresentableContext<RightClickableSwiftUIView>) {}
    
    func makeNSView(context: Context) -> RightClickableView {
        let view = RightClickableView()
        view.delegate = context.coordinator
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(event: mouseDownEvent)
    }
}

enum MouseEvent {
    case leftClick
    case rightClick
}

class Coordinator {
    
    var event: (_ type: MouseEvent) -> Void
    
    init(event: @escaping (_ type: MouseEvent) -> Void) {
        self.event = event
    }
    
}

class RightClickableView: NSView {
    
    var delegate: Coordinator?
    
    override func mouseDown(with theEvent: NSEvent) {
        delegate?.event(.leftClick)
    }
    
    override func rightMouseDown(with theEvent: NSEvent) {
        delegate?.event(.rightClick)
    }
}
#endif
