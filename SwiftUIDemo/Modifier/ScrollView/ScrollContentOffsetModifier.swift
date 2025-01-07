//
//  ScrollContentOffsetModifier.swift
//  GashTickets
//
//  Created by mike on 2024/11/11.
//

import SwiftUI

/// 滾輪位移樣式 (UIKit)
struct ScrollContentOffsetModifier: ViewModifier {
    
    @Binding var contentOffset: CGPoint?
    let animated: Bool

    func body(content: Content) -> some View {
        content
            .background {
                InternalScrollViewHelper(contentOffset: $contentOffset, animated: animated)
            }
    }
}

extension View {
    /// 滾動至指定偏移量 (現在只針對單一ScrollView做設定)
    func scrollToOffset(contentOffset: Binding<CGPoint?>, animated: Bool = false) -> some View {
        modifier(ScrollContentOffsetModifier(contentOffset: contentOffset, animated: animated))
    }
}

/// 因為綁 State 會記憶體洩漏，所以要用 class 多包一層。
class InternalScrollViewHelperModel: ObservableObject {
    
    @Published var scrollView: UIScrollView?
}

fileprivate struct InternalScrollViewHelper: UIViewRepresentable {
    
    @Binding var contentOffset: CGPoint?
    let animated: Bool
    
    @StateObject private var viewModel = InternalScrollViewHelperModel()

    func makeUIView(context: Context) -> some UIView {
        let view = ScrollViewIdentifier()
        view.scrollViewCompletion = { [weak viewModel] in
            viewModel?.scrollView = $0
        }
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let contentOffset = contentOffset {
            viewModel.scrollView?.setContentOffset(contentOffset, animated: animated)
            self.contentOffset = nil
        }
    }
}

fileprivate final class ScrollViewIdentifier: UIView {
    
    var scrollViewCompletion: ((UIScrollView) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func didMoveToWindow() {
        guard let scrollView = superview?.superview?.superview as? UIScrollView else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.scrollViewCompletion?(scrollView)
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

