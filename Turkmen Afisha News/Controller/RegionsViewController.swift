//
//  RegionsViewController.swift
//  Turkmen Afisha News
//
//  Created by izi on 12.08.2021.
//

import UIKit

class RegionsViewController: UIViewController {
    
    @IBOutlet var stackViewsofRegions: [UIStackView]!
    @IBOutlet var provinceBtns: [UIButton]!
    @IBOutlet var viewsofRegions: [UIView]!
    
    var provinceInd: Int!
    var regionInd: Int!
    var ind = -1
    var arr: [Region]!
    var filteredProvinces: [[Region]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidingStacks(blueInd: 6)
        
        stackViewsofRegions.forEach { (stackView) in
            stackView.removeAllArrangedSubviews()
            settingStackView(stackView: stackView)
            var tag = -1
            ind += 1
            let arr = regions.filter { $0.province ==  ind }
            filteredProvinces.append (arr)
            arr.forEach { (region) in
                tag += 1
                stackView.addArrangedSubview(creatingButtons(title: region.name, tag: tag))
            }
        }
    }

    @objc  func didButtonClick (_ sender: UIButton) {
        if sender.layer.borderColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            selectedRegionIds.removeAll { $0 == filteredProvinces[provinceInd][sender.tag].id }
            sender.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            sender.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            selectedRegionIds.append(filteredProvinces[provinceInd][sender.tag].id)
        }
    }
    
    @IBAction func agClicked(_ sender: UIButton) {
        provinceClicked(ind: 0, sender: sender)
    }
    
    @IBAction func ahClicked(_ sender: UIButton) {
        provinceClicked(ind: 1, sender: sender)
    }
    
    
    @IBAction func mrClicked(_ sender: UIButton) {
        provinceClicked(ind: 2, sender: sender)
    }
    
    
    @IBAction func lbClicked(_ sender: UIButton) {
        provinceClicked(ind: 3, sender: sender)
    }
    
    
    @IBAction func dzClicked(_ sender: UIButton) {
        provinceClicked(ind: 4, sender: sender)
    }
    
    
    @IBAction func bnClicked(_ sender: UIButton) {
        provinceClicked(ind: 5, sender: sender)
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    
    
    

    func settingStackView (stackView: UIStackView) {
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.backgroundColor = #colorLiteral(red: 0.5895085931, green: 0.7741902471, blue: 0.92419523, alpha: 1)
        stackView.layer.cornerRadius = 15
        stackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20)
    }

    func creatingButtons (title: String, tag: Int) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        button.setTitle(title, for: UIControl.State.normal)
        button.tag = tag
        button.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        return button
    }
    
    func hidingStacks (blueInd: Int) {
        for i in 0..<6  {
            viewsofRegions[i].isHidden = true
            if i != blueInd { provinceBtns[i].layer.borderColor = #colorLiteral(red: 0.75, green: 0.75, blue: 0.75, alpha: 1) }
        }
    }
    
    func provinceClicked (ind: Int, sender: UIButton) {
        hidingStacks(blueInd: ind)
        sender.layer.borderWidth = 2
        if sender.layer.borderColor != #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            sender.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            viewsofRegions[ind].isHidden = false
            provinceInd = ind
            selectedRegionIds = []
            selectedRegion = sender.titleLabel?.text
            filteredProvinces[ind].forEach { (region) in
                selectedRegionIds.append(region.id)
            }
        }
    }
}
