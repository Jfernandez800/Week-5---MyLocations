import UIKit

//Chapter 26 - The hud(inView, animated) method is known as a convenience constructor. It creates and returns a new HudView instance.
class HudView: UIView {
    var text = ""
    class func hud(inView view: UIView, animated: Bool) -> HudView {
        let hudView = HudView(frame: view.bounds)
        hudView.isOpaque = false
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        hudView.show(animated: animated)
        return hudView
    }
    
    //Chapter 26 - The draw method is invoked whenever UIKit wants your view to redraw itself.
    override func draw(_ rect: CGRect) {
        let boxWidth: CGFloat = 96
        let boxHeight: CGFloat = 96
        let boxRect = CGRect(
            x: round((bounds.size.width - boxWidth) / 2),
            y: round((bounds.size.height - boxHeight) / 2),
            width: boxWidth,
            height: boxHeight
        )
        let roundedRect = UIBezierPath(
            roundedRect: boxRect,
            cornerRadius: 10
        )
        UIColor(white: 0.3, alpha: 0.8).setFill()
        roundedRect.fill()
        // Draw checkmark
        if let image = UIImage(named: "Checkmark") {
            let imagePoint = CGPoint(
                x: center.x - round(image.size.width / 2),
                y: center.y - round(image.size.height / 2) - boxHeight / 8)
            image.draw(at: imagePoint)
        }
        
        // Draw the text
        let attribs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        let textSize = text.size(withAttributes: attribs)
        let textPoint = CGPoint(
            x: center.x - round(textSize.width / 2),
            y: center.y - round(textSize.height / 2) + boxHeight / 4)
        text.draw(at: textPoint, withAttributes: attribs)
    }
    
    //Chapter 26 - a crossfade animation using the Core Animation framework.
    func show(animated: Bool) {
        if animated {
            // 1 - Set up the initial state of the view before the animation starts.
            alpha = 0
            transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            // 2 - Set up an animation.
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                // 3 - Set up the state of the view as it should be after the animation completes.
                self.alpha = 1
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    //Chapter 26 - Hide Check mark
    func hide() {
        superview?.isUserInteractionEnabled = true
        removeFromSuperview()
    }
}
