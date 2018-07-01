//
//  SubcategoryTableViewCell.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit

class SubcategoryCell: UITableViewCell, Configurable {
 
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var subtitleLbl: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    internal var model: Lecture?
    var controller: UIViewController?
    var tableView: UITableView?
    
    func configure(with model: Lecture,
                   inController controller: UIViewController,
                   inTableView tableView: UITableView) {
        self.model = model
        self.controller = controller
        self.tableView = tableView
        
        titlelbl.text = model.title
        
        let detail = model.details!
        let i = detail.index(detail.startIndex, offsetBy: 400)
        let first100Character = detail[...i] + "..."
        let finalTxt = first100Character.replacingOccurrences(of: "\n", with: " ")
        subtitleLbl.text = finalTxt
        
        if model.isFavorite{
            favoriteImage.isHidden = false
        }
        else{
            favoriteImage.isHidden = true
        }
    }
    
    @IBAction func showOtions(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPathForSelectedOptionsBtn = tableView?.indexPathForRow(at: buttonPosition)!
        tableView?.selectRow(at: indexPathForSelectedOptionsBtn,
                             animated: true,
                             scrollPosition: .middle)
        let optionMenu = CustomAlertController(title: nil, message: "الخيارات", preferredStyle: .actionSheet)
        
        let shareAction = UIAlertAction(title: "مشاركة", style: .default, handler: {
            [unowned self]  (alert: UIAlertAction!) in
            let txt = self.model?.details!
            let vc = UIActivityViewController(activityItems: [txt ?? ""], applicationActivities: [])
            vc.popoverPresentationController?.sourceView = self.controller?.view
            vc.popoverPresentationController?.sourceRect = CGRect(origin: buttonPosition, size: CGSize.zero)
            self.controller?.present(vc, animated: true)
        })
        
        let copyActin = UIAlertAction(title: "نسخ", style: .default, handler: {
            (alert: UIAlertAction!) in
            UIPasteboard.general.string = self.model?.details
            self.controller?.showToast(oFMessage: "تم النسخ.")
        })
        
        let favoriteAction = UIAlertAction(title: "مفضلة", style: .default, handler: {
            (alert: UIAlertAction!) in
            self.model?.isFavorite = !self.model!.isFavorite
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                appDelegate.saveContext()
                self.tableView?.reloadRows(at: [indexPathForSelectedOptionsBtn!], with: .fade)
            }
        })
        
        let editAction = UIAlertAction(title: "تعديل", style: .default, handler: {
            [unowned self] (alert: UIAlertAction!) in
            self.controller?.performSegue(withIdentifier: "editContent", sender: self.controller)
        })
        
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        optionMenu.addAction(shareAction)
        optionMenu.addAction(copyActin)
        optionMenu.addAction(favoriteAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.popoverPresentationController?.sourceView = controller?.view
        optionMenu.popoverPresentationController?.sourceRect = CGRect(origin: buttonPosition, size: CGSize.zero)
        
        controller?.present(optionMenu, animated: true, completion: nil)
        
        optionMenu.didDismiss = { UIAlertController in
            self.tableView?.deselectRow(at: indexPathForSelectedOptionsBtn!, animated: true)
        }
    }
    
    
}
