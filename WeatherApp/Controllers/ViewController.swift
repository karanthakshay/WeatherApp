//
//  ViewController.swift
//  WeatherApp
//
//  Created by Akshay A Karanth - (Digital) on 21/05/20.
//  Copyright © 2020 Akshay A Karanth - (Digital). All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //MARK: Outlets
    @IBOutlet weak var forecastListView: UITableView!
    @IBOutlet weak var isLoading: UIActivityIndicatorView!
    //MARK: Variables
    var foreCasts = [Forecast]()
    
    //MARK: View controller Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callWeatherAPI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Custom functions
    func callWeatherAPI() {
        let api = "\(BaseUrls.BASE_URL)\(BaseUrls.GET_WEATHER_LONDON)&appid=\(Constants.APPID)"
        showLoading(show: true)
        AF.request(api, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            self.showLoading(show: false)
            guard let data = responseData.data else {
                self.showAlert(title: "Error", message: responseData.error?.localizedDescription ?? "Something went wrong")
                return
            }
            do{
                let weather = try JSONDecoder().decode(Forecasts.self, from: data)
                self.foreCasts = weather.list
                self.forecastListView.reloadData()
            }
            catch let error{
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    func showLoading(show:Bool) {
        self.isLoading.isHidden=(!show)
        if(show){
            self.isLoading.startAnimating()
        }
        else{
            self.isLoading.stopAnimating()
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foreCasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ForcastTableViewCell else { return UITableViewCell()}
        cell.weatherMainLabel.text = (self.foreCasts[indexPath.item].weather.first?.main ?? "").uppercased()
        cell.weatherDescriptionLabel.text = (self.foreCasts[indexPath.item].weather.first?.description ?? "").uppercased()
        cell.temperature.text = String(format: "%dK", Int(self.foreCasts[indexPath.item].main.temp))
        cell.minTemp.text = String(format: "Min temp\n%dK", Int(self.foreCasts[indexPath.item].main.temp))
        cell.maxTemp.text = String(format: "Max temp\n%dK", Int(self.foreCasts[indexPath.item].main.temp))
        cell.date.text = self.foreCasts[indexPath.item].dt_txt
        cell.weatherDescriptionLabel.text = self.foreCasts[indexPath.item].weather.first?.description ?? ""
        if let icon = self.foreCasts[indexPath.item].weather.first?.icon{
            AF.request("\(BaseUrls.ICON_BASEURL)\(icon)@2x.png").responseImage { response in
                if case .success(let image) = response.result {
                    cell.icon.image = image
                }
            }
        }
        return cell
    }
    

}

