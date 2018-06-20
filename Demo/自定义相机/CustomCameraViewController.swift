//
//  CustomCameraViewController.swift
//  Demo
//
//  Created by 王云 on 2018/5/30.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

protocol CameraViewDelegate: NSObjectProtocol {
    func cameraViewDidConfirm(controller: CustomCameraViewController, withImage image: UIImage?)
    func cameraViewDidCancel(controler: CustomCameraViewController)
}

class CustomCameraViewController: UIViewController {
    
    private var session: AVCaptureSession!
    private var deviceInput: AVCaptureDeviceInput!
    private var imageOutput: AVCaptureStillImageOutput!
    private var preview: AVCaptureVideoPreviewLayer!
    private var rectView: UIView!
    
    var delegate: CameraViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        session?.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        session?.stopRunning()
    }
    
    private func config() {
        do {
            session = AVCaptureSession()
            if let device = AVCaptureDevice.default(for: AVMediaType.video) {
                deviceInput = try AVCaptureDeviceInput(device: device)
            }
            imageOutput = AVCaptureStillImageOutput()
            let outputsetting = [AVVideoCodecKey : AVVideoCodecJPEG]
            imageOutput.outputSettings = outputsetting
            session.addInput(deviceInput)
            session.addOutput(imageOutput)
            
            preview = AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
            preview.frame = view.bounds
            view.layer.insertSublayer(preview, at: 0)
        } catch _ as NSError {
            let errorAlert = UIAlertController(title: "提醒", message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机", preferredStyle: UIAlertControllerStyle.alert)
            self.present(errorAlert, animated: true, completion: nil)
            errorAlert.addAction(UIAlertAction.init(title: "好的", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
        }
        
        rectView = UIView()
        rectView.backgroundColor = nil
        rectView.layer.borderWidth = 1
        rectView.layer.borderColor = UIColor.orange.cgColor
        rectView.layer.masksToBounds = true
        view.addSubview(rectView)
        
        var maxWidth = SCREEN_WIDTH - 16
        var maxHeight = SCREEN_HEIGHT - 200
        if maxHeight * 0.63 > maxWidth {
            maxHeight = maxWidth / 0.63
        } else {
            maxWidth = maxHeight * 0.63
        }
        
        rectView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(maxWidth)
            make.height.equalTo(maxHeight)
        }
        
        
        let container = UIView()
        container.backgroundColor = UIColor.black
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(autoHeight(height: 280))
        }
        
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.text = "请将图片置于框内"
        tipLabel.textColor = UIColor.white
        container.addSubview(tipLabel)
        
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.centerX.equalToSuperview()
        }
        
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnDidClick), for: .touchUpInside)
        container.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalToSuperview()
        }
        
        let frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        let confirmBtn = UIButton(frame: frame)
        confirmBtn.layer.cornerRadius = 32
        confirmBtn.layer.masksToBounds = true
        confirmBtn.backgroundColor = UIColor.white
        confirmBtn.addTarget(self, action: #selector(confirmBtnDidClick), for: .touchUpInside)
        container.addSubview(confirmBtn)
        
        confirmBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        let offset: CGFloat = 6
        let layer = CAShapeLayer()
        layer.frame = confirmBtn.bounds
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.darkGray.cgColor
        layer.lineWidth = 2
        layer.path = UIBezierPath(roundedRect: frame.insetBy(dx: offset, dy: offset), cornerRadius: (64 - offset) / 2).cgPath
        confirmBtn.layer.addSublayer(layer)
        
    }
    
    private func takePhoto() {
        let stillIMageConnect: AVCaptureConnection = imageOutput.connection(with: AVMediaType.video)!
        stillIMageConnect.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        stillIMageConnect.videoScaleAndCropFactor = 1.0
        imageOutput.captureStillImageAsynchronously(from: stillIMageConnect) { (imageDataSampleBuffer, error) in
            //转为jpegData
            let jpegData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer!)
            //转为image
            if let image = UIImage(data: jpegData!) {
                
                //旋转90度[给imageView赋值是不会旋转90度的，但是上传到服务器是要旋转90度的]
//                let image = orginImage.fixOrientation()
                
                //按照裁剪框裁剪
                let frame = self.rectView.frame
                let imageSize = image.size
                let bounds = self.view.bounds
                let scale = CGPoint.init(x: imageSize.width / bounds.height, y: imageSize.height / bounds.width)
                let rect = CGRect.init(x: frame.origin.y * scale.x , y: frame.origin.x * scale.x, width: frame.height * scale.y, height: frame.width * scale.x)
                let ref = image.cgImage?.cropping(to: rect)
                let result = UIImage(cgImage: ref!)
                
                self.delegate?.cameraViewDidConfirm(controller: self, withImage: result)
            } else {
                self.delegate?.cameraViewDidConfirm(controller: self, withImage: nil)
            }
        }
    }
    
    @objc func cancelBtnDidClick() {
        delegate?.cameraViewDidCancel(controler: self)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmBtnDidClick() {
        takePhoto()
        dismiss(animated: true, completion: nil)
    }

}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
            
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        
        return img
    }
    
}
