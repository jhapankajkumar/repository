//
//  PKNextButtonTableViewCell.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import UIKit

class PKNextButtonTableViewCell: UITableViewCell {
    static let identifier = String(describing: PKNextButtonTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initSubviews()
        setupConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    lazy var nextButton: UIButton =  {
        let view = UIButton()
        view.layer.cornerRadius = 4
        view.titleLabel?.textColor = .white
        view.titleLabel?.font = PKFontSize.walter
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private func initSubviews() {
        contentView.addSubview(nextButton)
        nextButton.setTitle("Next", for: .normal)
    }
    
    private func setupConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
