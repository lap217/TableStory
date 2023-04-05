//
//  ViewController.swift
//  TableStory
//
//  Created by Park, Lauren on 3/22/23.
//

import UIKit
import MapKit


let data = [
    Item(name: "LBJ Student Center", neighborhood: "Downtown", desc: "The hub of activity on campus. LBJ Student Center is the perfect place for students to attend classes or club meetings, hangout, and grab a bite to eat. The University Bookstore is also located here.", lat: 29.88957777575879, long: -97.94450469092354, imageName: "rest1"),
    Item(name: "Albert B. Alkek Library", neighborhood: "Hyde Park", desc: "The main central library at Texas State. Alkek provides students access to computers, scanners, printers, and study rooms.", lat: 29.88904555758779, long: -97.94308370591796, imageName: "rest2"),
    Item(name: "Harris Dining Hall", neighborhood: "Mueller", desc: "A great place to stop by before0 or after working out at the recreation center, as it's right next door. Harris Dining Hall has a variety of food to choose from, breakfast included. ", lat: 29.888005015112544, long: -97.95163807632622, imageName: "rest3"),
    Item(name: "Student Recreation Center", neighborhood: "UT", desc: "With amentities like badminton, cardio machines, dance studios, and basketball the Student Recreation Center is a good place for students to get their blood pumping. Equipment can also be checked out here with proof of student i.d.", lat: 29.888878124751166, long: -97.95055097585275, imageName: "rest4"),
    Item(name: "Student Health Center", neighborhood: "Hyde Park", desc: "Student's one-stop healthcare clinic on campus. If students are ever feeling sick or in need of a check-up or medication, the Student Health Center will be fastest and most convenient.", lat: 29.890828467104114, long: -97.94616757346425, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var theTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
        
        
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      let image = UIImage(named: item.imageName)
                   cell?.imageView?.image = image
                   cell?.imageView?.layer.cornerRadius = 10
                   cell?.imageView?.layer.borderWidth = 5
                   cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowDetailSegue" {
                if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                    // Pass the selected item to the detail view controller
                    detailViewController.item = selectedItem
                }
            }
        }
        
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTable.delegate = self
        theTable.dataSource = self
        
        
        //set center, zoom level and region of the map
                let coordinate = CLLocationCoordinate2D(latitude: 29.88904555758779, longitude: -97.94308370591796)
                let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                mapView.setRegion(region, animated: true)
                
             // loop through the items in the dataset and place them on the map
                 for item in data {
                    let annotation = MKPointAnnotation()
                    let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                    annotation.coordinate = eachCoordinate
                        annotation.title = item.name
                        mapView.addAnnotation(annotation)
                        }

              

        // Do any additional setup after loading the view.
    }


}

