//
//  PairController.swift
//  SpiritAnimalPair
//
//  Created by Omri Horowitz on 2/13/21.
//

import CoreData

class PairController {

    static var shared = PairController()
    
    var multiPeople: [Person] = []
    var pairedPeople: [[Person]] = []
    //space for spirit animal if have time (also core data and convenience etc)
    
    private lazy var fetchRequest: NSFetchRequest<Person> = {
        let request = NSFetchRequest<Person>(entityName: "Person")
         request.predicate = NSPredicate(value: true)
         return request
     }()

    func fetchMultiPeople() {
        self.multiPeople = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func addPerson(name: String) {
        let newPerson = Person(name: name)
        multiPeople.append(newPerson)
        randomize()
        CoreDataStack.saveContext()
    }
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
        fetchMultiPeople()
        randomize()
    }
    
    func randomize() {
        let randomizedPeeps = multiPeople.shuffled()
        pairedPeople = []
        var pair: [Person] = []

        for person in randomizedPeeps {
            if pair.count == 2 {
                pairedPeople.append(pair)
                pair = []
                if person == randomizedPeeps.last {
                    pair.append(person)
                    pairedPeople.append(pair)
                    pair = []
                } else {
                    pair.append(person)
                }
            }else {
                if person == randomizedPeeps.last {
                    pair.append(person)
                    pairedPeople.append(pair)
                    pair = []
                } else {
                    pair.append(person)
                }
            }
        }
        
        if pair.count > 0 {
            pairedPeople.append(pair)
        }
    }
}
