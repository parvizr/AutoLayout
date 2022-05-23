//
//  SwipingController.swift
//  autolayout
//
//  Created by javad on 05.03.22.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate { UIViewControllerTransitionCoordinatorContext in
            self.collectionViewLayout.invalidateLayout()
            
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

        
   
        
    }
    
    let cellID = "cellID"
    let pages = [
        Page(imageName: "bear_first", headerText: "Join us today in our fan and games", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon. Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website."),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "Hello There!!!"),
        Page(imageName: "bear_first", headerText: "Join us today in our fan and games", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon. Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website."),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "Hello There!!!")

    ]
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc func handlePrev(){
        
        let prevPath = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevPath, section: 0)
        pageControl.currentPage = prevPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc func handleNext() {
        
        let nextPath = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextPath, section: 0)
        pageControl.currentPage = nextPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      
    }
    
    
    func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillProportionally
        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()

        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
    }
    
    
  
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
//        let imageName = imageNames[indexPath.item]
        let page = pages[indexPath.item]
        cell.page = page
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
