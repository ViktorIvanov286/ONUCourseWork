import UIKit
import SwiftGifOrigin

class DetailsForSaved: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var temperatueScreen: UILabel!
    @IBOutlet weak var minScreen: UILabel!
    @IBOutlet weak var maxScreen: UILabel!
    @IBOutlet weak var windScrenn: UILabel!
    @IBOutlet weak var pressureScreen: UILabel!
    @IBOutlet weak var humidityScreen: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    var weatherManager = WeatherManager()
    var city: CitiesWeather?
    var gifBack = String()
    var imageForCell: UIImageView?
    var index: IndexPath?
    
    func setView() {
        self.cityLabel.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.2009001359)
        self.cityLabel.layer.cornerRadius = 10
        self.cityLabel.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        

        weatherManager.delegate = self
        cityLabel.text = "\((city?.city)!)"
        weatherManager.fetchWeather(cityName: "\((city?.city)!)")
        
        self.gifView.alpha = 0
        self.cityLabel.alpha = 0
        self.temperatureLabel.alpha = 0
        self.minTemp.alpha = 0
        self.maxTemp.alpha = 0
        self.wind.alpha = 0
        self.pressure.alpha = 0
        self.humidity.alpha = 0
        
        self.temperatueScreen.alpha = 0
        self.minScreen.alpha = 0
        self.maxScreen.alpha = 0
        self.windScrenn.alpha = 0
        self.pressureScreen.alpha = 0
        self.humidityScreen.alpha = 0
        
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.0) {
            self.gifView.alpha = 1
//            self.gifView.loadGif(name: self.gifBack)
            self.cityLabel.alpha = 1
            self.temperatureLabel.alpha = 1
            self.minTemp.alpha = 1
            self.maxTemp.alpha = 1
            self.wind.alpha = 1
            self.pressure.alpha = 1
            self.humidity.alpha = 1
            
            
            self.temperatueScreen.alpha = 1
            self.minScreen.alpha = 1
            self.maxScreen.alpha = 1
            self.windScrenn.alpha = 1
            self.pressureScreen.alpha = 1
            self.humidityScreen.alpha = 1
        }
    }
}

extension DetailsForSaved: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString + " ºC"
            self.minTemp.text = "\(weather.tempMin) ºC"
            self.maxTemp.text = "\(weather.tempMax) ºC"
            self.wind.text = "\(weather.wind) km/h"
            self.pressure.text = "\(weather.pressure) Pa"
            self.humidity.text = "\(weather.pressure) %"
            self.gifView.loadGif(name: weather.backgroundImage)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
        print("Oops, it's an Error…")
    }
}
