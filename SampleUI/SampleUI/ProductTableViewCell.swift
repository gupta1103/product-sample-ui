//
//  ProductTableViewCell.swift
//  SampleUI
//
//  Created by Akanksha Gupta on 23/07/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
            let view = UIView()
            return view
        }()
    
    internal lazy var productImageView: UIImageView = {
        let productImage = UIImageView()
        productImage.backgroundColor = .systemGray
        return productImage
    }()
    
    internal var productName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    internal lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    internal lazy var productOfferPrice: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(16)
        return label
    }()
    
    internal lazy var productStrikeThroughPriceDisplay: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = label.font.withSize(12)
        label.textColor = .red
        return label
    }()
    
    internal lazy var productBookButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView()
    {
        contentView.addSubview(containerView)
        containerView.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        containerView.addSubview(productImageView)
        productImageView.anchor(nil, left: containerView.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        productImageView.anchorCenterYToSuperview(constant: 0)
        
        containerView.addSubview(productName)
        productName.anchor(containerView.topAnchor, left: productImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        containerView.addSubview(productPrice)
        productPrice.anchor(productName.bottomAnchor, left: productImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 120, heightConstant: 0)

        containerView.addSubview(productOfferPrice)
        productOfferPrice.anchor(productPrice.bottomAnchor, left: productImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 120, heightConstant: 0)
        
        containerView.addSubview(productStrikeThroughPriceDisplay)
        productStrikeThroughPriceDisplay.anchor(productOfferPrice.bottomAnchor, left: productImageView.rightAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 120, heightConstant: 0)
        
        containerView.addSubview(productBookButton)
        productBookButton.anchor(nil, left: nil, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: -8, widthConstant: 80, heightConstant: 40)
        
    }
    
    
    func configure(images: String?, name: String?, priceDisplay: String?, offerPriceDisplay: String?, strikeThroughPriceDisplay: String?) {
        productImageView.downloaded(from: images)
        productName.text = name
        productPrice.text = priceDisplay
        productOfferPrice.text = offerPriceDisplay
        productStrikeThroughPriceDisplay.attributedText = strikeThroughPriceDisplay?.strikeThroughText()
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        }
    }
}

extension String {
    func strikeThroughText() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
