//
//  ViewController.swift
//  W6D4-StretchySnacks
//
//  Created by Murat Ekrem Kolcalar on 12/7/17.
//  Copyright © 2017 murtilicious. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navbarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var navbarView: UIView!
    var headerLabel: UILabel!
    var isBig: Bool!
    var stackView: UIStackView!
    var imageArray: Array<UIImageView>!
    var nameArray: Array<String>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        isBig = false
        initViews()
        
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
    }

    @IBAction func plusButtonPressed(_ sender: Any) {
        resizeNavbar()
        initLogo()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer)
    {
        let tappedImageView = sender.view as! UIImageView
        let index = tappedImageView.tag
        let placeholderArray = ["Oreos", "Pizza Pockets", "Pop Tarts", "Popsicle", "Ramen"]
        nameArray.append(placeholderArray[index])
        
//        tableView.reloadData()
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: nameArray.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
    }
    
    func initLogo() {
        headerLabel.center.x = navbarView.center.x
        headerLabel.center.y = navbarView.center.y * 1.25
        headerLabel.textAlignment = .center
        navbarView.addSubview(headerLabel)
        
        if !isBig {
            headerLabel.text = "SNACKS"
        } else if isBig {
            headerLabel.text = "SELECT A SNACK"
            headerLabel.center.y = navbarView.center.y / 2.5
        }
    }
    
    func initViews() {
        
        let image1 = UIImage(named: "oreos")!
        let imageView1 = UIImageView(image: image1)
        let image2 = UIImage(named: "pizza_pockets")!
        let imageView2 = UIImageView(image: image2)
        let image3 = UIImage(named: "pop_tarts")!
        let imageView3 = UIImageView(image: image3)
        let image4 = UIImage(named: "popsicle")!
        let imageView4 = UIImageView(image: image4)
        let image5 = UIImage(named: "ramen")!
        let imageView5 = UIImageView(image: image5)

        imageArray = [imageView1, imageView2, imageView3, imageView4, imageView5]
        nameArray = []
        
        for (idx,image) in imageArray.enumerated() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
            image.tag = idx
        }

        self.stackView = UIStackView(arrangedSubviews: imageArray)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        self.navbarView.addSubview(stackView)


        let viewsDictionary = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[stackView]-10-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-45-[stackView]-15-|",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        view.addConstraints(stackView_H)
        view.addConstraints(stackView_V)


        self.stackView.alpha = 0

    }
    
    func resizeNavbar() {
        if !isBig {
            isBig = true
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.05, options: .curveEaseInOut, animations: {
                self.navbarHeightConstraint.constant = 200
                self.view.layoutIfNeeded()
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
                self.stackView.alpha = 1
            }, completion: nil)
            
        } else {
            isBig = false
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.05, options: .curveEaseInOut, animations: {
                self.navbarHeightConstraint.constant = 66
                self.view.layoutIfNeeded()
                self.plusButton.transform = CGAffineTransform.identity
                self.stackView.alpha = 0
            }, completion: nil)

        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell else { return CustomCell() }
        
        cell.snackLabel.text = self.nameArray[indexPath.row]
        
        return cell
    }
    
    
}
