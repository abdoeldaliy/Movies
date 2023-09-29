

import Foundation

struct Constants {
    static let API_KEY = "347c7382b4d346f999c4960ab4850249"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIEroor : Error {
    case failedToGetData
}


protocol APICallerProtocol : AnyObject {
    
    func getTrendingMovies(completion : @escaping (Result<[Title], Error>) -> Void)
    func getTrendingTV(completion : @escaping (Result<[Title], Error>) -> Void)
    func getPopularMovies(completion : @escaping (Result<[Title], Error>) -> Void)
    func getPopularTV(completion : @escaping (Result<[Title], Error>) -> Void)
    func getUpCommingMovies(completion : @escaping (Result<[Title],Error>) -> Void)
    func getUpCommingTV(completion : @escaping (Result<[Title],Error>) -> Void)
    func getTopRatingMovies(completion : @escaping (Result<[Title],Error>) -> Void)
    func getTopRatingTV(completion : @escaping (Result<[Title],Error>) -> Void)
    func getDiscoverMovies(completion : @escaping (Result<[Title],Error>) -> Void)
    func getSearchResult(with query: String , completion : @escaping (Result<[Title],Error>) -> Void)
    
    
}


class APICaller : APICallerProtocol {
    
    static let shared = APICaller()
    
    // Func to call trending movies
    
    func getTrendingMovies(completion : @escaping (Result<[Title], Error>) -> Void ){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIEroor.failedToGetData))
            }
        }
        task.resume()
    }
    
    // Func to call trending tv series
    
    func getTrendingTV(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // Func to call Popular Movies
    
    func getPopularMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // Func to call Popular TV
    
    func getPopularTV(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/popular?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // func to call up comming movies
    
    func getUpCommingMovies(completion : @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // func to call up comming tv
    
    func getUpCommingTV(completion : @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/on_the_air?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // func to call top rating movies
    
    func getTopRatingMovies(completion : @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // func to call top rating tv
    
    func getTopRatingTV(completion : @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/tv/top_rated?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // Func to call discover
    
    func getDiscoverMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    // func to get search result
    
    func getSearchResult(with query: String , completion : @escaping (Result<[Title],Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  else {return}
       
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?query=\(query)&api_key=\(Constants.API_KEY)")
        else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url : url)) { data, _, error in
            guard let data = data , error == nil else {return}
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIEroor.failedToGetData))
                
            }
        }
        task.resume()
    }
    
    
}
