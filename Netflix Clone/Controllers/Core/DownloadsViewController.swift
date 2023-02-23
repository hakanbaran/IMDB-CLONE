//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Hakan Baran on 9.12.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles: [TitleItem] =  [TitleItem]()
    
    private let downloadedTable : UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(downloadedTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocalStorageForDownload()
    }
    
    private func fetchLocalStorageForDownload() {
        
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                
                DispatchQueue.main.async {
                    self.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown Title Name", posterURL: title.poster_path ?? ""))
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let movieResults = titles[indexPath.row]

        let movieName = movieResults.original_name ?? movieResults.original_title
        let moviePoster = movieResults.poster_path
        let movieDate = movieResults.release_data
        let movieOverview = movieResults.overview
        let movieRating = movieResults.vote_average
        
         APICaller.shared.getMovietoYoutube(with: movieName ?? "") { [weak self] result in
             switch result {
             case .success(let videoElement):
                 DispatchQueue.main.async {
                     let vc = TitlePreviewViewController()

                     vc.configure(with: TitlePreviewViewModel(title: movieName ?? "", youtubeView: videoElement , titleOverview: movieOverview ?? "" , moviePoster: moviePoster ?? "" , vote_average: movieRating, release_date: movieDate ?? "" ))
                     self?.navigationController?.pushViewController(vc, animated: true)
                 }
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
            
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { result in
                switch result {
                case .success():
                    print("Delete from the Database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
            
            
        }
        
    }
    
    
}

    
    

