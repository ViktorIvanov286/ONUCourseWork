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
        self.cityLabel.backgroundColor = .white
        self.cityLabel.layer.cornerRadius = 10
        self.cityLabel.layer.masksToBounds = true
        
        self.temperatueScreen.backgroundColor = .white
        self.temperatueScreen.layer.cornerRadius = 10
        self.temperatueScreen.layer.masksToBounds = true
        
        self.minScreen.backgroundColor = .white
        self.minScreen.layer.cornerRadius = 10
        self.minScreen.layer.masksToBounds = true
        
        self.maxScreen.backgroundColor = .white
        self.maxScreen.layer.cornerRadius = 10
        self.maxScreen.layer.masksToBounds = true
        
        self.windScrenn.backgroundColor = .white
        self.windScrenn.layer.cornerRadius = 10
        self.windScrenn.layer.masksToBounds = true
        
        self.pressureScreen.backgroundColor = .white
        self.pressureScreen.layer.cornerRadius = 10
        self.pressureScreen.layer.masksToBounds = true
        
        self.humidityScreen.backgroundColor = .white
        self.humidityScreen.layer.cornerRadius = 10
        self.humidityScreen.layer.masksToBounds = true
        
        self.temperatureLabel.backgroundColor = .white
        self.temperatureLabel.layer.cornerRadius = 10
        self.temperatureLabel.layer.masksToBounds = true
        
        self.minTemp.backgroundColor = .white
        self.minTemp.layer.cornerRadius = 10
        self.minTemp.layer.masksToBounds = true
        
        self.maxTemp.backgroundColor = .white
        self.maxTemp.layer.cornerRadius = 10
        self.maxTemp.layer.masksToBounds = true
        
        self.humidity.backgroundColor = .white
        self.humidity.layer.cornerRadius = 10
        self.humidity.layer.masksToBounds = true
        
        self.wind.backgroundColor = .white
        self.wind.layer.cornerRadius = 10
        self.wind.layer.masksToBounds = true
        
        self.pressure.backgroundColor = .white
        self.pressure.layer.cornerRadius = 10
        self.pressure.layer.masksToBounds = true
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
            self.gifView.loadGif(name: self.gifBack)
            self.cityLabel.alpha = 0.5
            self.temperatureLabel.alpha = 0.5
            self.minTemp.alpha = 0.5
            self.maxTemp.alpha = 0.5
            self.wind.alpha = 0.5
            self.pressure.alpha = 0.5
            self.humidity.alpha = 0.5
            
            
            self.temperatueScreen.alpha = 0.5
            self.minScreen.alpha = 0.5
            self.maxScreen.alpha = 0.5
            self.windScrenn.alpha = 0.5
            self.pressureScreen.alpha = 0.5
            self.humidityScreen.alpha = 0.5
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
        }
    }
    
    func didFailWithError(error: Error) {
        print("Oops, it's an Error…")
    }
}
