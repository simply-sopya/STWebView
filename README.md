# STWebView

**STWebView** is a lightweight and declarative `WKWebView` wrapper for SwiftUI. It enables you to seamlessly integrate WebView into your SwiftUI apps with full control over loading states, error handling, and navigation policy decisions.

👉 [View on GitHub](https://github.com/simply-sopya/STWebView)

## 🚀 Features
- ✅ Native SwiftUI syntax  
- 📡 `.onStart` and `.onFinish` loading callbacks  
- ⚠️ `.onFail` error handling  
- 🧭 `.onDecidePolicy` for navigation filtering  

## 📦 Installation
Use Swift Package Manager:

```swift
.package(url: "https://github.com/simply-sopya/STWebView.git", from: "1.0.0")
```

## 🧪 Usage

```swift
import STWebView

STWebView(url: URL(string: "https://apple.com")!)
    .onStart {
        print("Loading started")
    }
    .onFinish { url in
        print("Finished: \(url?.absoluteString ?? "nil")")
    }
    .onFail { error in
        print("Failed with error: \(error.localizedDescription)")
    }
    .onDecidePolicy { url, decision in
        if url.host?.contains("youtube.com") == true {
            decision(.cancel)
        } else {
            decision(.allow)
        }
    }
```

## 📄 License
MIT License.

## 🙌 Feedback
I’d love to hear your thoughts, ideas, or use cases.  
Feel free to open issues or submit PRs.

**Made with ❤️ by [@simply-sopya](https://github.com/simply-sopya)**
