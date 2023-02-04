import UIKit

final class NewsInformationViewController: UIViewController {

    // MARK: - Properties
    // MARK: Public
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let descriptionLabel = UILabel()

    // MARK: Private
    private let whiteView = UIView()
    private let presentationScrollView = UIScrollView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstrains()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - API

    // MARK: - Setups
    private func addSubViews() {
        whiteView.addSubview(imageView)
        view.addSubview(presentationScrollView)
        presentationScrollView.addSubview(whiteView)
        whiteView.addSubview(titleLabel)
        whiteView.addSubview(timeLabel)
        whiteView.addSubview(descriptionLabel)
    }

    private func setupConstrains() {
        presentationScrollView.translatesAutoresizingMaskIntoConstraints = false
        presentationScrollView.topAnchor.constraint(equalTo: view.topAnchor,
                                                    constant: 0).isActive = true
        presentationScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        presentationScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        presentationScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.topAnchor.constraint(equalTo: presentationScrollView.topAnchor, constant: 0).isActive = true
        whiteView.leadingAnchor.constraint(equalTo: presentationScrollView.leadingAnchor, constant: 0).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: presentationScrollView.trailingAnchor, constant: 0).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: presentationScrollView.bottomAnchor, constant: 0).isActive = true
        whiteView.widthAnchor.constraint(equalTo: presentationScrollView.widthAnchor, multiplier: 1.0).isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 18).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -18).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 18).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -18).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 19).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 18).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -18).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -20).isActive = true
    }

    private func setupUI() {
        view.backgroundColor = .white
        whiteView.layer.cornerRadius = 20
        whiteView.layer.masksToBounds = true
        titleLabel.font = .systemFont(ofSize: 35)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.font = .systemFont(ofSize: 20)
    }

    // MARK: - Helpers
}
