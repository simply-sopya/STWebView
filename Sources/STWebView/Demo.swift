//
//  Demo.swift
//  
//
//  Created by Swap on 14/05/25.
//

import SwiftUI

struct Demo: View {
    var body: some View {
        STWebView(url: URL(string: "https://apple.com")!)
            .onStart { print("Started loading") }
            .onFinish { url in print("Finished: \(url?.absoluteString ?? "nil")") }
            .onFail { error in print("Error: \(error.localizedDescription)") }
            .onDecidePolicy { url, decision in
                if url.host?.contains("youtube.com") == true {
                    decision(.cancel)
                } else {
                    decision(.allow)
                }
            }
    }
}

#Preview {
    Demo()
}
