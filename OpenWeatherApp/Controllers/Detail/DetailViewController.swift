//
//  DetailViewController.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 17.01.2024.
//

import UIKit

class DetailViewController: UIViewController {

    // Views
    private lazy var contentView: DetailContentView = {
        let contentView = DetailContentView(frame: view.frame)
        contentView.backgroundColor = .white
        view.addSubview(contentView)
        return contentView
    }()
    
    // Variables
    lazy var dayToFilter: String? = nil
    lazy var weatherData: WeatherForecastDataModel? = nil
    private lazy var weatherViewModel = WeatherViewModel()

    // Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // Will Appear for update weather
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Weather Detail"
        
        // prevent reload weather data
        if contentView.weatherData == nil {
            return
        }
        
        // Filtered weather and update view
        if let weatherData = self.weatherData, let weatherDay = self.dayToFilter {
            contentView.updateTableView(data: weatherViewModel.getFilterWeather(data: weatherData, day: weatherDay))
        }
    }
}
