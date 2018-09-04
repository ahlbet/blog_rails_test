def login_user(valid_session)
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = User.create!(valid_session)
    sign_in user
  end
end
