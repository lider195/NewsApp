import Foundation

class ApiManager: NSObject, XMLParserDelegate {
    static var shared = ApiManager()
    let url = "https://lenta.ru/rss/news"
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = String()
    var title = String()
    var link = String()
    var img: [AnyObject] = []
    var descriptions = String()
    var date = String()
    var news = [News]()

    func initWithURL() -> AnyObject {
        startParse()

        return self
    }

    func startParse() {

       

        feeds = []
        parser = XMLParser(contentsOf: URL(string: url)!)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]) {
        element = elementName
        if (element as NSString).isEqual(to: "item") {
            elements = NSMutableDictionary()
            elements = [:]
            title = String()
            title = ""
            link = String()
            link = ""
            descriptions = String()
            descriptions = ""
            date = String()
            date = ""

        } else if (element as String).isEqual("enclosure") {
            if let urlString = attributeDict["url"] {
                img.append(urlString as AnyObject)
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName as String).isEqual("item") {
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

            let new = News(title: title, description: descriptions, url: link, date: date)

            news.append(new)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual("title") {
            title.append(string)
        } else if element.isEqual("link") {
            link.append(string)
        } else if element.isEqual("description") {
            descriptions.append(string)
        } else if element.isEqual("pubDate") {
            date.append(string)
        }
    }
}
