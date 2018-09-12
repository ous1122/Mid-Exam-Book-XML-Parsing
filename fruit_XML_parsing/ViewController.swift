//
//  ViewController.swift
//  fruit_XML_parsing
//
//  Created by amadeus on 2018. 9. 12..
//  Copyright © 2018년 DIT Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var item:[String:String] = [:]  // item[key] => value
    var elements:[[String:String]] = []
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let path = Bundle.main.url(forResource: "fruit", withExtension: "xml") {
//            //print(path)
//            if let parser = XMLParser(contentsOf: path) {
//                parser.delegate = self
//
//                if parser.parse() {
//                    print("parse succeed!")
//                    print(elements)
//                } else {
//                    print("parse failed!")
//                }
//            }
//        } else {
//            print("xml file not found")
//        }
        
        let strURL = "http://api.androidhive.info/pizza/?format=xml"

        if NSURL(string: strURL) != nil {
            if let parser = XMLParser(contentsOf: NSURL(string: strURL)! as URL) {
                parser.delegate = self

                if parser.parse() {
                    print("parsing success")
                    print(elements)
                } else {
                    print("parsing fail")
                }

            }
        }
    }

    
    // XMLParseDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        print("currentElement = \(elementName)")
        // 결과를 저장할 자료구조 메모리 할당
        
        // tag 이름이 elements이거나 item이면 초기화
//        if elementName == "elements" {
//            elements = []
//        } else if elementName == "item" {
//            item = [:]
//        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
            let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data = \(data)")
        if !data.isEmpty {
            item[currentElement] = data
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
}

