//
//  ViewController.swift
//  GridiconsDemo
//
//  Created by James Frost on 01/04/2016.
//  Copyright © 2016 Automattic. All rights reserved.
//

import UIKit
import Gridicons

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        tintColor = .blackColor()
        imageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        imageView.layer.borderWidth = 1.0
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    let iconTypes: [GridiconType] = {
        var types = [GridiconType]()
        while let type = GridiconType(rawValue: types.count) {
            types.append(type)
        }
        
        return types
    }()
    
    var iconSize = CGSize(width: 24.0, height: 24.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let padding: CGFloat = 8.0
            
            layout.estimatedItemSize = CGSize(width: iconSize.width + (padding * 2), height: iconSize.height + (padding * 2))
        }
    }
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        guard let stepper = sender as? UIStepper else { return }
        
        let value = Int(stepper.value)
        
        sizeLabel.text = "\(value)px"
        iconSize = CGSize(width: CGFloat(value), height: CGFloat(value))
        
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconTypes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
        
        cell.imageView.image = Gridicon.iconOfType(iconTypes[indexPath.row], withSize: iconSize)
        
        return cell
    }
}