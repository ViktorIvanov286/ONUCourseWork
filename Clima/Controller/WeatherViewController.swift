import UIKit
import CoreLocation
import SwiftGifOrigin
import AVFoundation
import JGProgressHUD

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var celciumLabel: UILabel!
    @IBOutlet weak var celciumLetterLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    var cities: [CitiesWeather] = [CitiesWeather]()
    let hud = JGProgressHUD(style: .dark)
    
    func cityHasAlreadySaved() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        hud.textLabel.text = "You have already saved this city!"
        hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 2.0)
    }
    
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        hud.textLabel.text = "Success"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.0)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        if DataBaseManager.share.existsInDataBase(name: cityLabel.text ?? "") {
            cityHasAlreadySaved()
        } else {
            DataBaseManager.share.saveContext(cityName: cityLabel.text ?? "")
            success()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonOutlet.layer.cornerRadius = 10
        saveButtonOutlet.layer.masksToBounds = true
        
        checkSavingData()
        
        conditionImageView.alpha = 0
        temperatureLabel.alpha = 0
        cityLabel.alpha = 0
        searchTextField.alpha = 0
        backgroundImage.alpha = 0
        locationButton.alpha = 0
        celciumLabel.alpha = 0
        celciumLetterLabel.alpha = 0
        searchButton.alpha = 0
        saveButtonOutlet.alpha = 0
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        
        searchTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBackgroundView()
    }
    
    func showBackgroundView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.backgroundImage.alpha = 1
        }) { (true) in
            self.showLocationTextSearch()
        }
    }
    
    func showLocationTextSearch() {
        UIView.animate(withDuration: 1.0, animations: {
            self.locationButton.alpha = 1
            self.searchTextField.alpha = 1
            self.searchButton.alpha = 1
        }) { (true) in
            self.showConditionLabel()
        }
    }
    
    func showConditionLabel() {
        UIView.animate(withDuration: 1.0, animations: {
            self.conditionImageView.alpha = 1
        }) { (true) in
            self.showTempCelcium()
        }
    }
    
    func showTempCelcium() {
        UIView.animate(withDuration: 1.0, animations: {
            self.temperatureLabel.alpha = 1
            self.celciumLabel.alpha = 1
            self.celciumLetterLabel.alpha = 1
        }) { (true) in
            self.showCityName()
        }
    }
    
    func showCityName() {
        UIView.animate(withDuration: 1.0, animations: {
            self.cityLabel.alpha = 1
        }) { (true) in
            self.showSaveButton()
        }
    }
    
    func showSaveButton() {
        UIView.animate(withDuration: 1.0) {
            self.saveButtonOutlet.alpha = 1
        }
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3.0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func checkSavingData() {
        if defaults.value(forKey: Keys.cityName) == nil {
            cityLabel.text = "Madrid"
        } else {
            let city = defaults.value(forKey: Keys.cityName) as? String ?? ""
            cityLabel.text = city
        }
        
        if defaults.value(forKey: Keys.temperature) == nil {
            temperatureLabel.text = "15.0"
        } else {
            let temp = defaults.value(forKey: Keys.temperature) as? String ?? ""
            temperatureLabel.text = temp
        }
        
        if defaults.value(forKey: Keys.conditionName) == nil {
            conditionImageView.image = UIImage(systemName: "cloud.bolt")
        } else {
            let condition = defaults.value(forKey: Keys.conditionName) as? String ?? ""
            conditionImageView.image = UIImage(systemName: condition)
        }
        
        if defaults.value(forKey: Keys.backgroundGif) == nil {
            backgroundImage.loadGif(name: "CloudsAndSun")
        } else {
            let backgroundGif = defaults.value(forKey: Keys.backgroundGif) as? String ?? ""
            backgroundImage.loadGif(name: backgroundGif)
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.backgroundImage.loadGif(name: weather.backgroundImage)
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
            // UserDefaults
            self.defaults.set(self.cityLabel.text, forKey: Keys.cityName)
            self.defaults.set(self.temperatureLabel.text, forKey: Keys.temperature)
            self.defaults.set(weather.conditionName, forKey: Keys.conditionName)
            self.defaults.set(weather.backgroundImage, forKey: Keys.backgroundGif)
        }
    }

    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.hud.textLabel.text = error.localizedDescription
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.5)
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.hud.textLabel.text = error.localizedDescription
        self.hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        self.hud.show(in: self.view)
        self.hud.dismiss(afterDelay: 2.5)
    }
}
