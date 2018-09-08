//
//  ExampleEditingPageViewController.swift
//  DrumTrainer
//
//  Created by NVT on 08.09.18.
//  Copyright © 2018 NVT. All rights reserved.
//

import UIKit

class ExampleEditingPageViewController: UIPageViewController {

    lazy var beatEditingViewControllers: [UIViewController] = {
        let firstViewController = BeatBarEditViewContoller()
        let secondViewController = BeatBarEditViewContoller()
        print(firstViewController == secondViewController)
        print(firstViewController)
        print(secondViewController)
        return [
            firstViewController,
            secondViewController
        ]
    }()

    private func instantiateViewController() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BeatBarEditViewContoller")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        setViewControllers([beatEditingViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }

}

extension ExampleEditingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return beatEditingViewControllers[0]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return beatEditingViewControllers[0]
    }

}
