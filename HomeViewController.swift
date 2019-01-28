//
//  HomeViewController.swift
//  SugarBox
//
//  Created by khim singh on 25/05/17.
//  Copyright © 2017 eSoft. All rights reserved.NearestSugarBoxCell
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var tableView: UITableView!
    var sugarBoxArray:Array<String>!=nil
    var ottArray:Array<String>!=nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear( animated)
        sugarBoxArray = ["Cowh","Cogw","Cowf","Cowd","Cows","Cowa"]
        ottArray = ["Cowh","Cogw","Cowf","qowd","qows","qowa"]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Tableview Delegates and Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }else if indexPath.section == 1{
        return 145.0
        }
        else if indexPath.section == 2{
        return 145.0
        }
        else {
         return 180.0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "near", for: indexPath) as! NearestSugarBoxCell
            print("TAg------------------------\(cell.collectionView.tag)")
            cell.collectionView.reloadData()
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "sugar", for: indexPath) as! SugarBoxNetworksCell
            return cell        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ott", for: indexPath) as! SugarBoxNetworksCell
            return cell
        }
      
    }
    
    
    
//MARK: - Collection view Delegates and Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == CollectionViewTags.homeScreenNearCollectionCell.rawValue{
            return 10
        }
        if collectionView.tag == CollectionViewTags.sugarboxCollectionViewCellTag.rawValue{
        return 4
        }else{
        return 4
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      self.performSegue(withIdentifier: "detail", sender: self)
        
        
  
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //nearCollectionCell
        
        print("Collection view tag index:---------------\(collectionView.tag)")
        if collectionView.tag == CollectionViewTags.homeScreenNearCollectionCell.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearCollectionCell", for: indexPath) as!
            NearestSugarBoxCollectionView
            return cell
        }
        if collectionView.tag == CollectionViewTags.sugarboxCollectionViewCellTag.rawValue{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sugarBoxCell", for: indexPath) as! SugarboxCollectionCell
           
            
            return cell

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ottCell", for: indexPath)  as! OTTPartnersCollectionCell
           
            
            return cell

        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == CollectionViewTags.homeScreenNearCollectionCell.rawValue{
            let itemWidth = (collectionView.bounds.width / 2) + 50
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
            
        }
        if collectionView.tag == CollectionViewTags.sugarboxCollectionViewCellTag.rawValue{
            let itemsPerRow:CGFloat = 3.8
            let hardCodedPadding:CGFloat = 8
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
            let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)
        }else{
            let itemsPerRow:CGFloat = 2.7
            let hardCodedPadding:CGFloat = 9
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
            let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }
       // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            
        }
    }
    

}
