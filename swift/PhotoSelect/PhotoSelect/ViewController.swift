//
//  ViewController.swift
//  PhotoSelect
//
//  Created by Michael Chirico on 11/10/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit
import MobileCoreServices
import MapKit

class ViewController: UIViewController,
  UINavigationControllerDelegate,
UIImagePickerControllerDelegate {
  
  @IBOutlet weak var imageView0: UIImageView!
  @IBOutlet weak var imageView1: UIImageView!
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("open")
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  static func importData(from url: URL) {
    print("This is url: \(url)")
    do {
      try FileManager.default.removeItem(at: url)
    } catch {
      print("Failed to remove item from Inbox")
    }
  }
  
  @IBAction func button3(_ sender: UIButton) {
    
    let sqliteBroker = SqliteBroker()
    
    let textToShare = "SQLite database"
    
    if let img = imageView1.image {

      let pngData: Data = img.pngData()!
      
      let stmt = "create table if not exists blobtest (des varchar(80),b blob);"
      let table = "test.sqlite"
      sqliteBroker.sqlExe(table: table, stmt: stmt)
      sqliteBroker.insertBlob("test", n: pngData)
      
      let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      let fileURL = documents.appendingPathComponent(table)
      
      let objectsToShare = [textToShare, fileURL] as [Any]
      let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
      
      activityVC.popoverPresentationController?.sourceView = sender
      self.present(activityVC, animated: true, completion: nil)
    }
    
  }
  
  @IBAction func button0(_ sender: UIButton) {
    
    let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
      self.openCamera()
    }))
    
    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
      self.openGallery()
    }))
    
    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
    
  }
  
  func openCamera() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = UIImagePickerController.SourceType.camera
      imagePicker.allowsEditing = false
      self.present(imagePicker, animated: true, completion: nil)
    } else {
      let alert  = UIAlertController(title: "Warning",
                                     message: "You don't have camera",
                                     preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK",
                                    style: .default,
                                    handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  func openGallery() {
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.allowsEditing = true
      imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
      self.present(imagePicker, animated: true, completion: nil)
    } else {
      let alert  = UIAlertController(title: "Warning",
                                     message: "You don't have perission to access gallery.",
                                     preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func button1(_ sender: UIButton) {
    getSnap()
  }
  
  func getSnap() {
    
    let snapshotterOptions = MKMapSnapshotter.Options()
    snapshotterOptions.region = mapView.region
    snapshotterOptions.scale = UIScreen.main.scale
    snapshotterOptions.size = mapView.frame.size
    
    let snapshotter = MKMapSnapshotter(options: snapshotterOptions)
    
    snapshotter.start { snapshot, _ in
      
      let image = snapshot!.image
      
      _ = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
      let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: "")
      let pinImage = pin.image
      
      UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
      pinImage!.draw(at: CGPoint(x: 0, y: 0))
      let path = UIBezierPath()
      path.move(to: CGPoint(x: 20, y: 20))
      path.lineWidth = 2.0
      _ = UIGraphicsGetImageFromCurrentImageContext()
      
      image.draw(at: CGPoint(x: 0, y: 0))
      UIGraphicsEndImageContext()
      
      self.imageView1.image = image

    }
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo
                info: [UIImagePickerController.InfoKey: Any]) {
    
    guard let selectedImage = info[.originalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    }
    
    imageView0.image = selectedImage
    
    picker.dismiss(animated: true, completion: nil)
  }
  
}
