//
//  ViewController.swift
//  homework008
//
//  Created by FISH on 2018/12/8.
//  Copyright © 2018年 FISH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var result1 = searchResult.init(idlist: [""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        input.delegate = self
        
    }

    
    @IBAction func searchStart() {
        if let inputText = input.text {
            //            print(input)
            guard inputText != "" else {
//                print("input something")
                let alert = UIAlertController(title: "Alert", message: "Please input keyword.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true, completion: nil)
                
                return
            }
            
            input.endEditing(true)
            loading.startAnimating()
            let urlStr = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&retmode=json&term=" + inputText
            if let url = URL(string: urlStr) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    let decoder = JSONDecoder()
                    if let data = data, let pubmedSearch = try? decoder.decode(pubmedSearch.self, from: data) {
                        self.result1 = pubmedSearch.esearchresult
                        let list = self.result1.idlist
                        let listStr = list.joined(separator: ",")
                        let urlStr2 = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esummary.fcgi?db=pubmed&retmode=json&id=" + listStr
                        if let url2 = URL(string: urlStr2) {
                            let task2 = URLSession.shared.dataTask(with: url2, completionHandler: { (data2, response2, error2) in
                                if let data2 = data2, let dic = try? JSONSerialization.jsonObject(with: data2) as? [String: Any], let result2 = dic?["result"] as? [String: Any] {
                                    var resultArr = [[String: String]]()
                                    for uid in list {
                                        var resultDic = [String: String]()
                                        if let paper = result2[uid] as? [String: Any] {
                                            if let title = paper["title"] as? String {
                                                resultDic["title"] = title
                                                resultDic["urlStr"] = "https://www.ncbi.nlm.nih.gov/labs/pubmed/" + uid
                                            }
                                            if let authors = paper["authors"] as? [[String: String]] {
                                                var authorNameArr = [String]()
                                                for author in authors {
                                                    if let name = author["name"] {
                                                        authorNameArr.append(name)
                                                    }
                                                }
                                                let authorNames = authorNameArr.joined(separator: ", ")
                                                print(authorNames)
                                                resultDic["authorNames"] = authorNames
                                            }
                                            if var source = paper["source"] as? String {
                                                if source.isEmpty {
                                                    if let booktitle = paper["booktitle"] as? String {
                                                        source = booktitle
                                                    }
                                                }
                                                resultDic["source"] = source
                                            }
                                            resultArr.append(resultDic)
                                        }
                                    }
                                    //                                    print(resultArr)
                                    DispatchQueue.main.async {
                                        self.loading.stopAnimating()
                                        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Papers") as? PaperViewController {
                                            controller.papers = resultArr
                                            self.present(controller, animated: true, completion: nil)
                                        }
                                    }
                                }
                            })
                            task2.resume()
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input.endEditing(true)
        searchStart()
        return true
    }
}

