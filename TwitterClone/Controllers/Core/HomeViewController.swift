//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Dmitryi Velko on 06.12.2022.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    private func configureNavigationBar() {
        let size: CGFloat = 26
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitterLogo")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapProfile))
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let timelineTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(timelineTableView)
        
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        
        configureNavigationBar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSignOut))
        bindViews()
        
    }
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.bounds
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retrieveUser()

    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
    }
    
    func bindViews() {
        viewModel.$user
            .sink { [weak self] user in
                guard let user = user else { return }
                if !user.isUserOnboarded {
                    self?.completeUserOnboarding()
                }
            }
            .store(in: &subscriptions)
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TweetTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        return cell
    }
    

    
    
}

// MARK: - TweetTableViewCellDelegate
extension HomeViewController: TweetTableViewCellDelegate {
    func tweetTableViewCellDidTapReplay() {
        print("replay")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("retweet")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("like")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("share")
    }
    
    
}