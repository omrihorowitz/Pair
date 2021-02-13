//
//  SpiritAnimalPairTableViewController.swift
//  SpiritAnimalPair
//
//  Created by Omri Horowitz on 2/13/21.
//
import UIKit

class SpiritAnimalPairTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PairController.shared.fetchMultiPeople()
        PairController.shared.randomize()
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func addSomebodyButtonTapped(_ sender: Any) {
        
    let alertController = UIAlertController(title: "Add a homie or an animal!", message: "Add someone new to pair up", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Add a homie!"
        }
        
        let addAction = UIAlertAction(title: "Add smn!", style: .default) { (_) in
            guard let textField = alertController.textFields,
                  let personName = textField[0].text, !personName.isEmpty else { return }
            PairController.shared.addPerson(name: personName)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Nah", style: .destructive)
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
    }
    
    @IBAction func randomButtonTapped(_ sender: Any) {
        PairController.shared.randomize()
        tableView.reloadData()
    }
    
//MARK: - Table View Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return PairController.shared.pairedPeople.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.shared.pairedPeople[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath)
        
        cell.textLabel?.text = PairController.shared.pairedPeople[indexPath.section][indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PairController.shared.pairedPeople[indexPath.section][indexPath.row]
            PairController.shared.deletePerson(person: personToDelete)
            tableView.reloadData()
        }
    }
}
