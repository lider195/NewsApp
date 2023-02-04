import UIKit

final class AllNewsViewController: UIViewController {

    // MARK: Public
    // MARK: Private
    private let newsTableView = UITableView()
    private let logoLabel = UILabel()
    private var url: URL!
    private var myFeed: NSArray = []
    private var feedImgs: [AnyObject] = []
    private let refreshControl = UIRefreshControl()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRss()
        addSubView()
        setupTableView()
        setupConstrains()
        setupView()
        addTarget()
    }

    // MARK: - API
    func loadRss() {
        let myParser = ApiManager().initWithURL() as! ApiManager

        feedImgs = myParser.img
        myFeed = myParser.feeds

        print("\(myParser.title)")
        newsTableView.reloadData()
    }

    // MARK: - Setups
    private func addSubView() {
        view.addSubview(newsTableView)
        view.addSubview(logoLabel)
    }

    private func addTarget() {
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
    }

    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.refreshControl = refreshControl
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }

    private func setupView() {
        view.backgroundColor = .white
        logoLabel.text = "Lenta.ru"
        logoLabel.textColor = .black
        logoLabel.textAlignment = .center
        logoLabel.font = .systemFont(ofSize: 40)
    }

    private func setupConstrains() {
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }

    // MARK: - Helpers

    @objc func doSomething(refreshControl: UIRefreshControl) {

        loadRss()
        newsTableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension AllNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myFeed.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let url = NSURL(string: feedImgs[indexPath.row] as! String)
        let newsInformation = NewsInformationViewController()
        newsInformation.titleLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        newsInformation.descriptionLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "description") as? String
        let data = NSData(contentsOf: url! as URL)
        let image = UIImage(data: data! as Data)
        newsInformation.imageView.image = image
        newsInformation.timeLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String
        navigationController?.pushViewController(newsInformation, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                    for: indexPath) as? NewsTableViewCell
        {
            let url = NSURL(string: feedImgs[indexPath.row] as! String)
            let data = NSData(contentsOf: url! as URL)
            let image = UIImage(data: data! as Data)

            cell.nameLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
            cell.informationImage.image = image
            cell.dataLabel.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String

            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(white: 1, alpha: 0)
            } else {
                cell.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
            }

            return cell
        }
        return UITableViewCell()
    }
}
