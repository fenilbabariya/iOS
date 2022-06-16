//MapKit View
//Multiple locations
 
import UIKit
import MapKit
 
 
class ViewController: UIViewController,MKMapViewDelegate {
    let locations = [
        ["Title":"Watson Museum","Subtitle":"Jawahar road, Rajkot","Latitude":22.30060825544769 ,"Longitude":70.80190374340049,"image":"th.png"],
        ["Title":"Mahatma Gandhi museum","Subtitle":"Jubilee chowk, Rajkot","Latitude":22.298533062932492 ,"Longitude":70.80185592627736,"image":"th.png"],
        ["Title":"Rotary Dolls museum","Subtitle":"yagnik road, Rajkot","Latitude":22.294105876020428 ,"Longitude":70.7911996262773,"image":"th.png"]]
    
    //Map Link : https://maps.google.com/?q=<lat>,<lng>
    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        
        
        for location in locations
        {
            //Step 1: Location 2D
            let loc = CLLocationCoordinate2D(latitude: location["Latitude"] as! Double, longitude: location["Longitude"] as! Double)
            //Step 2: Span & Region
            let ispan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let iregion = MKCoordinateRegion(center: loc, span: ispan)
            //Step 3: Pointer
            let pointer = MKPointAnnotation()
            pointer.coordinate = loc
            pointer.title = location["Title"] as! String
            pointer.subtitle = location["Subtitle"] as! String
            
            myMapView.mapType = .standard
            myMapView.region = iregion
            myMapView.addAnnotation(pointer)
        }
        
    }
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pointer = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        //pointer.image = UIImage(named: "th1.png")
       pointer.glyphImage = UIImage(named: "th.png")
        return pointer
    }
  
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Function will be called whenever point/location is clicked")
        
        var selectedtitle = view.annotation?.title!
        var selectedsubtitle = view.annotation?.subtitle!
        var lat = view.annotation?.coordinate.latitude
        var long = view.annotation?.coordinate.longitude
        
        var maplink = "https://maps.google.com/?q=\(Double(lat!)),\(Double(long!))"
        //A
        //Title : Inox Cinema
        //Kalawad Road
        //https://map.google.com/?q=20.8989,71,0908098
        
        let shareViewController = UIActivityViewController(activityItems: ["Title : \(selectedtitle)",selectedsubtitle,maplink], applicationActivities: nil)
        
        shareViewController.popoverPresentationController?.sourceView = view.self
        
        self.present(shareViewController,animated: true,completion: nil)
        
        
        
    }
    
    
    
    
    
} 
 
//Animation II
 
import UIKit
 
class ViewController: UIViewController {
 
    @IBOutlet weak var Btn2: UIButton!
    @IBOutlet weak var Btn1: UIButton!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image1.alpha = 0
        image2.alpha = 0
        UIView.animate(withDuration: 6, delay: 0, options: .curveEaseOut, animations: {
            self.image1.alpha = 1
            self.image2.alpha = 1
        }, completion: nil)
        
        //Right to Center of X
        image1.center.x = view.bounds.width
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut, animations: {
            self.image1.center.x = self.view.bounds.width/2
        }, completion: nil)
        
        //Top to center of Y
        image2.center.y = view.bounds.height
        UIView.animate(withDuration: 3, delay: 1, options: .curveEaseOut, animations: {
            self.image2.center.y = self.view.bounds.height / 2
        }, completion: nil)
        
    }
 
    @IBAction func Btn1(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
            self.Btn1.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: {
                self.Btn1.transform = CGAffineTransform.identity
            }, completion: nil)
        })
        
    }
    
    @IBAction func Btn2(_ sender: Any) {
    }
}
 
 
 
 
 
 
//Animation
 
 myImage.alpha = 0
 
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
            self.myImage.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 3, delay: 1.5, options: .curveEaseOut, animations: {
            self.myLabel.center.y += 600
        }, completion: nil)
 
 
 
//Audio Player – with CollectionView

 
import UIKit
import AVKit
import AVFoundation
 
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var thumbnilImg: UIImageView!
    @IBOutlet weak var shortView: UILabel!
    
    @IBOutlet weak var SongName: UILabel!
    @IBOutlet weak var myView: UIView!
    var titleList = ["Harmony to Life","Meditation","Sound of Bird","Positive Energy"]
    var imgList = ["hm.jpg","meditation.jpg","pe.jpg","positiveenergy.jpg"]
    var mp3List = ["hm","meditation","pe","positiveenergy"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! myCollectionCell
        cell.myImage.image = UIImage(named: imgList[indexPath.row])
        cell.myImage.layer.cornerRadius = cell.myImage.frame.width / 2
        return cell
        
    }
    var player:AVAudioPlayer?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedindex = indexPath.row
        print(selectedindex)
        
       
        
        let mp3Path = Bundle.main.path(forResource: mp3List[indexPath.row], ofType: "mp3")
        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: mp3Path!))
        
        if player!.isPlaying == false
        {
            SongName.text = titleList[indexPath.row]
            thumbnilImg.image = UIImage(named:imgList[selectedindex])
            thumbnilImg.layer.cornerRadius = 16
            player!.prepareToPlay()
            player!.play()
            myView.isHidden = false
        }else
        {
            myView.isHidden = true
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        myView.isHidden = true
        player?.stop()
    }
    @IBAction func pause(_ sender: Any) {
        if (player?.isPlaying == true)
        {
            player?.pause()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if (player?.isPlaying == true)
        {
            player?.stop()
            player?.prepareToPlay()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.isHidden = true
        myView.layer.cornerRadius = 15
        myView.backgroundColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.5)
        myView.layer.shadowColor = CGColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1)
        myView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
 
 
}
 
 
 
 
//Video Player Online/Offline

 
import UIKit
import AVKit
import AVFoundation
 
class ViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func playVideo(_ sender: Any) {
        //import AVKit
        //import AVFoundation
        //Online
        /*let vUrl = URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_5MB.mp4")
        
        let video_player = AVPlayer(url: vUrl!)
        
        let controller = AVPlayerViewController()
        
        controller.player = video_player
        
        self.present(controller,animated: true,completion: nil)
        */
        //Offline
        
        let vpath = (try! Bundle.main.path(forResource: "video1", ofType: "mp4"))!
        
        let video_player = AVPlayer(url:URL(fileURLWithPath: vpath))
        
        let controller = AVPlayerViewController()
        
        controller.player = video_player
        
        self.present(controller,animated: true,completion: nil)
            
        }
        
} 
 
//Dynamic PickerView
 
import UIKit
 
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    var list = ["USA","India","UAE"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
 
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    
    
    @IBOutlet weak var countryName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func selectCountry(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .lightGray
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
           toolBar.barStyle = .blackTranslucent
           toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
           self.view.addSubview(toolBar)
    }
    
    
    @objc func onDoneButtonTapped() {
        countryName.text! = list[picker.selectedRow(inComponent: 0)]
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
}
 
//SQLite 3 Retrieve Data -  Picker View
 
 
import UIKit
import SQLite3
 
class SecondViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
   
    var countrylist = [String]()
    //var countrylist = ["a","b","c"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countrylist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countrylist[row]
    }
    
    @IBOutlet weak var myPickerView: UIPickerView!
    var dbPointer:OpaquePointer?
    var dataPointer:OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let dbFile = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("CountryDB")
        sqlite3_open(dbFile.path, &dbPointer)
        
        if sqlite3_prepare(dbPointer, "select * from country", -1, &dataPointer, nil) == SQLITE_OK
        {
            while(sqlite3_step(dataPointer) == SQLITE_ROW)
            {
                var title = String(cString: sqlite3_column_text(dataPointer, 0))
                countrylist.append(title)
                
               // DispatchQueue.main.async {
                 //   self.myPickerView.reloadAllComponents()
               // }
                print(title)
            }
        }
    }
 
 
}

//SQLite 3 Insert Data
 
import UIKit
//Step 1 : Import required SQLite Library
import SQLite3
 
class ViewController: UIViewController {
 
    var dpPointer:OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Database create
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Student")
        
        // open db
        sqlite3_open(filePath.path, &dpPointer)
        
        //table create
        var t1 = "create table if not exists stu(id int,name text,marks int,city text)"
        
        
        //SQLite3.sqlite3_exec(dpPointer, t1, nil, nil, nil)
     if sqlite3_exec(dpPointer, t1, nil, nil, nil) == SQLITE_OK
        {
         print("Table Created...")
        }else
        {
            print("Error in a query...")
        }
        
    }
 
    //Action of Button
    func insertData()
    {
       var t2 = "insert into stu values (1,'DMN',34,'Rajkot')"
       // var t2 = "insert into stu values ('\(rollNo.text!)','"\(name.text!)"','\(marks.text!)','"\(city.text!)"')"
        if sqlite3_exec(dpPointer, t2, nil, nil, nil) == SQLITE_OK
        {
            print("Recored Inserted successfully..")
        }
        
    }
 
} 
 
//TableView
 
import UIKit
 
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    var listImage = ["https://media.zigcdn.com/media/model/2021/Nov/amg-a45-5_360x240.jpg","https://media.zigcdn.com/media/model/2021/Sep/amg-glc-43_360x240.jpg","https://media.zigcdn.com/media/model/2021/Sep/amg-e-63_360x240.jpg","https://media.zigcdn.com/media/model/2021/Aug/amg-gle-63_360x240.jpg"]
    var listTitle = ["Mercedes-Benz AMG A45 S","Mercedes-Benz AMG GLC 43","Mercedes-Benz AMG E 63","Mercedes-Benz AMG GLE 63 S"]
    var listPrice = ["Rs. 79.50 Lakh","Rs. 85.40 Lakh","Rs. 1.73 Crore","Rs. 2.10 Crore"]
    
   // var imgArray = ["1.jpg","2.jpg","3.jpg","4.jpg"]
    
    // No of items/rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTitle.count
    }
    
    // value of each item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! myTableViewCell
        cell.CarName.text = listTitle[indexPath.row]
        cell.CarPrice.text = listPrice[indexPath.row]
        let iurl = URL(string: listImage[indexPath.row])
        let request = try! Data(contentsOf: iurl!)
        cell.myImage.image = UIImage(data: request)
        
        //cell.myImage.image = UIImage(named: imgArray[indexPath.row])
        return cell
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
 
}
 
//UIImageView and Alert Controller
 
import UIKit
 
class ViewController: UIViewController {
 
    //Create outlets here
    
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to show static image from project dir
        myImage.image = UIImage(named: "hack.jpg")
    }
 
    //Create Actions here
    @IBAction func submit(_ sender: Any) {
        //click event for submit
        
        let alert = UIAlertController(title: "Warning", message: "Do you want to load image from URL?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            ACTION in
            self.change_image()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        self.present(alert,animated: true,completion: nil)
        
    }
    
    func change_image()
    {
        //OPEN Image from URL
        let imgURL = URL(string: "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png")
        let imgData = try! Data(contentsOf: imgURL!)
        myImage.image = UIImage(data: imgData)
    }
}