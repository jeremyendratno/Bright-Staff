//
//  AttendViewController.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import UIKit

class AttendViewController: BaseViewController, AttendDelegate {
    @IBOutlet weak var attendCollectionView: UICollectionView!
    
    var attendViewModel = AttendViewModel()
    var attendClicked: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        viewSetup()
    }
    
    func viewSetup() {
        navigationItem.title = "Attend"
        navigationController?.navigationBar.isHidden = false
        attendViewModel.delegate = self
        showParentSpinner()
        attendViewModel.getAttend()
    }
    
    func initCollectionView() {
        attendCollectionView.delegate = self
        attendCollectionView.dataSource = self
        attendCollectionView.register(UINib(nibName: "AttendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AttendCell")
        attendCollectionView.register(UINib(nibName: "AttendClickedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AttendClickedCell")
    }
    
    func onSuccess() {
        attendCollectionView.reloadData()
        if attendViewModel.attends.count != 0 {
            for _ in 1...attendViewModel.attends.count {
                attendClicked.append(false)
            }
        }
        removeSpinner()
    }
    
    func onFail() {
        removeSpinner()
    }
}

extension AttendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attendViewModel.attends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = attendCollectionView.dequeueReusableCell(withReuseIdentifier: "AttendCell", for: indexPath) as! AttendCollectionViewCell
        cell.nameLabel.text = attendViewModel.attends[indexPath.row].Name
        cell.checkInLocationLabel.text = attendViewModel.attends[indexPath.row].DistanceInDesc
        cell.checkOutLocationLabel.text = attendViewModel.attends[indexPath.row].DistanceOutDesc
        
        if attendClicked[indexPath.row] {
            let cell = attendCollectionView.dequeueReusableCell(withReuseIdentifier: "AttendClickedCell", for: indexPath) as! AttendClickedCollectionViewCell
            cell.checkInLocationLabel.text = attendViewModel.attends[indexPath.row].DistanceInDesc
            cell.checkOutLocationLabel.text = attendViewModel.attends[indexPath.row].DistanceOutDesc
            return cell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if attendClicked[indexPath.row] {
            attendClicked[indexPath.row] = false
        } else {
            attendClicked[indexPath.row] = true
        }
        
        attendCollectionView.reloadData()
    }
    
    
}
