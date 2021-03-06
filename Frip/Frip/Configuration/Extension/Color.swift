import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainOrange
    class var mainOrange: UIColor { UIColor(hex: 0xF5663F) }
    class var saveColor: UIColor {UIColor(displayP3Red: 0.927, green: 0.440, blue: 0.420, alpha: 1)}
    class var healthColor: UIColor {UIColor(displayP3Red: 0.945, green: 0.957, blue: 0.969, alpha: 1)}
    class var greetingColor: UIColor{UIColor(displayP3Red: 0.953, green: 0.949, blue: 0.979, alpha: 1)}
    class var activityColor: UIColor{UIColor(displayP3Red: 0.965, green: 0.973, blue: 0.949, alpha: 1)}
    class var learningColor: UIColor{UIColor(displayP3Red: 0.949, green: 0.969, blue: 0.965, alpha: 1)}
    
    class var gradationBlue1: UIColor{UIColor(displayP3Red: 0.322, green: 0.590, blue: 0.969, alpha: 1)}
    
    class var gradationBlue2: UIColor{UIColor(displayP3Red: 0.423, green: 0.703, blue: 0.973, alpha: 1)}
    
    class var gradationBlue3: UIColor{UIColor(displayP3Red: 0.340, green: 0.610, blue: 0.969, alpha: 1)}
    
    class var gradationBlue4: UIColor{UIColor(displayP3Red: 0.481, green: 0.772, blue: 0.976, alpha: 1)}
}
