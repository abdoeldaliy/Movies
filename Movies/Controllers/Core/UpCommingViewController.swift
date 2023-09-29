

import UIKit

class UpCommingViewController: UIViewController {
    
    private var titles : [Title] = [Title]()


    private let upCommingTable : UITableView = {
        let table = UITableView()
        table.register(TitleUpcommingTableViewCell.self, forCellReuseIdentifier: TitleUpcommingTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Up Comming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upCommingTable)
        upCommingTable.delegate = self
        upCommingTable.dataSource = self
        
        fetchUpComming()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upCommingTable.frame = view.bounds
        
    }
    
    private func fetchUpComming(){
        APICaller.shared.getUpCommingMovies { result in
            switch result {
            case.success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.upCommingTable.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension UpCommingViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleUpcommingTableViewCell.identifier , for:  indexPath) as? TitleUpcommingTableViewCell  else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? "Unknown",
                                                  posterURL: title.poster_path ?? "Unknown"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}


