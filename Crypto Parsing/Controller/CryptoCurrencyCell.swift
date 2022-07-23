//
//  TableViewCell.swift
//  JSON Parsing
//
//  Created by Артем Сергеев on 22.07.2022.
//

import UIKit

class CryptoCurrencyCell: UITableViewCell {
    
    @IBOutlet var customViewCell: UIView!
    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var nameCell: UILabel!
    @IBOutlet var idCell: UILabel!
    @IBOutlet var priceCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell(with cryptoCurrency: CryptoCurrency, icon: Icon ) {
        
        configurateCell()
        
        nameCell.text = cryptoCurrency.name
        idCell.text = cryptoCurrency.id
        guard let price = cryptoCurrency.price else {return}
        priceCell.text = "\(round(price * 10000) / 10000) $"
        
        DispatchQueue.global().async {
            
            guard let image = icon.url  else { return }
            guard let imageUrl = URL(string: image) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.imageCell.image = UIImage(data: imageData)
            }
        }
    }
    
    private func configurateCell() {
        nameCell.textColor = .white
        idCell.textColor = .white
        customViewCell.backgroundColor = .darkGray
        customViewCell.layer.cornerRadius = 15
    }
}
