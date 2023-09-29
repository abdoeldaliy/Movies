
import UIKit



enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case PopularMovies = 2
    case PopularTv = 3
    case UpCommingMovies = 4
    case UpcCommingTV = 5
    case TopRatedMovies = 6
    case TopRatedTV = 7
    
}



class HomeViewController: UIViewController {
    
    let sectionTitles : [String] = ["Trending Movies","Trending Tv",
                                    "Popular Movies","Popular TV",
                                    "UP Comming Movies","UP Comming TV",
                                    "Top Rated Movies","Top Rated TV"]
    
    
    
    var headerView : HeroHeaderUIView?
    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    private func configNavbar(){
        var image = UIImage(named: "netfilixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,style: .done,target: self,action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configNavbar()
        addHeroHeader()
        
    }
    
    
    
    
     private func addHeroHeader(){
        
         
        let headerImage = UIImage(named: "heroImage")
        let aspectRatio = headerImage?.scale ?? 1
        let headerWidth = view.frame.size.width
        let headerHeight = headerWidth * aspectRatio
        headerView = HeroHeaderUIView(frame: CGRect (x: 0, y: 0,
                                                     width: headerWidth,
                                                     height: headerHeight))
        headerView?.setup(with: headerImage)
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        
    }
}


// here extenstion to pass uitableviewdelegate and uitableviewdatasource to main class of HomeViewController

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier , for: indexPath ) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
            
            
            
            // fetch data for get trending movies
        case Sections.TrendingMovies.rawValue :
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get trending tv
        case Sections.TrendingTv.rawValue :
            APICaller.shared.getTrendingTV { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get popular movies
        case Sections.PopularMovies.rawValue :
            APICaller.shared.getPopularMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get popular tv
        case Sections.PopularTv.rawValue :
            APICaller.shared.getPopularTV { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get upcomming movies
        case Sections.UpCommingMovies.rawValue :
            APICaller.shared.getUpCommingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get upcomming Tv
        case Sections.UpcCommingTV.rawValue :
            APICaller.shared.getUpCommingTV { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get top rated movies
        case Sections.TopRatedMovies.rawValue :
            APICaller.shared.getTopRatingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            // fetch data for get top rated Tv
        case Sections.TopRatedTV.rawValue :
            APICaller.shared.getTopRatingTV { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        default:
            return UITableViewCell()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // this func when scroll up it's hide the navbar
    func scrollViewDidScroll (_ scrollView: UIScrollView){
        let defaultoffset = view.safeAreaInsets.top
        let Offset = scrollView.contentOffset.y + defaultoffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-Offset))
    }
    
    // this func to custom view the section header (font & color )
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        header.textLabel?.frame = CGRect(x: Int(header.bounds.origin.x) + 20,
                                         y: Int(header.bounds.origin.y),
                                         width: 100,
                                         height: Int(header.bounds.height))
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
}


