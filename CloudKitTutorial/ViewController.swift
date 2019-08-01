//
//  ViewController.swift
//  CloudKitTutorial
//
//  Created by Georgius Yoga Dewantama on 30/07/19.
//  Copyright © 2019 Georgius Yoga Dewantama. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notes : [String] = []
    
    // membuat variable sebagai database container
    let database = CKContainer.default().privateCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Type Something", message: "What you want to type in this note ?", preferredStyle: .alert )
        
        alert.addTextField { (textField) in
            textField.placeholder = "Type note here"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let post = UIAlertAction(title: "Post", style: .default) { (_) in
            //TODO: saved in cloudkit
            guard let text = alert.textFields?.first?.text else { return }
            self.saveToCloud(note: text)
        }
        
        alert.addAction(cancel)
        alert.addAction(post)
        present(alert, animated: true, completion: nil)
    }
    
    func saveToCloud (note : String){
        
        let newNote = CKRecord(recordType: "Note")
        
        newNote.setValue(note, forKey: "content")
        
        database.save(newNote) { (record, _) in
            guard record != nil else { return }
            print("saved record")
        }
    }
    
    func queryDatabase () {
        
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (record, _) in
            guard let records = records else { return }
        }
    }
}





extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = ""
        return cell
        
    }
    
    
}
