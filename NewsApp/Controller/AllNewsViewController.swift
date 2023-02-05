import UIKit

final class AllNewsViewController: UIViewController {

    // MARK: Public
    // MARK: Private
    private let newsTableView = UITableView()
    private var search = UISearchController()
    private var url: URL!
    private var newsArray: [News] = [] {
        didSet {
            newsTableView.reloadData()
        }
    }
    private var checkNewsArray: [News] = []{
        didSet {
            newsTableView.reloadData()
        }
    }
    private var searchArray: [News] = []
    private var shareImage: [AnyObject] = []
    private let refreshControl = UIRefreshControl()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setupTableView()
        setupConstrains()
        setupView()
        addTarget()
        loadRss()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let news = CoreDataManager.instance.getNewsCheck() else { return }
        checkNewsArray = news
    }
    // MARK: - API
    private func loadRss() {
        let parser = ApiManager.shared.initWithURL() as! ApiManager
        shareImage = parser.img
        newsArray = parser.news
        newsTableView.reloadData()
    }

    // MARK: - Setups
    private func addSubView() {
        view.addSubview(newsTableView)
    }

    private func addTarget() {

        refreshControl.addTarget(self, action: #selector(toRefresh), for: .valueChanged)
    }

    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.refreshControl = refreshControl
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }

    private func setupView() {
        view.backgroundColor = .white
        title = "Lenta.ru"
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
        search.searchBar.searchTextField.layer.masksToBounds = true
        search.searchBar.searchTextField.layer.cornerRadius = 5
        search.searchBar.barTintColor = UIColor(red: 20 / 255, green: 18 / 255, blue: 29 / 255, alpha: 1.0)
        search.searchBar.backgroundColor = .clear
    }

    private func setupConstrains() {
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }

    // MARK: - Helpers

    @objc func toRefresh(refreshControl: UIRefreshControl) {
        newsArray.removeAll()
        newsTableView.reloadData()
        loadRss()
        refreshControl.endRefreshing()
    }
}

extension AllNewsViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            newsTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive {
            return searchArray.count
        } else {
            return newsArray.count
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let url = NSURL(string: shareImage[indexPath.row] as! String) else { return }
        guard let data = NSData(contentsOf: url as URL) else { return }
        let image = UIImage(data: data as Data)
        let newsInformation = NewsInformationViewController()
        guard let title = newsArray[indexPath.row].title else { return }
        guard let date = newsArray[indexPath.row].date else { return }
        guard let images = (image ?? UIImage(systemName: "icloud.slash")) else { return }
        guard let description = newsArray[indexPath.row].description else { return }
        newsInformation.set(title, date, images, description)
        CoreDataManager.instance.saveCheck(News(title: title, check: true))
        navigationController?.pushViewController(newsInformation, animated: true)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                    for: indexPath) as? NewsTableViewCell
        {
            var newsSearch = (search.isActive) ? searchArray[indexPath.row] : newsArray[indexPath.row]

            let url = NSURL(string: shareImage[indexPath.row] as! String)
            let data = NSData(contentsOf: url! as URL)
            let image = UIImage(data: data! as Data)
            let images = image

            cell.backgroundColor = UIColor(white: 1, alpha: 0)

            DispatchQueue.main.async { [self] in
                for i in checkNewsArray {
                    if i.title == newsSearch.title {
                        newsSearch.check = true
                        cell.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
                        cell.reloadInputViews()
                    }
                }
            }

            cell.set(newsSearch.title ?? " ", newsSearch.date ?? "", (images ?? UIImage(systemName: "icloud.slash"))!, newsSearch.check ?? false)

            return cell
        }
        return UITableViewCell()
    }

    func filterContent(for SearchText: String) {
        searchArray = newsArray.filter { array -> Bool in
            if let name = array.title?.lowercased() {
                return name.hasPrefix(SearchText.lowercased())
            }

            return false
        }
    }
}
