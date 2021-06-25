import UIKit

public class GameContainer {
    
    var hostView: UIView
    var retryDelegate: RetryDelegateProtocol
    
    public init(on view: UIView, with delegate: RetryDelegateProtocol) {
        hostView = view
        retryDelegate = delegate
    }
}
