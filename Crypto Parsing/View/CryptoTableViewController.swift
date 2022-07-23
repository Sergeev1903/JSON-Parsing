//
//  TableViewController.swift
//  JSON Parsing
//
//  Created by Артем Сергеев on 22.07.2022.
//

import UIKit

class CryptoTableViewController: UITableViewController {
    
    private let url = "https://rest.coinapi.io/v1/assets/?apikey=9DAC0D76-49EC-434B-84A3-1C9E727848E7"
    
    private let urlIcon = "https://rest.coinapi.io/v1/assets/icons/100/?apikey=9DAC0D76-49EC-434B-84A3-1C9E727848E7"
    
    private var cryptoCurrencies = [CryptoCurrency]()
    private var cryptoCurrencyIcons = [Icon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchIconData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Crypto Currencies"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cryptoCurrencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCurrencyCell", for: indexPath) as! CryptoCurrencyCell

        let currency = cryptoCurrencies[indexPath.row]
        let icon = cryptoCurrencyIcons[indexPath.row]
        cell.setUpCell(with: currency, icon: icon)
        
        tableView.separatorInset = .init(top: 0, left: 15, bottom: 0, right: 15)

        return cell
    }
    
    //MARK: Parsing Data
    private func fetchData() {
        guard let url = URL(string: url) else { return }
        print("fetch url")
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.cryptoCurrencies = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("Error: ", error)
            }
            }.resume()
    }
    
    private func fetchIconData() {
        guard let urlIcon = URL(string: urlIcon) else { return }
        
        URLSession.shared.dataTask(with: urlIcon) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                self.cryptoCurrencyIcons = try JSONDecoder().decode([Icon].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("Error: ", error)
            }
            }.resume()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
