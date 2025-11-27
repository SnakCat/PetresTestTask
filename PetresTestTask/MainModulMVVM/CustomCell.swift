//
//  CustomCell.swift
//  PetresTestTask
//
//  Created by DimaTru on 27.11.2025.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    private let conteinerViwe = UIView()
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        setupConstraints()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        contentView.addSubview(conteinerViwe)
        conteinerViwe.addSubviews(titleLabel, bodyLabel)
    }
    
    private func setupConstraints() {
        conteinerViwe.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conteinerViwe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerViwe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerViwe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            conteinerViwe.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: conteinerViwe.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: conteinerViwe.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: conteinerViwe.trailingAnchor, constant: -10),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: conteinerViwe.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: conteinerViwe.trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(equalTo: conteinerViwe.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupUI() {
        titleLabel.numberOfLines = .zero
        bodyLabel.numberOfLines = .zero
    }
    
    func configuretorTableViewCell(post: Posts) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
