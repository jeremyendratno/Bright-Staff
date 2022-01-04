//
//  MainMenuViewController.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/3/22.
//

import UIKit

class MainMenuViewController: BaseViewController, LogoutDelegate {
    @IBOutlet weak var mainMenuCollectionView: UICollectionView!
    
    var mainMenuViewModel = MainMenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        initCollectionView()
    }
    
    func viewSetup() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Main Menu"
        mainMenuViewModel.delegate = self
    }
    
    func initCollectionView() {
        mainMenuCollectionView.delegate = self
        mainMenuCollectionView.dataSource = self
        mainMenuCollectionView.register(UINib(nibName: "MainMenuCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainMenuCell")
    }
    
    func pushToAttend() {
        let attendViewController = AttendViewController()
        navigationController?.pushViewController(attendViewController, animated: true)
    }
    
    func logout() {
        showParentSpinner()
        mainMenuViewModel.logout()
    }
    
    func onSuccessLogout() {
        self.removeSpinner()
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func onFailLogout() {
        self.removeSpinner()
    }
}

extension MainMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainMenuCollectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCollectionViewCell
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(systemName: "camera.fill")
            cell.nameLabel.text = "Scanner"
        } else if indexPath.row == 1 {
            cell.imageView.image = UIImage(systemName: "newspaper.fill")
            cell.nameLabel.text = "Attend"
        } else if indexPath.row == 2 {
            cell.imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right.fill")
            cell.nameLabel.text = "Logout"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            pushToAttend()
        } else if indexPath.row == 2 {
            logout()
        }
    }
    
    
}
