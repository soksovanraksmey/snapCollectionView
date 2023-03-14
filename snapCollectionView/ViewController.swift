//
//  ViewController.swift
//  snapCollectionView
//
//  Created by Sovanraksmey Sok on 14/3/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    
    let collectionMargin = CGFloat(24)
    let itemSpacing = CGFloat(8)
    let itemHeight = CGFloat(200)
    var itemWidth = CGFloat(0)
    var currentItem = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
       
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

            itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
            
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
            layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
            layout.minimumLineSpacing = itemSpacing
            layout.scrollDirection = .horizontal

        collectionView!.collectionViewLayout = layout
        collectionView?.decelerationRate = .fast
        
    }


}

extension ViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width)
        var newPage = Float(self.pageController.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageController.currentPage + 1 : self.pageController.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        self.pageController.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}




extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}
