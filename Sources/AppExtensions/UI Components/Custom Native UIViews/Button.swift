
import UIKit


open class Button: DesignableButton {

    open override func awakeFromNib() {
        super.awakeFromNib()
        
        for state in [UIControl.State.normal, UIControl.State.highlighted, UIControl.State.selected, UIControl.State.disabled] {
            
            if let title = title(for: state) {
                self.setTitle(title, for: state)
            }
        }
    }
    
    open override func setTitle(_ title: String?, for state: UIControl.State) {
        if let title = title {
            super.setTitle(title.localized, for: state)
        } else {
            super.setTitle(title, for: state)
        }
    }
    
    
    // MARK: - Enable And Disable Button
    
    override open var isEnabled: Bool {
        didSet {
            if super.isEnabled {
                self.enable()
            } else {
                self.disable()
            }
        }
    }
    
    open func enable() {
        super.isEnabled = true
        self.isUserInteractionEnabled = true
    }
    
    open func disable() {
        super.isEnabled = false
        self.isUserInteractionEnabled = false
    }
    
}


