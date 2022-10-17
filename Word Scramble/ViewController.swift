//
//  ViewController.swift
//  Word Scramble
//
//  Created by Melis Yazıcı on 13.10.22.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n") // Tell it what string you want to use as a separator (for us, that's \n), and you'll get back an array.
            }
        }
        
        if allWords.isEmpty == true {
            allWords = ["silkworm"]
        }
        
        startGame()
        
    }
    
    func startGame() {
        title = allWords.randomElement() // set the view controller's title to be a random word in the array
        usedWords.removeAll(keepingCapacity: true) // removes all values from the usedWords array
        tableView.reloadData() // forces UITableViewController to call numberOfRowInSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        // the alert controller and the view controller are reference inside this closure that's why using weak so it wont capture these strongly
        // it will retains cycle that hold onto memory
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        
    }


}

