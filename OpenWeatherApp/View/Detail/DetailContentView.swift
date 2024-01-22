//
//  DetailContentView.swift
//  OpenWeatherApp
//
//  Created by Şükrü on 19.01.2024.
//

import Foundation
import UIKit

class DetailContentView: UIView {

    // Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherDetailItemCell.self, forCellReuseIdentifier: Constants.shared.weatherDetailItemCell)
        addSubview(tableView)
        return tableView
    }()
    
    // Variables
    lazy var weatherData: [WeatherForecast]? = []
    
    // Update TableView
    func updateTableView(data: [WeatherForecast]) {
        self.weatherData = data
        self.tableView.reloadData()
    }

}

extension DetailContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherData = self.weatherData?.count else { return 0 }
        return weatherData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.weatherDetailItemCell, 
                                                       for: indexPath) as? WeatherDetailItemCell else {
            return UITableViewCell()
        }
                
        if let data = self.weatherData?[indexPath.row] {
            cell.bind(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
