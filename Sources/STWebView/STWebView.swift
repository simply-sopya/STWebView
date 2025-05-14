

@preconcurrency import WebKit
import SwiftUI

public struct STWebView: UIViewRepresentable {
    public let url: URL

    internal var onStart: (() -> Void)? = nil
    internal var onFinish: ((URL?) -> Void)? = nil
    internal var onFail: ((Error) -> Void)? = nil
    internal var onDecidePolicy: ((URL, @escaping (WKNavigationActionPolicy) -> Void) -> Void)? = nil

    public init(url: URL) {
        self.url = url
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            onStart: onStart,
            onFinish: onFinish,
            onFail: onFail,
            onDecidePolicy: onDecidePolicy
        )
    }

    public func makeUIView(context: Context) -> WKWebView {
        let pagePrefs = WKWebpagePreferences()
        pagePrefs.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pagePrefs

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {}

    // MARK: - Modifiers

    public func onStart(_ action: @escaping () -> Void) -> STWebView {
        var copy = self
        copy.onStart = action
        return copy
    }

    public func onFinish(_ action: @escaping (URL?) -> Void) -> STWebView {
        var copy = self
        copy.onFinish = action
        return copy
    }

    public func onFail(_ action: @escaping (Error) -> Void) -> STWebView {
        var copy = self
        copy.onFail = action
        return copy
    }

    public func onDecidePolicy(_ action: @escaping (URL, @escaping (WKNavigationActionPolicy) -> Void) -> Void) -> STWebView {
        var copy = self
        copy.onDecidePolicy = action
        return copy
    }

    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        let onStart: (() -> Void)?
        let onFinish: ((URL?) -> Void)?
        let onFail: ((Error) -> Void)?
        let onDecidePolicy: ((URL, @escaping (WKNavigationActionPolicy) -> Void) -> Void)?

        init(onStart: (() -> Void)?,
             onFinish: ((URL?) -> Void)?,
             onFail: ((Error) -> Void)?,
             onDecidePolicy: ((URL, @escaping (WKNavigationActionPolicy) -> Void) -> Void)?) {
            self.onStart = onStart
            self.onFinish = onFinish
            self.onFail = onFail
            self.onDecidePolicy = onDecidePolicy
        }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                onDecidePolicy?(url, decisionHandler) ?? decisionHandler(.allow)
            } else {
                decisionHandler(.allow)
            }
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            onStart?()
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            onFinish?(webView.url)
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            onFail?(error)
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            onFail?(error)
        }

        public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
                            initiatedByFrame frame: WKFrameInfo,
                            completionHandler: @escaping () -> Void) {
            completionHandler()
        }
    }
}
