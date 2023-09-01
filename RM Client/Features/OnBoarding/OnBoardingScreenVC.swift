//
//  OnBoardingScreenVC.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import UIKit

class OnBoardingScreenVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    private var pageViewController: UIPageControl = UIPageControl()
    private var pages: [UIViewController] = []
    
    public static func getInstance() -> OnBoardingScreenVC {
        return OnBoardingScreenVC()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Welcome"
        
        delegate = self
        dataSource = self
        
        if let firstOnBoardingViewController = getViewControllersList().first {
            setViewControllers([firstOnBoardingViewController], direction: .forward, animated: true)
        }
        
        addPagerViewControl()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pagerCurrentIndex = getViewControllersList().firstIndex(of: viewController) else { return nil }
        let pagerPrevIndex = pagerCurrentIndex - 1
        guard pagerPrevIndex >= 0 else { return nil }
        return getViewControllersList()[pagerPrevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let pagerCurrentIndex = getViewControllersList().firstIndex(of: viewController) else { return nil }
        let pagerNextIndex = pagerCurrentIndex + 1
        guard pagerNextIndex < getViewControllersList().count else { return nil }
        return getViewControllersList()[pagerNextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageViewController = pageViewController.viewControllers?[0] ?? getViewControllersList().first
        self.pageViewController.currentPage = getViewControllersList().firstIndex(of: pageViewController!) ?? 0
    }
    
    private func getViewControllersList() -> [UIViewController] {
        if pages.isEmpty {
            pages = self.getViewControllersPager()
        }
        
        return pages
    }
    
    private func addPagerViewControl() {
        pageViewController = UIPageControl(frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.maxY - 75,
            width: UIScreen.main.bounds.width,
            height: 50
        ))
        
        self.pageViewController.numberOfPages = getViewControllersList().count
        self.pageViewController.currentPage = 0
        self.pageViewController.pageIndicatorTintColor = .systemGray
        self.pageViewController.tintColor = RmThemeUtils.shared.getApplicationPrimaryColor()
        self.pageViewController.currentPageIndicatorTintColor = RmThemeUtils.shared.getApplicationPrimaryColor()
        self.view.addSubview(pageViewController)
    }
    
    private func getViewControllersPager() -> [UIViewController] {
        return [
            OnBoardingTabViewController.getInstance(index: 0),
            OnBoardingTabViewController.getInstance(index: 1),
            OnBoardingTabViewController.getInstance(index: 2),
        ]
    }

}
