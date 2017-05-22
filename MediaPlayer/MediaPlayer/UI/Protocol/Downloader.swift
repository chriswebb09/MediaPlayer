import Foundation

protocol Downloader: class {
    weak var downloadsSession : URLSession? { get }
    var activeDownloads: [String: Download]? { get set }
    func downloadTrackPreview(for download: Download?)
}

extension Downloader {
    func downloadTrackPreview(for download: Download?) {
        if let download = download,
            let urlString = download.url,
            let url = URL(string: urlString) {
            activeDownloads?[urlString] = download
            download.downloadTask = downloadsSession?.downloadTask(with: url)
            download.downloadTask?.resume()
        }
    }
    
    func startDownload(_ download: Download?) {
        if let download = download, let url = download.url {
            activeDownloads?[url] = download
            if let url = download.url {
                if URL(string: url) != nil {
                    downloadTrackPreview(for: download)
                }
            }
        }
    }
    
}
