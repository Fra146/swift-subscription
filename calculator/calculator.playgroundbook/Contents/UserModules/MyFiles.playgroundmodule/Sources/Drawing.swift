import Foundation
import CoreGraphics
import UIKit

var defaultDrawingColor = UIColor(named: "drawing_default_color") ?? .black

/// Requisiti per posizionare un elemento grafico nella barra degli strumenti da disegno.
public protocol SideBarPlaceable {
    var icon: Graphic { get set }
}

/// Requisiti per un pennello.
public protocol Brush: SideBarPlaceable {
    var thickness: Int { get set }
    var color: Color { get set }
    var handleTouch: ((Touch) -> Void) { get set }
}

/// Disegna una serie di cerchi per creare linee a forma libera.
public class Pen: Brush, SideBarPlaceable {
    public var icon: Graphic = Graphic(image: #imageLiteral(resourceName: "Pen tool_@2x.png"))
    public var thickness: Int = 5
    public var handleTouch: ((Touch) -> Void) = { _ in }
    public var color: Color = defaultDrawingColor
    
    public init() {
        handleTouch = { [self] touch in
            let circle = Graphic.circle(radius: Int(self.thickness / 2), color: self.color)
            scene.place(circle, at: touch.position)
        }
    }
}

/// Disegna una linea dall'ultimo punto che è stato toccato al punto attualmente toccato.
public class Lines: Brush, SideBarPlaceable {
    public var icon: Graphic = Graphic(image: #imageLiteral(resourceName: "Line tool_@2x.png"))
    public var thickness: Int = 5
    public var handleTouch: ((Touch) -> Void) = { _ in }
    public var color: Color = defaultDrawingColor
    public var previousTouchPoint: Point? = nil
    
    
    public init() {
        handleTouch = { [self] touch in
            if previousTouchPoint == nil {
                previousTouchPoint = touch.position
            }
            
            let line = Graphic.line(start: previousTouchPoint!, end: touch.position, thickness: self.thickness, color: self.color)
            scene.place(line)
            
            previousTouchPoint = touch.position
        }
    }
}

/// Simula la pittura spray disegnando una serie di cerchi di varie dimensioni.
public class SprayPaint: Brush, SideBarPlaceable {
    public var icon: Graphic = Graphic(image: #imageLiteral(resourceName: "Spraypaint_@2x.png"))
    public var thickness: Int = 5
    public var handleTouch: ((Touch) -> Void) = { _ in }
    public var color: Color = defaultDrawingColor
    
    public init() {
        handleTouch = { [self] touch in
            for i in 1...Int.random(in: 10...30) {
                let randomRadius = (self.thickness / self.thickness) + Int.random(in: 0...(thickness / 2))
                let circle = Graphic.circle(radius: randomRadius, color: self.color)
                
                let randomPoint = touch.position.randomPoint(in: Double(thickness))
                guard randomPoint.x > -410 else { continue }
                scene.place(circle, at: randomPoint)
            }
        }
    }
}

/// Rimuove tutti gli elementi grafici all'interno del percorso del pennello.
public class Eraser: Brush, SideBarPlaceable {
    public var handleTouch: ((Touch) -> Void) = { _ in }
    public var icon: Graphic = Graphic(image: #imageLiteral(resourceName: "Eraser_@2x.png"))
    public var thickness: Int = 30
    public var color: Color = .white
    
    public init() {
        handleTouch = { [self] touch in
            let graphics = scene.getGraphics(at: touch.position, in: Size(width: self.thickness * 2, height: self.thickness * 2))
            scene.remove(graphics)
        }
    }
    
}

/// Configura l'app da disegno. Contiene il selettore di colore, spessore e tutti i pennelli aggiunti.
public class DrawingToolBar {
    var height: Int
    var width = 90
    var sideBarSpacing: Double = 85
    var sideRect: Graphic
    let colorPicker = ColorPicker()
    let thicknessPicker = ThicknessPicker()
    
    /// Numero massimo di pennelli.
    let maxBrushes = 6
    
    /// Tutti i pennelli della barra strumenti.
    var brushes: [Brush] = []
    
    /// Il pennello attualmente selezionato.
    var selectedBrush: Brush = Pen()
    
    /// Configura la barra degli strumenti.
    public init(brushes: [Brush]) {
        self.brushes = brushes
        
        height = 250 + (brushes.count * 75)
        
        if let brush = brushes.first {
            selectedBrush = brush
        } else {
            selectedBrush = Pen()
        }
        
        sideRect = Graphic.rectangle(width: width, height: height, cornerRadius: 20, color: #colorLiteral(red: 0.7999293208, green: 0.8000453115, blue: 0.7999039292, alpha: 1.0))
        
        setUpSideBar()
        enableDrawing()
    }
    
    /// Abilita la possibilità di disegnare sull'area di lavoro.
    func enableDrawing() {
        scene.setOnTouchMovedHandler { touch in
            // Impedisce gli eventi Touch nello spazio della barra degli strumenti.
            guard touch.position.x > -410 else { return }
            self.selectedBrush.handleTouch(touch)
        }
    }
    
    /// Disabilita la possibilità di disegnare sull'area di lavoro.
    func disableDrawing() {
        scene.setOnTouchMovedHandler { touch in
            // Disegno disabilitato.
        }
    }
    
    /// Aggiunge tutti i selettori e i pennelli alla barra degli strumenti.
    func setUpSideBar() {
        var brushCount = 0
        scene.place(sideRect, at: Point(x: -460, y: 0))
        
        var selectorPosition = Point(x: -460, y: sideRect.location.y + Double((height/2)) - 60)
        
        for brush in brushes {
            guard brushCount < maxBrushes else { continue }
            
            if let brush = brushes.first {
                brush.icon.setImageColor(to: .systemPurple)
            }
            
            brush.icon.setOnTouchHandler {_ in
                brush.icon.pulse()
                self.selectedBrush.icon.setImageColor(to: .black)
                brush.icon.setImageColor(to: .systemPurple)
                self.selectedBrush = brush
            }
            scene.place(brush.icon, at: selectorPosition)
            selectorPosition.y -= sideBarSpacing
            brushCount += 1
        }
        
        // Aggiunge il selettore colore.
        scene.place(colorPicker.icon, at: selectorPosition)
        colorPicker.icon.setOnTouchHandler { [self] _ in
            colorPicker.icon.pulse()
            colorPicker.draw(at: selectorPosition)
            disableDrawing()
            colorPicker.onSelectedColor = { color in
                colorPicker.icon.backgroundColor = color
                for var brush in brushes {
                    brush.color = color
                }
                enableDrawing()
            }
        }
        
        // Aggiunge il selettore spessore.
        selectorPosition.y -= sideBarSpacing
        let overlayCircle = Graphic.circle(radius: 20, color: .clear)
        scene.place(thicknessPicker.icon, at: selectorPosition)
        scene.place(overlayCircle, at: selectorPosition)
        overlayCircle.setOnTouchHandler { [self] _ in
            thicknessPicker.icon.pulse()
            thicknessPicker.draw(at: selectorPosition)
            disableDrawing()
            thicknessPicker.onSelectedValue = { thickness in
                for var brush in brushes {
                    brush.thickness = thickness
                }
                thicknessPicker.icon.size.height = CGFloat(thickness)
                enableDrawing()
            }
        }
        
        // Chiude i selettori quando tocchi al loro esterno.
        scene.setOnTouchHandler( { [self] touch in
            thicknessPicker.dismiss()
            colorPicker.dismiss()
            enableDrawing()
        })
    }
}
