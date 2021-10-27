import SpriteKit

/// Selettore personalizzato da usare per selezionare la grandezza del pennello nella barra degli strumenti da disegno.
public class ThicknessPicker: SideBarPlaceable {
    var width = 400
    var height = 60
    var elementSize = 40
    
    /// Gestore eventi richiamato durante la selezione di uno spessore.
    public var onSelectedValue: ((Int) -> Void) = { _ in }
    
    /// L'icona nella barra degli strumenti per il selettore spessore.
    public var icon = Graphic.line(length: 40, thickness: 15, color: .black)
    
    /// Rimuove tutti gli elementi grafici associati al selettore spessore.
    public func dismiss() {
        scene.removeGraphics(named: "ThicknessPicker")
    }
    
    public init() {
        icon.rotation = 90
    }
    
    /// Disegna e configura il selettore spessore.
    public func draw(at point: Point) {
        let rect = Graphic.rectangle(width: width + 20, height: height + 10, cornerRadius: 20, color: #colorLiteral(red: 0.9214347004890442, green: 0.9214347004890442, blue: 0.9214347004890442, alpha: 1.0))
        rect.name = "ThicknessPicker"
        scene.place(rect, at: point, anchoredTo: .left)
        
        let columns = width / elementSize
        let columnDistance = Double(width) / Double(columns)
        var currentPosition = Point(x: point.x + 25, y: point.y)
        
        for i in 1...columns {
            var thickness = Double(i) * 3
            let line = Graphic.line(length: 40, thickness: Int(thickness), color: .black)
            let overlayCircle = Graphic.circle(radius: 20, color: .clear)
            overlayCircle.name = "ThicknessPicker"
            line.name = "ThicknessPicker"
            line.rotation = 90
            scene.place(line, at: currentPosition)
            scene.place(overlayCircle, at: currentPosition)
            
            overlayCircle.setOnTouchHandler { [self] _ in
                line.run(SKAction.scale(to: 1.5, duration: 0.2)) {
                    onSelectedValue(Int(thickness))
                    dismiss()
                }
            }
            
            currentPosition.x += columnDistance
        }
        
    }
}
