require 'rails_helper'

RSpec.feature "UsersLogins", type: :feature do

  let(:user) { create(:user) }

  scenario "jump user show page" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    expect(page).to have_text(user.name)
    expect(page).to have_link('Settings', href: edit_user_path(user))
    expect(page).to have_link('Log out', href: logout_path)
  end

  scenario "email is blank" do
    visit login_path
    fill_in "Email", with: ""
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to_not have_text(user.name)
    expect(page).to have_link('Log in', href: login_path)
    expect(page).to have_text("Invalid email/password combination")
  end

  scenario "password is blank" do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to_not have_text(user.name)
    expect(page).to have_link('Log in', href: login_path)
    expect(page).to have_text("Invalid email/password combination")
  end

  scenario "email and password is blank" do
    visit login_path
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to_not have_text(user.name)
    expect(page).to have_link('Log in', href: login_path)
    expect(page).to have_text("Invalid email/password combination")
  end
end
