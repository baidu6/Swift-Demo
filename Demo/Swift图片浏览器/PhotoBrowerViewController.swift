//
//  PhotoBrowerViewController.swift
//  Demo
//
//  Created by 王云 on 2018/5/3.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit

class PhotoBrowerViewController: UIViewController {
    
    private lazy var thumbnailImageUrls: [String] = {
        return ["http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7nzbz7j20ib0iek5j.jpg",
                "http://wx1.sinaimg.cn/thumbnail/bfc243a3gy1febm7n9eorj20i60hsann.jpg",
                "http://wx1.sinaimg.cn/thumbnail/bfc243a3gy1febm7orgqfj20i80ht15x.jpg",
                "http://wx2.sinaimg.cn/thumbnail/bfc243a3gy1febm7pmnk7j20i70jidwo.jpg",
                "http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7qjop4j20i00hw4c6.jpg",
                "http://wx4.sinaimg.cn/thumbnail/bfc243a3gy1febm7rncxaj20ek0i74dv.jpg",
                "http://wx2.sinaimg.cn/thumbnail/bfc243a3gy1febm7sdk4lj20ib0i714u.jpg",
                "http://wx4.sinaimg.cn/thumbnail/bfc243a3gy1febm7tekewj20i20i4aoy.jpg",
                "http://wx3.sinaimg.cn/thumbnail/bfc243a3gy1febm7usmc8j20i543zngx.jpg",]
    }()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        let colCount = 3
        let rowCount = 3
        
        let xMargin: CGFloat = 60
        let interitemSpacing: CGFloat = 10
        let width: CGFloat = self.view.bounds.width - xMargin * 2
        let itemSize: CGFloat = (width - 2 * interitemSpacing) / CGFloat(colCount)
        
        let lineSpacing: CGFloat = 10
        let height = itemSize * CGFloat(rowCount) + lineSpacing * 2
        let y: CGFloat = 100
        
        let frame = CGRect(x: xMargin, y: y, width: width, height: height)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.scrollDirection = .vertical
        
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: NSStringFromClass(PhotoCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

}

extension PhotoBrowerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailImageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(PhotoCell.self), for: indexPath) as! PhotoCell
        cell.imageView.kf.setImage(with: URL(string: thumbnailImageUrls[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PhotoBrowser.show(byViewController: self, delegate: self, openIndex: indexPath.item)
    }
    
}

extension PhotoBrowerViewController: PhotoBrowserDelegate {
    func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int {
        return thumbnailImageUrls.count
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, imageForIndex index: Int) -> URL? {
        return URL(string: thumbnailImageUrls[index])
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, cellForIndex index: Int) -> UICollectionViewCell? {
        return collectionView.cellForItem(at: IndexPath(item: index, section: 0))
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, didLongPressForIndex index: Int, image: UIImage) {
        print("长按")
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, willDismissWithIndex index: Int, image: UIImage?) {
        print("页面将要消失的时候")
    }
    
    func photoBrowser(_ photoBrowser: PhotoBrowser, didDismissWithIndex index: Int, image: UIImage?) {
        print("页面已经消失")
    }
}

class PhotoCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
