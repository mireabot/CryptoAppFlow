//
//  NumericKeyboard.swift
//  CryptoWalletFlow
//
//  Created by Mikhail Kolkov on 3/19/25.
//

import SwiftUI

public struct NumericKeyboard: View {
    @Binding var textValue: String
    var submitAction: () -> Void
    var keyPressHandler: ((String, String) -> String)?
    
    public init(
        textValue: Binding<String>,
        submitAction: @escaping () -> Void,
        keyPressHandler: ((String, String) -> String)? = nil
    ) {
        self._textValue = textValue
        self.submitAction = submitAction
        self.keyPressHandler = keyPressHandler
    }
    
    public var body: some View {
        VStack {
            KeyPadRow(keys: ["1", "2", "3"])
            KeyPadRow(keys: ["4", "5", "6"])
            KeyPadRow(keys: ["7", "8", "9"])
            KeyPadRow(keys: [".", "0", "⌫"])
        }.environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }
    
    private func keyWasPressed(_ key: String) {
        if let customHandler = keyPressHandler {
            if key == "⌫" {
                handleDelete()
            } else {
                textValue = customHandler(key, textValue)
            }
        } else {
            switch key {
            case "." where !textValue.contains("."):
                textValue += key
            case "⌫":
                handleDelete()
            case _ where textValue.isEmpty && key == "0":
                textValue = "0"
            default:
                if key != "." {
                    if textValue == "0" && key != "." {
                        textValue = key
                    } else {
                        textValue += key
                    }
                }
            }
        }
    }
    
    private func handleDelete() {
        if !textValue.isEmpty {
            textValue.removeLast()
        }
    }

}

// MARK: Helpers
fileprivate struct SetTFKeyboard<Content: View>: UIViewRepresentable {
  var keyboardContent: Content
  @State private var hostingController: UIHostingController<Content>?
  
  func makeUIView(context: Context) -> UIView {
    return UIView()
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
    DispatchQueue.main.async {
      if let textFieldContainerView = uiView.superview?.superview {
        if let textField = textFieldContainerView.findTextField {
          /// If the input is already set, then updating it's content
          if textField.inputView == nil {
            /// Now with the help of UIHosting Controller converting SwiftUI View into UIKit View
            hostingController = UIHostingController(rootView: keyboardContent)
            hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
            /// Setting TF's Input view as our SwiftUI View
            textField.inputView = hostingController?.view
          } else {
            /// Updating Hosting Content
            hostingController?.rootView = keyboardContent
          }
        } else {
          print("Failed to Find TF")
        }
      }
    }
  }
}

/// Extracting TextField From the Subviews
fileprivate extension UIView {
  var allSubViews: [UIView] {
    return subviews.flatMap { [$0] + $0.subviews }
  }
  
  /// Finiding the UIView is TextField or Not
  var findTextField: UITextField? {
    if let textField = allSubViews.first(where: { view in
      view is UITextField
    }) as? UITextField {
      return textField
    }
    
    return nil
  }
}

// Design rules for specific buttons
struct KeyPadButton: View {
  var key: String
  
  var body: some View {
    Button(action: { self.action(self.key) }) {
      if key == "⌫" {
        Image(systemName: "delete.left")
          .font(.system(.title3, weight: .semibold))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding(12)
          .background(Color.blue)
          .cornerRadius(8)
      } else if key == "Done" {
        Text(key)
          .font(.system(.title3, weight: .semibold))
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding(12)
          .background(Color.blue)
          .cornerRadius(8)
      } else {
        Text(key)
              .font(.system(.title3, weight: .semibold))
          .frame(maxWidth: .infinity)
          .padding(12)
          .background(Color.gray.opacity(0.2))
          .cornerRadius(8)
      }
    }
    .buttonStyle(PlainButtonStyle())
  }
  
  enum ActionKey: EnvironmentKey {
    static var defaultValue: (String) -> Void { { _ in } }
  }
  
  @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
  var keyPadButtonAction: (String) -> Void {
    get { self[KeyPadButton.ActionKey.self] }
    set { self[KeyPadButton.ActionKey.self] = newValue }
  }
}

/// Custom TextField Keyboard TextField Modifier
extension TextField {
  @ViewBuilder
  func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .background {
        SetTFKeyboard(keyboardContent: content())
      }
  }
}

extension View {
  @ViewBuilder
  func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
    self
      .background {
        SetTFKeyboard(keyboardContent: content())
      }
  }
}

struct KeyPadRow: View {
  var keys: [String]
  
  var body: some View {
    HStack {
      ForEach(keys, id: \.self) { key in
        KeyPadButton(key: key)
      }
    }
  }
}

// MARK: Preview
struct KeyboardPreview: View {
    @State private var value: String = ""
    var body: some View {
        VStack {
            TextField("Number under 100", text: $value)
            
            Spacer()
            
            NumericKeyboard(
                textValue: $value,
                submitAction: {
                    print("Done")
                    value = ""
                },
                keyPressHandler: { key, currentValue in
                    // Custom logic example: Only allow numbers up to 100
                    let newValue = currentValue + key
                    if let number = Int(newValue), number <= 100 {
                        return newValue
                    }
                    return currentValue
                }
            )
        }.padding(.horizontal, 16)
    }
}

#if DEBUG
#Preview(body: {
    KeyboardPreview()
})
#endif
