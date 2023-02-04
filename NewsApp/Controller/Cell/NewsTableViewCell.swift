import UIKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - Properties
    // MARK: Public
    static let identifier = "NewsTableViewCell"
    var nameLabel = UILabel()
    var dataLabel = UILabel()
    var informationImage = UIImageView()
    // MARK: Private
    private var view = UIView()
    private var whiteView = UIView()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstrains()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - API
    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(view)
        contentView.addSubview(whiteView)
        contentView.addSubview(informationImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dataLabel)
    }

    private func setupConstrains() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        informationImage.translatesAutoresizingMaskIntoConstraints = false
        informationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        informationImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        informationImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        informationImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        whiteView.leadingAnchor.constraint(equalTo: informationImage.trailingAnchor, constant: 0).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: informationImage.trailingAnchor, constant: 0).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -10).isActive = true
        dataLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        dataLabel.leadingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 15).isActive = true
        dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }

    private func setupUI() {
        nameLabel.numberOfLines = 4
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 30)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.3
        dataLabel.textAlignment = .center
        dataLabel.textColor = .gray
        dataLabel.font = .systemFont(ofSize: 15)
        dataLabel.adjustsFontSizeToFitWidth = true
        dataLabel.minimumScaleFactor = 0.3
        contentView.backgroundColor = .clear
        informationImage.layer.cornerRadius = 15
        informationImage.layer.masksToBounds = true
        informationImage.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.layer.shadowColor = .init(gray: 1, alpha: 0.5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1
        view.backgroundColor = .clear
    }

    // MARK: - Helpers
}
