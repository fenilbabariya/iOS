@IBAction func Submirt(_ sender: Any) {
        // define url
        let irequest = NSMutableURLRequest(url: NSURL(string: "https://patelhinalm9.000webhostapp.com/student_insert_data.php") as! URL)
        irequest.httpMethod = "POST"        
        if(mySid.text! != nil){
            s = Int(mySid.text!)
            
        }else{ s = 0 }
        n = mySname.text!
        c = myCity.text!
        m = Int(myMno.text!)
        let putString = "isid=\(s)&isname=\(n)&icity=\(c)&imno=\(m)"
        
        irequest.httpBody = putString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: irequest as URLRequest)\
        task.resume()
        print("Record Inserted")
    }
//Data Upload Task 
//22/06/2022
let url = URL(string: "https://api.rku.ac.in/treeroutes/treeinsert.php")!
        var request = URLRequest(url: url)
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"   
        let parameters:[String:Any] = [
            "email_address":email,
            "botonical_name":botonicalNameLabel.text!,
            "latitude":lat,
            "longitude":log,
            "location_description":locationDescLabel.text!,
            "angle":angleLable.text!,
            "distance_from_trunck":treedistanceLabel.text!,
            "canopy_diameter":canopydistanceLabel.text!,
            "tree_girth":girthDistanceLAbel.text!,
            "age":ageLabel.text!,
            "health":healthLabel.text!,
            "context":contextLabel.text!,
            "remark":remarkLabel.text!,
            "photo":iimg
        ]
       	    request.httpBody = parameters.percentEncoded()          
             let task = URLSession.shared.dataTask(with: request)
             task.resume()
//Json Parsing
import UIKit
 
class ViewController:
    UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var imgArray = [String]()
    var titleArray = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! myTableViewCell
        
        cell.myTitle.text = titleArray[indexPath.row]
        //cell.myTitle.text = "RKU"
        let iURL = URL(string: imgArray[indexPath.row])
        let imgData = try! Data(contentsOf: iURL!)
        cell.myImage.image = UIImage(data: imgData)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 15
    
        return cell
    }
 
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadnewdata()
    }
 
    func loadnewdata()
    {        
        let myNewUrl = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-05-20&sortBy=publishedAt&apiKey=e25fb41c8d7e46d7a94ab8b3e837642c")
        
        let request = URLRequest(url: myNewUrl!)
        
        //create task to esatablish connection = newapi.org
         
        let task = try! URLSession.shared.dataTask(with: request)
        {
            (idata,URLResponse,Error) in
            
            let jsonData = try! JSONSerialization.jsonObject(with: idata!, options: .mutableContainers) as! NSDictionary
            
            let articles = jsonData.value(forKey: "articles") as! NSArray
            let title_info = articles.value(forKey: "title")
            let img_info = articles.value(forKey: "urlToImage")
            
//            self.titleArray = title_info as! [String]
//            self.imgArray = img_info as! [String]
//
//            print(self.titleArray)
//            DispatchQueue.main.async {
//                self.myTableView.reloadData()
//            }
            
            // Print the articles , title_info and img_info
            
            //print(title_info)
        }
        
        task.resume()
    }
 
}
 
 
 
//MapKit View
//Multiple locations point
//  ViewController.swift
//  MultiplePoints Maps
 
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
//  ViewController.swift
//  AnimationII
 
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
//  ViewController.swift
//  MeditationPlayer|
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
//  ViewController.swift
//  VideoPlayer(Online)
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
//  ViewController.swift
//  DataPickerView
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
//  SecondViewController.swift
//  DataPickerView
 
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
//  ViewController.swift
//  StudentDB
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
//JSON - Part - I
//  ViewController.swift
//  News
 
import UIKit
 
class ViewController: UIViewController {
 
    var imgList = [String]()
    var titleList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadnews()
    }
 
    func loadnews()
    {
        let myurl = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-03-01&sortBy=publishedAt&apiKey=e25fb41c8d7e46d7a94ab8b3e837642c")
        
        let request = URLRequest(url: myurl!)
        
        //task
        let task = try! URLSession.shared.dataTask(with: request)
        { [self]
            (data,URLResponse,Error) in
            
            let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
            let article = jsonData["articles"] as! NSArray
            let title =  article.value(forKey: "title")
            
            self.titleList = title as! [String]
            let imgUrl = article.value(forKey: "urlToImage")
            self.imgList = imgUrl as! [String]
            print(data,title,imgUrl)
        }   
        task.resume()
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
//  ImageAlert
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
Session 1 : Fundamentals of Swift
Date : 23/02/2022
LAB : 2MCA4
import UIKit
/*
print("Hello World")
//var a:Int = 20
//var name:String = "Dhaval"
var a = 20
var b = 30
var c = a + b
var name = "Dhaval"
print(a,b,c,name,separator: "--",terminator: "\nThank You")
*/
//Function with return type
func display()
{
    print("Hello RKU")
}
display()
func add(a:Int,b:Int)
{
    var c = a + b
    print(c)
}
add(a: 20, b: 50)
//Function with return type
func sub(a:Int,b:Int) -> Int
{
    var c = b - a
    return c
}
var ans = Double(sub(a: 30, b: 50))
ans = ans + (ans * 0.18) 
print(ans)
//Separator (Separate values with particular seperator)

print(10,20,"Fenil",separator:"-")

//Terminator (Terminator prints at the end of the statement)

print(10,20,"Fenil",separator:"-",terminator:"\nThank you"))


//Function

func display()
{
    print("Swift")
}

display()

//Function with parameter

func parameter(x:Int,y:Int)
{
    let z = x + y
    print(z)
}

parameter(x:10,y:20)

//Function with return

func withreturn(a:Int,b:Int)-> Int
{
    let c = a + b
    return c
}

var ans = withreturn(a:10,b:30)
print(ans)

//Minimum from 3 number

var x = 100
var y = 200
var z = 30

if(x < y && x < z)
{
    print("X is min")
}
if(y < x && y < z)
{
    print("Y is min")
}
if(z < y && z < x)
{
    print("Z is min")
}


//Prime, Not Prime

var flag = 0
var n:Int = 3

for i in 2...n-1
{
    if(n%i == 0)
    {
        flag = 1
    }
}

if(flag == 1)
{
    print("\(n) Number is Non-Prime")
}
else
{
    print("\(n) Number is Prime")
}
//Factorial number

var fact = 1
var num = 5

for i in 1...num
{
    fact = fact * i
}

print("Factorial of \(num) is: ",fact)

//Factorial using recursion

func fact(n:Int)->Int
{
    if(n == 1)
    {
        return 1;
    }
    else
    {
        return(n * fact(n:n-1))
    }
}


var ans = fact(n:5)
print(ans)

//Swap without third variable

var a = 10
var b = 20

a = a + b
b = a - b
a = a - b

print(a,b)


//Palindrome

var num = 10
var temp = num
var z = 0
var i = 0
for i in 1...num
{
    i = num % 10
    z = (z * 10) + i
    num = num / 10
}


//Fibonacci

var n1 = 0
var n2 = 1
var n3 = 0
var c = 10

for _ in 2...c-1
{
    n3 = n1 + n2
    print(n3)
    n1 = n2
    n2 = n3
}
//Dictionary
var someDict:[Int:String] = [1:"One", 2:"Two", 3:"Three"]
//enum
enum names {
   case Swift
   case Closures
}

var lang = names.Closures
lang = .Closures

switch lang {
   case .Swift:
      print("Welcome to Swift")
   case .Closures:
      print("Welcome to Closures")
   default:
      print("Introduction")
}