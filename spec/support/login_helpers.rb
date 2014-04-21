module LoginHelpers
  %w(admin user).each do |role|
    define_method "sign_in_as_#{ role }" do
      user = create :user

      user.update_attribute :role, role if role == 'admin'

      sign_in user
    end
  end
end
