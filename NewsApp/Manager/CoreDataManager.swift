import Foundation

import CoreData
import UIKit

final class CoreDataManager {
    static let instance = CoreDataManager()

    func saveCheck(_ news: News) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managerContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managerContext)!

        let newss = NSManagedObject(entity: entity, insertInto: managerContext)

        newss.setValue(news.title, forKey: "title")
        newss.setValue(news.check, forKey: "check")
       

        do {
            try managerContext.save()
        } catch let error as NSError {
            print("error- \(error)")
        }
    }
    func getNewsCheck() -> [News]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

        let managerContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")

        do {
            let object = try managerContext.fetch(fetchRequest)
            var news = [News]()
            for object in object {
                guard let title = object.value(forKey: "title") as? String,
                      let check = object.value(forKey: "check") as? Bool
                       else { return nil }
                let user = News(title: title, check: check)
                news.insert(user, at: 0)
            }
            return news
        } catch let error as NSError {
            print("Error-\(error)")
        }
        return nil
    }
}
