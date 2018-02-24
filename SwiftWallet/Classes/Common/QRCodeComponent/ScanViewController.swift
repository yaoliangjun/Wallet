//
//  ScanViewController.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/2/24.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//  扫描二维码

import UIKit
import AVFoundation

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var flashOpen: Bool? = false
    var didScanSuccessClosure: ((_ result: String?) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        let photoLibraryItem = UIBarButtonItem(image: UIImage(named: "sweep_album_icon"), style: .plain, target: self, action: #selector(photoLibraryBtnClick))
        let flashItem = UIBarButtonItem(image: UIImage(named: "sweep_light_icon"), style: .plain, target: self, action: #selector(flashBtnClick))
        self.navigationItem.rightBarButtonItems = [flashItem, photoLibraryItem]

        let layer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.frame = self.view.layer.bounds
        self.view.layer.insertSublayer(layer, at: 0)

        view.addSubview(maskView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScanning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopScanning()
    }

    // 开始扫描
    func startScanning() {
        self.session.startRunning()
        self.maskView.startAnimation()
    }

    // 停止扫描
    func stopScanning() {
        self.session.stopRunning()
        self.maskView.stopAnimation()
    }

    private lazy var session: AVCaptureSession = {
        // 获取摄像设备
        guard let device = AVCaptureDevice.default(for: .video) else { return AVCaptureSession() }

        // 创建输入流
        var input: AVCaptureDeviceInput?
        do {
            let myInput: AVCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
            input = myInput
        } catch let error as NSError {
            print(error)
        }

        // 创建输出流
        let output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

        // 设置扫描区域的比例
        let windowSize:CGSize = UIScreen.main.bounds.size
        let scanSize:CGSize = CGSize(width: 300, height: 300)
        var scanRect:CGRect = CGRect(x: (windowSize.width-scanSize.width)/2, y: (windowSize.height-scanSize.height)/2, width: scanSize.width, height: scanSize.height)
        //计算rectOfInterest 注意x,y交换位置
        scanRect = CGRect(x: scanRect.origin.y/windowSize.height, y: scanRect.origin.x/windowSize.width, width: scanRect.size.height/windowSize.height, height: scanRect.size.width/windowSize.width)
        output.rectOfInterest = scanRect

        // 高质量采集率
        let session = AVCaptureSession()
        session.canSetSessionPreset(AVCaptureSession.Preset.high)
        session.addOutput(output)
        session.addInput(input!)

        // 设置扫码支持的编码格式(这里设置条形码和二维码兼容)
        output.metadataObjectTypes = [.qr, .ean13, .ean8, .code128, .pdf417]

        return session
    }()

    private lazy var maskView: MaskView = {
        var maskView = MaskView(frame: self.view.bounds)
        return maskView
    }()

    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            playSound("noticeMusic.caf")
            let metadataObject: AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            if didScanSuccessClosure != nil {
                didScanSuccessClosure!(metadataObject.stringValue)
            }
            self.stopScanning()
            navigationController?.popViewController(animated: true)
        }
    }

    // MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            let image = info[UIImagePickerControllerOriginalImage]
            self.findQRCodeFromImage(image: image as! UIImage)
        }
    }

    func findQRCodeFromImage(image:UIImage) {
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        let faetures = detector.features(in: CIImage(cgImage: image.cgImage!))
        if faetures.count >= 1 {
            let feature: CIQRCodeFeature = faetures.first as! CIQRCodeFeature
            if didScanSuccessClosure != nil {
                didScanSuccessClosure!(feature.messageString)
            }
            self.stopScanning()
            navigationController?.popViewController(animated: true)

        } else {
            print("没有识别到二维码")
        }
    }

    // 相册
    @objc fileprivate func photoLibraryBtnClick() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)

        } else {
            print("设备不支持访问相册")
        }
    }

    // 闪关灯
    @objc fileprivate func flashBtnClick() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if !device.hasTorch || !device.hasFlash {
            return
        }

        do {
            try device.lockForConfiguration()
            if self.flashOpen! {
                device.torchMode = .off
                device.flashMode = .off
            } else {
                device.torchMode = .on
                device.flashMode = .on
            }
            device.unlockForConfiguration()

        } catch {

        }
        self.flashOpen = !self.flashOpen!
    }

    // 播放声音
    func playSound(_ sound: String) {
        guard let soundPath = Bundle.main.path(forResource: sound, ofType: nil)  else {
            return
        }

        let encodeUrl = soundPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        guard let soundUrl = NSURL(string: encodeUrl) else {
            return
        }

        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
}
