import CoreGraphics
import UIKit
import SpriteKit

/// Converte da gradi a radianti.
public func radians(fromDegrees: Double) -> CGFloat {
    return CGFloat(fromDegrees * (Double.pi / 180.0))
}

/*
 (!) UIBezierPath usa i radianti per specificare gli angoli.
     La funzione qui sopra esegue la conversione dai gradi.

 (!) Quando disegni archi con UIBezierPath,
     il punto 0º si trova nella posizione delle ore 3.

              270º
               |
       180º —— + ——  0º
               |
              90º
 
*/
/// Crea un CGPath, utilizzato per creare una forma personalizzata.
public func oddShape() -> CGPath {
    let path = UIBezierPath()
    let leftCircleCenter = CGPoint(x: 40, y: 40)
    let rightCircleCenter = CGPoint(x: 160, y: 40)
    let boxTopLeft = leftCircleCenter
    let boxTopRight = rightCircleCenter
    let boxBottomRight = CGPoint(x: 160, y: 160)
    let boxBottomLeft = CGPoint(x: 40, y: 160)
    path.addArc(withCenter: leftCircleCenter,
                radius: 40,
                startAngle: radians(fromDegrees: 90),
                endAngle: radians(fromDegrees: 0),
                clockwise: true)
    path.addLine(to: rightCircleCenter)
    path.addArc(withCenter: rightCircleCenter,
                radius: 40,
                startAngle: radians(fromDegrees: 180),
                endAngle: radians(fromDegrees: 90),
                clockwise: true)
    path.addLine(to: boxBottomRight)
    path.addLine(to: boxBottomLeft)
    path.addLine(to: boxTopLeft)
    path.close()
    return path.cgPath
}

public extension UIColor {
    /// Crea un nuovo colore, più chiaro, dove 1.0 indica la tonalità più chiara e 0.0 indica assenza di cambi.
    public func lighter(percent: Double = 0.2) -> UIColor {
        return withBrightness(percent: 1 + percent)
    }
    
    /// Crea un nuovo colore, più scuro, dove 1.0 indica la tonalità più scura e 0.0 indica assenza di cambi.
    public func darker(percent: Double = 0.2) -> UIColor {
        return withBrightness(percent: 1 - percent)
    }
    
    /// Crea un nuovo colore con la trasparenza data, dove 0.0 indica completamente trasparente e 1.0 completamente opaco.
    public func withAlpha(alpha: Double) -> Color {
        return self.withAlphaComponent(CGFloat(alpha))
    }
    
    /// Crea un nuovo colore con la luminosità data, dove 0.0 è la luminosità minima e 1.0 la massima.
    private func withBrightness(percent: Double) -> UIColor {
        var cappedPercent = min(percent, 1.0)
        cappedPercent = max(0.0, percent)
        
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return Color(hue: Double(hue), saturation: Double(saturation), brightness: Double(brightness) * cappedPercent, alpha: Double(alpha))
    }
    
    /// Sceglie un colore casuale.
    public static func random() -> UIColor {
        let uint32MaxAsFloat = Float(UInt32.max)
        let red = Double(Float(arc4random()) / uint32MaxAsFloat)
        let blue = Double(Float(arc4random()) / uint32MaxAsFloat)
        let green = Double(Float(arc4random()) / uint32MaxAsFloat)
        
        return Color(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public extension Point {
    /// Seleziona un punto casuale entro il raggio di un cerchio.
    func randomPoint(in radius: Double) -> Point {
        let alpha = 2 * Double.pi * Double.random(in: 0...radius)
        let r = radius * sqrt(Double.random(in: 0...radius))
        let x = r * cos(alpha) + self.x
        let y = r * sin(alpha) + self.y
        return Point(x: x, y: y)
    }
}

public extension Graphic {
    /// Crea l'animazione di una lieve pulsazione su un elemento grafico.
    func pulse() {
        let currentScale = self.scale
        let scaleUp = SKAction.scale(by: 1.15, duration: 0.15)
        let scaleBack = SKAction.scale(to: CGFloat(currentScale), duration: 0.075)
        let sequence = SKAction.sequence([scaleUp, scaleBack])
        self.run(sequence)
    }
    
    /// Rende trascinabile l'elemento grafico attuale.
    var isDraggable: Bool {
        get {
            if self.hasHandler(forInteraction: .drag) {
                return true
            } else {
                return false
            }
            
        } set {
            if newValue {
                let handler: (Touch)->Void = {touch in
                    self.location = touch.position
                }
                self.setHandler(for: .drag, handler: handler)
            } else {
                self.removeHandler(forInteraction: .drag)
            }
        }
    }
}

public extension Sprite {
    /// Rende trascinabile l'elemento grafico attuale.
    var isDraggable: Bool {
        get {
            if self.hasHandler(forInteraction: .drag) {
                return true
            } else {
                return false
            }
            
        } set {
            if newValue {
                let handler: (Touch)->Void = {touch in
                    self.location = touch.position
                }
                self.setHandler(for: .drag, handler: handler)
            } else {
                self.removeHandler(forInteraction: .drag)
            }
        }
    }
}
