import Library
import UIKit

internal final class SignupViewController: UIViewController {
  @IBOutlet private weak var newsletterSwitch: UISwitch!
  @IBOutlet private weak var signupButton: UIButton!
  private let viewModel: SignupViewModelType = SignupViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.viewModel.inputs.viewDidLoad()
  }

  override func bindViewModel() {
    self.signupButton.rac.enabled = self.viewModel.outputs.isSignupButtonEnabled

    self.viewModel.outputs.setWeeklyNewsletterState
      .observeForUI()
      .observeNext { [weak self] in
        self?.newsletterSwitch.on = $0
      }

    self.viewModel.outputs.showError
      .observeForUI()
      .observeNext { [weak self] message in
        self?.presentViewController(
          UIAlertController
            .alert(
              localizedString(key: "signup.error.title", defaultValue: "Sign up error"),
              message: message),
          animated: true, completion: nil)
      }
  }

  @IBAction internal func nameChanged(textField: UITextField) {
    self.viewModel.inputs.nameChanged(textField.text ?? "")
  }

  @IBAction internal func emailChanged(textField: UITextField) {
    self.viewModel.inputs.emailChanged(textField.text ?? "")
  }

  @IBAction internal func passwordChanged(textField: UITextField) {
    self.viewModel.inputs.passwordChanged(textField.text ?? "")
  }

  @IBAction internal func weeklyNewsletterChanged(newsletterSwitch: UISwitch) {
    self.viewModel.inputs.weeklyNewsletterChanged(newsletterSwitch.on)
  }

  @IBAction internal func signupButtonPressed() {
    self.viewModel.inputs.signupButtonPressed()
  }
}
