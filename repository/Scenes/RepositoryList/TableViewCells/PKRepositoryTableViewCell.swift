//
//  PKRepositoryTableViewCell.swift
//  repository
//
//  Created by pankaj.k.jha on 24/10/21.
//

import UIKit
import SDWebImage

class PKRepositoryTableViewCell: UITableViewCell {

    static let identifier = String(describing: PKRepositoryTableViewCell.self)
    
    lazy var name: UILabel =  {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = PKFontSize.middleWeight
        return view
    }()
    
    lazy var type: UILabel =  {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = PKFontSize.regular
        return view
    }()
    
    lazy var date: UILabel =  {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.font = PKFontSize.regular
        return view
    }()
    
    lazy var avatar: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.backgroundColor = PKDefaultColor.background

        view.layer.cornerRadius = 8
        return view
    }()
   
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

    private func setupConstraints() {
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        avatar.translatesAutoresizingMaskIntoConstraints = false

        avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        avatar.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 45).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 45).isActive = true
        

        //partner
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24).isActive = true
        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 21).isActive = true
        
        //partner
        type.translatesAutoresizingMaskIntoConstraints = false
        
        type.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 0).isActive = true
        type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 24).isActive = true
        type.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        type.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        //partner
        date.translatesAutoresizingMaskIntoConstraints = false
        
        date.leadingAnchor.constraint(equalTo: type.leadingAnchor, constant: 0).isActive = true
        date.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 8).isActive = true
        date.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        date.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
    }
    func configureCell(viewModel: PKRepositoryViewDataProtocol) {
        if let avatarUrl = viewModel.avatarURL, let url = URL(string: avatarUrl) {
            avatar.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder"),
                options: [],
                context: [.imageThumbnailPixelSize : CGSize(width: 200, height: 200)]
            )
            avatar.sd_imageTransition = .fade(duration: 0.3)
        }
        
        name.text = viewModel.name?.uppercased()
        type.text = viewModel.type?.capitalized
        date.text = PKDateHelper.convertDate(viewModel.createdDate ?? "")
        
    }
    
    private func initSubviews() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(avatar)
        containerView.addSubview(name)
        containerView.addSubview(type)
        containerView.addSubview(date)
    }
}
