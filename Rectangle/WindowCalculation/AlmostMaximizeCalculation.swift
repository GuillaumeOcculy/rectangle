/// AlmostMaximizeCalculation.swift

import Foundation

class AlmostMaximizeCalculation: WindowCalculation {
    
    let almostMaximizeHeight: CGFloat
    let almostMaximizeWidth: CGFloat

    override init() {
        let defaultHeight = Defaults.almostMaximizeHeight.value
        almostMaximizeHeight = (defaultHeight <= 0 || defaultHeight > 1)
            ? 0.9
            : CGFloat(defaultHeight)

        let defaultWidth = Defaults.almostMaximizeWidth.value
        almostMaximizeWidth = (defaultWidth <= 0 || defaultWidth > 1)
            ? 0.9
            : CGFloat(defaultWidth)
    }
    
    override func calculate(_ params: WindowCalculationParameters) -> WindowCalculationResult? {
        RepeatedMaximizeRestore.calculate(params) ?? super.calculate(params)
    }
    
    override func calculateRect(_ params: RectCalculationParameters) -> RectResult {

        let visibleFrameOfScreen = params.visibleFrameOfScreen
        var calculatedWindowRect = params.window.rect

        // Keep current width and horizontal position; reduced height anchored to the top of the screen
        calculatedWindowRect.size.height = round(visibleFrameOfScreen.height * almostMaximizeHeight)
        calculatedWindowRect.origin.y = visibleFrameOfScreen.maxY - calculatedWindowRect.height
        
        return RectResult(calculatedWindowRect)
    }
    
}

