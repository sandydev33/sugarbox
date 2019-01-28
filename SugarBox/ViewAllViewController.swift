//
//  ViewAllViewController.swift
//  SugarBox
//
//  Created by khim singh on 25/05/17.
//  Copyright © 2017 eSoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewAllViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource{
   let regionRadius: CLLocationDistance = 10000
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterContainerYConst: NSLayoutConstraint!
    var filterBtn:Array<String>! = nil
    var stateSwipe:Array<Bool>? = nil
    var NewCell:FilterCell? = nil
    var filterY:CGFloat=0
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var filterViewHolder: UIView!
    
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBtn = ["Malls","Cafes","Lorem","Ipsum","Color"]
        let mySwitch = UISwitch()
        mySwitch.center = view.center
        mySwitch.setOn(false, animated: false)
        mySwitch.tintColor = UIColor.green
        mySwitch.onTintColor = UIColor.green
        mySwitch.thumbTintColor = UIColor.lightGray
        mySwitch.backgroundColor = UIColor.clear
       // mySwitch.layer.transform = CATransform3DMakeScale(1, 1, 0)
        mySwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControlEvents.valueChanged)
        let item = UIBarButtonItem(customView: mySwitch)
        //=====================================================================
        let navLabel = UIButton(type: .custom)
        navLabel.setTitle("Map View", for: .normal)
        navLabel.setTitleColor(UIColor.gray, for: .normal)
        navLabel.backgroundColor = UIColor.gray
        let item2 = UIBarButtonItem(customView: navLabel)

        self.navigationItem.setRightBarButtonItems([item,item2], animated: true)
        // Do any additional setup after loading the view.
        self.stateSwipe = Array<Bool> ()
        for _ in 0..<self.filterBtn.count {
            self.stateSwipe?.append(NSNumber(value: false) as! Bool)
        }
        self.mapLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filterViewHolder.layer.cornerRadius=10.0
        self.applyButton.isHidden=true
        self.resetButton.isHidden=true
         self.filterContainerYConst.constant = (self.filterView.frame.size.height)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius  * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.mapType = .standard
    }

    
    func mapLoad () {
        let initialLocation = CLLocation(latitude: 26.8556, longitude: 80.9524)
        centerMapOnLocation(location: initialLocation)
        let artwork = Artwork(title: "Adidas",
                              locationName: "Charbagh",
                              discipline: "Fit Company",
                              coordinate: CLLocationCoordinate2D(latitude: 26.8313, longitude: 80.9180))
        
        let artwork2 = Artwork(title: "Arrow",
                               locationName: "Fun Mall",
                               discipline: "Suitings",
                               coordinate: CLLocationCoordinate2D(latitude: 26.8582, longitude: 80.9763))
        let artwork3 = Artwork(title: "Barista",
                               locationName: "Wave",
                               discipline: "Cofee Shop",
                               coordinate: CLLocationCoordinate2D(latitude: 26.8696, longitude: 80.9973))
        let artwork4 = Artwork(title: "Ccd",
                               locationName: "Apple Inc",
                               discipline: "Technology",
                               coordinate: CLLocationCoordinate2D(latitude: 26.8313, longitude: 80.9457))
        let artwork5 = Artwork(title: "BikanareWala",
                               locationName: "Zoo",
                               discipline: "Animal Jungle",
                               coordinate: CLLocationCoordinate2D(latitude: 26.8457, longitude: 80.9546))
        
        mapView.delegate = self
        
        mapView.addAnnotations([artwork,artwork2,artwork3,artwork4,artwork5])
    }
    func switchChanged(sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")
        if sender.isOn{
        collectionView.isHidden = true
        }else{
        collectionView.isHidden = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemsPerRow:CGFloat = 3.2
           // let hardCodedPadding:CGFloat = 0.1
            let itemWidth = (collectionView.bounds.width / itemsPerRow)
            let itemHeight = collectionView.bounds.height*0.2
            return CGSize(width: itemWidth, height: itemHeight)
    }
    @IBAction func filterBtn(_ sender: Any) {
        filterView.isHidden = false
        self.filterContainerYConst.constant =  0
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
        self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.applyButton.isHidden=false
            self.resetButton.isHidden=false
            
        })
        
 
        
    }
    //Table View for filter Screen
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterBtn.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterCell
       cell.checkView.tag = indexPath.row
        cell.checkLabel.text = filterBtn[indexPath.row]
        NewCell = cell
         if (stateSwipe? [cell.checkView.tag])! {
            cell.checkView.image = UIImage(named: "checkedpng")
         }else{
         cell.checkView.image = UIImage(named: "uncheked")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let cell = tableView.cellForRow(at: indexPath!) as! FilterCell
        
        
        let collapsed = stateSwipe? [cell.checkView.tag]
        for i in 0..<filterBtn.count {
            if cell.checkView.tag == i {
                stateSwipe? [cell.checkView.tag] = NSNumber(value: !collapsed!) as! Bool
                
                if cell.checkView.image == UIImage(named: "checkedpng") {
                    cell.checkView.image = UIImage(named: "uncheked")
                }else{
                cell.checkView.image = UIImage(named: "checkedpng")
                }
                
                }
        }
     
    }
    // MARK: - Gestures
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        
         self.filterContainerYConst.constant = (self.filterView.frame.size.height)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.applyButton.isHidden=true
            self.resetButton.isHidden=true
        }, completion: { (finished: Bool) in
            self.filterView.isHidden = true
            
            self.view.layoutIfNeeded()
        })
        
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func filterCancelBtn(_ sender: Any) {
        filterView.isHidden = true
    }
    
    @IBAction func resetBtn(_ sender: Any) {
      
//        let selectedValue = stateSwipe?.enumerated().flatMap{ $1 ? $0 : nil }
//        print(selectedValue)
//        for i in 0..<(selectedValue?.count)! {
//         NewCell?.checkView.image = UIImage(named: "uncheked")
//        }
        self.stateSwipe = Array<Bool> ()
        for _ in 0..<self.filterBtn.count {
            self.stateSwipe?.append(NSNumber(value: false) as! Bool)
        }
            tableView.reloadData()
        }
   

}
