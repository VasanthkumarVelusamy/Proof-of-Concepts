//
//  ChristmasPresentsTableViewController.swift
//  Present
//
//  Created by Vasanthkumar V on 09/06/17.
//  Copyright © 2017 Vasanthkumar V. All rights reserved.
//

import UIKit
import CoreData

class ChristmasPresentsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var presents = [Present]()
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var titleView : UIImageView
        // set the dimensions you want here
        titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        // Set how do you want to maintain the aspect
        titleView.contentMode = .scaleAspectFit
        titleView.image = UIImage(named: "sleigh")
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.navigationItem.titleView = titleView
        loadData()
        
    }
    
    func loadData() {
        let presentRequest: NSFetchRequest<Present> = Present.fetchRequest()
        
        do {
            presents = try managedObjectContext.fetch(presentRequest)
            self.tableView.reloadData()
        } catch {
            print("Could not fetch data from database: \(error.localizedDescription)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PresentsTableViewCell
        let presentItem  = presents[indexPath.row]
        if let presentImage = UIImage(data: presentItem.image as! Data) {
            cell.backgroundImage.image = presentImage
        }
        cell.itemLabel.text = presentItem.presentItem
        cell.nameLabel.text = presentItem.person
        return cell
    }
    
    @IBAction func AddPresent(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: {
                self.createPresentItem(with: image)
            })
        }
    }
    
    func createPresentItem(with image: UIImage) {
        let present = Present(context: managedObjectContext)
        present.image = NSData(data: UIImageJPEGRepresentation(image, 0.3)!)
        let inputAlert = UIAlertController(title: "New present", message: "Enter the name of the person and the gift", preferredStyle: .alert)
        inputAlert.addTextField(configurationHandler: {(textField: UITextField) in textField.placeholder = "Person"
        })
        inputAlert.addTextField(configurationHandler: {(textField: UITextField) in textField.placeholder = "Present"
        })
        
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action: UIAlertAction) in
            let personTextField = inputAlert.textFields?.first
            let presentTextField = inputAlert.textFields?.last
           
            if personTextField?.text != "" && presentTextField?.text != "" {
                present.person = personTextField?.text
                present.presentItem = presentTextField?.text
                
                do {
                    try self.managedObjectContext.save()
                    self.loadData()
                } catch {
                    print("Could not save data: \(error.localizedDescription)")
                }
            }
        }))
        
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action: UIAlertAction) in
            self.loadData()
        }))
        self.present(inputAlert, animated: true, completion: nil)
    }

}
