//
//  ProfileViewController.swift
//  Alodokter_bootcamp
//
//  Created by Rayhan Faluda on 07/12/21.
//

import UIKit
import SDWebImage

class ProfileViewController: BaseViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileHeaderView: ProfileHeader!
    @IBOutlet weak var profileCardView1: ProfileCard!
//    @IBOutlet weak var profileCardView2: ProfileCard!
    @IBOutlet weak var signOutButton: SignOutButton!
    
    
    // MARK: - Variables
    
    let userDefaults = UserDefaults()
    var viewModel = ProfileViewModel()
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // View Model Delegate
        print("masuk profile")
        viewModel.delegate = self
        viewModel.getUser(token: "\(userDefaults.value(forKey: "token")!)")
        prepareUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        requestData()
    }
    
    
    // MARK: - Prepare UI Method
    
    func prepareUI() {
        if #available(iOS 13.0, *) {
            // Navigation Bar
            self.isNavigationBarHidden = false
            self.title = "My Profile"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
            
            
            // Profile Header
            profileHeaderView.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                                           y: profileHeaderView.bounds.maxY - profileHeaderView.layer.shadowRadius,
                                                                           width: profileHeaderView.bounds.width,
                                                                           height: profileHeaderView.layer.shadowRadius)).cgPath
            profileHeaderView.layer.shadowColor = UIColor.black.cgColor
            profileHeaderView.layer.shadowOpacity = 0.5
            profileHeaderView.layer.shadowOffset = .init(width: 0, height: 4)
            profileHeaderView.layer.shadowRadius = 4
            
            profileHeaderView.profileImageView.layer.borderWidth = 1
            profileHeaderView.profileImageView.layer.masksToBounds = false
            profileHeaderView.profileImageView.layer.borderColor = UIColor.systemGray.cgColor
            profileHeaderView.profileImageView.layer.cornerRadius = profileHeaderView.profileImageView.frame.height / 2
            profileHeaderView.profileImageView.clipsToBounds = true
            profileHeaderView.profileImageView.sd_setImage(with: URL(string: userDefaults.value(forKey: "imageData") as? String ?? ""), placeholderImage: UIImage(systemName: "person.circle.fill")?.withTintColor(UIColor.init(named: "Button Blue") ?? UIColor.systemBlue))
            profileHeaderView.profileNameLabel.text = userDefaults.value(forKey: "fullName") as? String ?? "Your Name"
            profileHeaderView.profilePhoneNumberLabel.text = userDefaults.value(forKey: "phoneNumber") as? String ?? "08xxxxxxxx"
            
            
            // Profile Card 1
            profileCardView1.headerLabel.text = "Account"
            
            // Profile Card 1 Rounded Corners
            profileCardView1.containerView.layer.cornerRadius = 5
            
            // Profile Card 1 Shadow
            profileCardView1.containerView.layer.shadowColor = UIColor.black.cgColor
            profileCardView1.containerView.layer.shadowOpacity = 0.25
            profileCardView1.containerView.layer.shadowOffset = .zero
            profileCardView1.containerView.layer.shadowRadius = 4
            
            // Profile Card 1 Row
            profileCardView1.profileCardRow1.iconImageView.image = UIImage(systemName: "person.circle")
            profileCardView1.profileCardRow1.titleLabel.text = "Edit Profile"
            profileCardView1.profileCardRow1.buttonOutlet.addTarget(self, action: #selector(pushToEditProfileView), for: .touchUpInside)
            
            profileCardView1.profileCardRow2.iconImageView.image = UIImage(systemName: "lock.fill")
            profileCardView1.profileCardRow2.titleLabel.text = "Change Password"
            profileCardView1.profileCardRow2.buttonOutlet.addTarget(self, action: #selector(pushToChangePasswordView), for: .touchUpInside)
            
            
            // Commented until further update
            /*
            // Profile Card 2
            profileCardView2.headerLabel.text = "About MediKuy"
            
            // Profile Card 2 Rounded Corners
            profileCardView2.containerView.layer.cornerRadius = 5
            
            // Profile Card 2 Shadow
            profileCardView2.containerView.layer.shadowColor = UIColor.black.cgColor
            profileCardView2.containerView.layer.shadowOpacity = 0.25
            profileCardView2.containerView.layer.shadowOffset = .zero
            profileCardView2.containerView.layer.shadowRadius = 4
            
            // Profile Card 2 Row
            profileCardView2.profileCardRow1.iconImageView.image = UIImage(systemName: "house")
            profileCardView2.profileCardRow1.titleLabel.text = "About Us"
            
            profileCardView2.profileCardRow2.iconImageView.image = UIImage(systemName: "phone")
            profileCardView2.profileCardRow2.titleLabel.text = "Contact Us"
            */
            
            
            // Sign Out Button
            signOutButton.contentView.layer.cornerRadius = 5
            
            signOutButton.layer.shadowPath = UIBezierPath(rect: profileHeaderView.bounds).cgPath
            signOutButton.contentView.layer.shadowColor = UIColor.black.cgColor
            signOutButton.contentView.layer.shadowOpacity = 0.25
            signOutButton.contentView.layer.shadowOffset = .zero
            signOutButton.contentView.layer.shadowRadius = 4
            
            // Sign Out Button Attributed Title
            guard let signOutButtonFont = UIFont(name: "Nunito-Regular", size: 17) else {
                fatalError("""
                        Failed to load the "Nunito-Regular" font.
                        Make sure the font file is included in the project and the font name is spelled correctly.
                        """
                    )
            }
            
            let signOutButtonAttributes = NSAttributedString(string: "Sign Out", attributes: [NSAttributedString.Key.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: signOutButtonFont)])
            
            signOutButton.buttonOutlet.setAttributedTitle(signOutButtonAttributes, for: .normal)
            signOutButton.buttonOutlet.setAttributedTitle(signOutButtonAttributes, for: .highlighted)
            signOutButton.buttonOutlet.setAttributedTitle(signOutButtonAttributes, for: .focused)
            
            signOutButton.buttonOutlet.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    // MARK: - Button Methods
    
    @objc func dismissView(button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func pushToEditProfileView(button: UIButton) {
        let vc = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @objc func pushToChangePasswordView(button: UIButton) {
        let vc = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @objc func signOut(button: UIButton) {
        userDefaults.removeObject(forKey: "token")
        userDefaults.removeObject(forKey: "id")
        userDefaults.removeObject(forKey: "fullName")
        userDefaults.removeObject(forKey: "age")
        userDefaults.removeObject(forKey: "email")
        userDefaults.removeObject(forKey: "gender")
        userDefaults.removeObject(forKey: "birthDate")
        userDefaults.removeObject(forKey: "phoneNumber")
        userDefaults.removeObject(forKey: "imageData")
        userDefaults.removeObject(forKey: "isAdmin")
        userDefaults.removeObject(forKey: "isActive")
        userDefaults.removeObject(forKey: "createdAt")
        userDefaults.removeObject(forKey: "updateAt")
        
        self.requestData()
        
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - Profile View Model Delegate

extension ProfileViewController: profileViewModelDelegate {
    func onSuccessRequest() {
        self.removeSpinner()
        profileHeaderView.profileNameLabel.text = userDefaults.value(forKey: "fullName") as? String ?? "Your Name"
        profileHeaderView.profilePhoneNumberLabel.text = userDefaults.value(forKey: "phoneNumber") as? String ?? "08xxxxxxxx"
    }

    func onErrorRequest() {
        self.removeSpinner()
    }
}



// MARK: - Methods

extension ProfileViewController {
    func requestData() {
        self.showParentSpinner()
        viewModel.getUser(token: "\(userDefaults.value(forKey: "token"))")
    }
}
