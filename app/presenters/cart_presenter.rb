class CartPresenter < BasePresenter
  presents :cart
  def checkout_link
    if template.current_user
      template.link_to "Checkout", template.new_donation_path, class: "btn btn-primary"
    else
      template.link_to "Login or Create Account to Checkout", template.login_path, class: "btn btn-primary"
    end
  end
end
