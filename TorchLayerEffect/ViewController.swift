//
//  ViewController.swift
//  TorchLayerEffect
//
//  Created by Vikram Kunwar on 21/08/23.
//


import UIKit

class ViewController: UIViewController {
    
    let paperImageView = UIImageView(image: UIImage(named: "paper"))
    let magnifyGlassImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    var lensShapeLayer = CAShapeLayer()
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paperImageView.frame = view.bounds
        view.addSubview(paperImageView)
        
        magnifyGlassImageView.frame = CGRect(x: view.bounds.midX - 150, y: view.bounds.midY - 150, width: 300, height: 300)
        magnifyGlassImageView.contentMode = .scaleAspectFit
        magnifyGlassImageView.tintColor = .white
        magnifyGlassImageView.alpha = 0.1
        view.addSubview(magnifyGlassImageView)
        
        lensShapeLayer.fillColor = UIColor.black.withAlphaComponent(0.92).cgColor
        view.layer.addSublayer(lensShapeLayer)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        magnifyGlassImageView.addGestureRecognizer(panGesture)
        magnifyGlassImageView.isUserInteractionEnabled = true
        //TextLabel
        addTextLabels()
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            xOffset = translation.x
            yOffset = translation.y
            
            updateLensShape()
            updateMagnifyingGlassPosition()
            
        case .ended:
            // If you need to do something after the drag ends, you can add code here.
            break
            
        default:
            break
        }
    }
    
    func updateLensShape() {
        let lensPath = UIBezierPath(rect: view.bounds)
        let holePath = UIBezierPath(ovalIn: CGRect(x: view.bounds.midX + xOffset - 50, y: view.bounds.midY + yOffset - 50, width: 200, height: 200))
        lensPath.append(holePath.reversing())
        lensShapeLayer.path = lensPath.cgPath
    }
    
    func updateMagnifyingGlassPosition() {
        magnifyGlassImageView.center = CGPoint(x: view.bounds.midX + xOffset, y: view.bounds.midY + yOffset)
    }
    func addTextLabels() {
        let titleLabel = UILabel()
        titleLabel.text = "Torch Effect"
        titleLabel.font = UIFont.systemFont(ofSize: 42)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.frame = CGRect(x: 20, y: 30, width: view.bounds.width - 40, height: 50)
        view.addSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "By VikramiOSDev | Vikram Kunwar"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        subtitleLabel.textAlignment = .left
        subtitleLabel.frame = CGRect(x: 20, y: 80, width: view.bounds.width - 40, height: 30)
        view.addSubview(subtitleLabel)
    }
    
    
}
