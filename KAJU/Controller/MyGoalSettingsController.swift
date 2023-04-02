//
//  MyGoalSettingsController.swift
//  KAJU
//
//  Created by kadir on 28.02.2023.
//

import UIKit

class MyGoalSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = UITableView()
    var goalValue: String!
    var weightValue: String!
    var activenessValue: String!
    var goalWeightValue: String!
    var weeklyGoalValue: String!
    var goalCalorieValue: String!
    let viewTitle = {
        let label = UILabel()
        label.text = "My Goal Settings"
        label.font = UIFont(name: "Copperplate Bold", size: 33)
        label.textColor = .white
        return label
    }()
    
    let backGroundColor = ThemesOptions.backGroundColor
    let cellBackgColor = ThemesOptions.cellBackgColor
    var goalSettingModels: [SettingModel] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        define()
    }
    func define(){
        goalSettingModels = fetcData()
        linkViews()
        delegateTableView()
        configureView()
        configureLayout()
    }
    
    init(goalValue: String, weightValue: String, goalCaloryValue: String, activenessValue: String, goalWeightValue: String, weeklyGoalValue: String) {
        super.init(nibName: nil, bundle: nil)
        self.goalValue = goalValue
        self.weightValue = weightValue
        self.goalCalorieValue = goalCaloryValue
        self.activenessValue = activenessValue
        self.goalWeightValue = goalWeightValue
        self.weeklyGoalValue = weeklyGoalValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func linkViews(){
        view.addSubview(viewTitle)
        view.addSubview(tableView)
    }
    
    func delegateTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyGoalSettingCell.self, forCellReuseIdentifier: MyGoalSettingCell.identifier)
        tableView.backgroundColor = backGroundColor
    }
    
    func configureView(){
        view.backgroundColor = backGroundColor
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureLayout(){
        viewTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: tableView.topAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        tableView.anchor(top: viewTitle.bottomAnchor, left: viewTitle.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: viewTitle.rightAnchor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalSettingModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyGoalSettingCell.identifier) as! MyGoalSettingCell
        cell.backgroundColor = backGroundColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.myViewController = self
        cell.setProfileSetting(model: goalSettingModels[indexPath.row])
        return cell
    }

}

extension MyGoalSettingsController {
    func fetcData() -> [SettingModel]{
        let goalSetting1 = SettingModel(textLabel: "Goal", textValue: goalValue)
        let goalSetting2 = SettingModel(textLabel: "Starting Weight", textValue: weightValue)
        let goalSetting3 = SettingModel(textLabel: "Goal Weight", textValue: goalWeightValue)
        let goalSetting4 = SettingModel(textLabel: "Activity Level", textValue: activenessValue)
        let goalSetting5 = SettingModel(textLabel: "Weekly Goal", textValue: weeklyGoalValue)
        let goalSetting6 = SettingModel(textLabel: "Calorie Goal", textValue: goalCalorieValue)
        
        return [goalSetting1, goalSetting2, goalSetting3, goalSetting4, goalSetting5, goalSetting6]
    }
}
