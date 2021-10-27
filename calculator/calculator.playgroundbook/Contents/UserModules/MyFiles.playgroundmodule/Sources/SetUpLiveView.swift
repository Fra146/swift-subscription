import PlaygroundSupport
import SPCCore
import UIKit

/// Un'istanza globale di Scene (scena).
public let scene = Scene(size: Scene.sceneSize)

/// Configura la vista interattiva utilizzando l'elemento SKView della scena.
public func setUpLiveView(presentation: LiveViewContentPresentation = .aspectFitMaximum) {
    LiveViewController.contentPresentation = presentation
    let liveViewController = LiveViewController()
    liveViewController.contentView = scene.skView
    PlaygroundPage.current.liveView = liveViewController
    liveViewController.backgroundImage = UIImage.from(color: UIColor(named: "scene_background_color") ?? .systemBackground)
    scene.backgroundColor = UIColor(named: "scene_background_color") ?? .systemBackground
}
