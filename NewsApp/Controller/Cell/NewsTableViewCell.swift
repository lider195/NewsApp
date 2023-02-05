import UIKit

final class NewsTableViewCell: UITableViewCell {
    // MARK: - Properties
    // MARK: Public
    static let identifier = "NewsTableViewCell"

    // MARK: Private
    private var view = UIView()
    private var whiteView = UIView()
    private var titleLabel = UILabel()
    private var dataLabel = UILabel()
    private var informationImage = UIImageView()
    private var checkNews = Bool()
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
    func set(_ title: String, _ date: String, _ image: UIImage, _ check: Bool) {
        titleLabel.text = title
        dataLabel.text = date
        informationImage.image = image
        checkNews = check
    }

    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(view)
        contentView.addSubview(whiteView)
        contentView.addSubview(informationImage)
        contentView.addSubview(titleLabel)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -10).isActive = true
        dataLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        dataLabel.leadingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 15).isActive = true
        dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }

    private func setupUI() {
        if checkNews {
            whiteView.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
        }
        titleLabel.numberOfLines = 4
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.3
        dataLabel.textAlignment = .center
        dataLabel.textColor = .gray
        dataLabel.font = .systemFont(ofSize: 15)
        dataLabel.adjustsFontSizeToFitWidth = true
        dataLabel.minimumScaleFactor = 0.3
        contentView.backgroundColor = .clear
        informationImage.layer.cornerRadius = 15
        informationImage.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.layer.shadowColor = .init(gray: 1, alpha: 0.5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 1
        view.backgroundColor = .clear
    }

    // MARK: - Helpers
}
