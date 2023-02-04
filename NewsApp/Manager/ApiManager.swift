import Foundation

class ApiManager: NSObject, XMLParserDelegate {
//    static var shared = ApiManager()

    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title = NSMutableString()
    var link = NSMutableString()
    var img: [AnyObject] = []
    var descriptions = NSMutableString()
    var date = NSMutableString()

    // initilise parser
    func initWithURL() -> AnyObject {
        startParse()

        return self
    }
//////////
    func startParse() {

        let url = "https://lenta.ru/rss/news"
        
        feeds = []
        parser = XMLParser(contentsOf: URL(string: url)!)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }

//    func startParse() {
//        let urls = "https://lenta.ru/rss/news"
//
//        if let url = URL(string: urls) {
//            URLSession.shared.dataTask(with: url) { data, _, _ in
//                // Error handling...
//                guard let datas = data else { return }
//                print("sadsafdsf")
//                DispatchQueue.main.async { [self] in
//                    print("sadsafdsf")
//                    feeds = []
//                    parser = XMLParser(data: datas)
//                    parser.delegate = self
//                    parser.shouldProcessNamespaces = false
//                    parser.shouldReportNamespacePrefixes = false
//                    parser.shouldResolveExternalEntities = false
//                    parser.parse()
//                    print("💹\(feeds)")
//                }
//            }.resume()
//        }
//    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "item") {
            elements = NSMutableDictionary()
            elements = [:]
            title = NSMutableString()
            title = ""
            link = NSMutableString()
            link = ""
            descriptions = NSMutableString()
            descriptions = ""
            date = NSMutableString()
            date = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName as NSString).isEqual(to: "item") {
            if title != "" {
                elements.setObject(title, forKey: "title" as NSCopying)
            }
            if link != "" {
                elements.setObject(link, forKey: "link" as NSCopying)
            }
            if descriptions != "" {
                elements.setObject(descriptions, forKey: "description" as NSCopying)
            }
            if date != "" {
                elements.setObject(date, forKey: "pubDate" as NSCopying)
            }
            feeds.add(elements)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title") {
            title.append(string)
        } else if element.isEqual(to: "link") {
            link.append(string)
        } else if element.isEqual(to: "description") {
            descriptions.append(string)
        } else if element.isEqual(to: "pubDate") {
            date.append(string)
        }
    }
}
