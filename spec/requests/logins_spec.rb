require 'rails_helper'

RSpec.describe "Logins", type: :request do

  let(:user) { create(:user) }

  scenario "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: user.email, password: user.password } }

    expect(is_logged_in?).to be true
    expect(response).to redirect_to(user)
    follow_redirect!
    expect(response).to render_template('users/show')
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user)
    delete logout_path
    expect(is_logged_in?).to be false
    expect(response).to redirect_to(root_url)
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(user), count: 0
  end

  scenario "login with remembering" do
    log_in_as(user, remember_me: '1')
    expect(cookies['remember_token']).to_not be_empty
  end

  scenario "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(user, remember_me: '0')
    expect(cookies['remember_token']).to be_empty
  end
end
