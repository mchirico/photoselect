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


class ViewController: UIViewController {

  @IBOutlet weak var imageView0: UIImageView!
  @IBOutlet weak var imageView1: UIImageView!
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func button0(_ sender: UIButton) {
    
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
      print("Button capture")
      let imag = UIImagePickerController()
      
//      
//      imag.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
//      imag.sourceType = UIImagePickerController.SourceType.photoLibrary;
//      //imag.mediaTypes = [kUTTypeImage];
//      imag.allowsEditing = false
//      self.present(imag, animated: true, completion: nil)
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
    
    snapshotter.start() {
      snapshot, error in
      
      let image = snapshot!.image
      
      
      
      _ = CGRect(x: 0, y: 0,width:  image.size.width,height: image.size.height)
      let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: "")
      let pinImage = pin.image
      
      UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale);
      pinImage!.draw(at: CGPoint(x: 0,y: 0))
      let path = UIBezierPath()
      path.move(to: CGPoint(x: 20,y:  20))
      path.lineWidth = 2.0
      _ = UIGraphicsGetImageFromCurrentImageContext()
      
      image.draw(at: CGPoint(x: 0,y: 0))
      UIGraphicsEndImageContext()
      
      self.imageView1.image = image
      
      //      // draw center/home marker
      //      var homePoint = snapshot!.pointForCoordinate(mapView.coordinate)
      //      pinImage.drawAtPoint(homePoint)
      //
      //      // draw polygon
      //      var path = UIBezierPath()
      //
      //      for (i, coordinate) in enumerate(self.areaCoordinates) {
      //        var point = snapshot.pointForCoordinate(coordinate)
      //
      //        if (CGRectContainsPoint(finalImageRect, point)) {
      //          if i == 0 {
      //            path.moveToPoint(point)
      //          } else {
      //            path.addLineToPoint(point)
      //          }
      //        }
      //      }
      //
      //      path.closePath()
      //
      //      UIColor.blueColor().colorWithAlphaComponent(0.7).setStroke()
      //      UIColor.cyanColor().colorWithAlphaComponent(0.2).setFill()
      //
      //      path.lineWidth = 2.0
      //      path.stroke()
      //      path.fill()
      //
      //      let finalImage = UIGraphicsGetImageFromCurrentImageContext()
      //      UIGraphicsEndImageContext()
      //
      //      self.snapshotImage = finalImage
    }
    
    
    
  }
  
  
  
  
  
  
  
  
  func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
    let selectedImage : UIImage = image
    //var tempImage:UIImage = editingInfo[UIImagePickerControllerOriginalImage] as UIImage
    imageView0.image=selectedImage
    self.dismiss(animated: true, completion: nil)
  }
  
  
  
  
}

