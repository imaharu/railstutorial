# == Schema Information
#
# Table name: @users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string
#  remember_digest   :string
#  admin             :boolean          default(FALSE)
#  activation_digest :string
#  activated         :boolean
#  activated_at      :datetime
#  reset_digest      :string
#  reset_sent_at     :datetime
#

# attr_accessor :remember_token, :activation_token, :reset_token
# before_save :downcase_email
# before_create :create_activation_digest
# validates :name, presence: true, length: { maximum: 50 }
# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
# validates :email, format: { with: VALID_EMAIL_REGEX }
# validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

# has_many :microposts, dependent: :destroy
# has_many :active_relationships,	class_name: "Relationship",
# 																foreign_key: "follower_id",
# 																dependent: :destroy
# has_many :passive_relationships,	class_name:  "Relationship",
# 																	foreign_key: "followed_id",
# 																	dependent:   :destroy

# has_many :following, through: :active_relationships, source: :followed
# has_many :followers, through: :passive_relationships, source: :follower

require 'rails_helper'

# create mean FactoryBot.create

RSpec.describe User, type: :model do

  context "name length の境界線テスト" do
    before do
      @user = create(:user)
    end

    it "nameがblank" do
      @user.name = ""
      @user.valid?
      expect(@user.errors[:name]).to include("can't be blank")
    end

    it "nameが50文字" do
      @user.name = "a" * 50
      expect(@user).to be_valid
    end

    it "nameが51文字" do
      @user.name = "a" * 51
      expect(@user).to_not be_valid
    end
  end

  context "email length の境界線テスト" do
    before do
      @user = create(:user)
    end

    it "emailがblank" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it "emailが255文字" do
      @user.email = "a" * 243 + "@example.com" 
      expect(@user).to be_valid
    end

    it "emailが256文字" do
      @user.email = "a" * 244 + "@example.com" 
      expect(@user).to_not be_valid
    end
  end
  
  it "emailの重複は許可しないか" do
    user = create(:user)
    duplicate_user = build(:user, email: user.email)
    expect(duplicate_user).to_not be_valid
  end

  context "emailのformatテスト" do
    before do
      @user = create(:user)
    end

    it "正しい場合 part1" do
      @user.email = "user@example.com"
      expect(@user).to be_valid
    end

    it "正しい場合 part2" do
      @user.email = "USER@foo.COM"
      expect(@user).to be_valid
    end

    it "正しい場合 part3" do
      @user.email = "A_US-ER@foo.bar.org"
      expect(@user).to be_valid
    end

    it "正しい場合 part4" do
      @user.email = "first.last@foo.jp"
      expect(@user).to be_valid
    end

    it "正しい場合 part5" do
      @user.email = "alice+bob@baz.cn"
      expect(@user).to be_valid
    end

    it "間違っている場合 part1" do
      @user.email = "user@example,com"
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end

    it "間違っている場合 part2" do
      @user.email = "user_at_foo.org"
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end

    it "間違っている場合 part3" do
      @user.email = "user.name@example."
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end

    it "間違っている場合 part4" do
      @user.email = "foo@bar_baz.com"
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end

    it "間違っている場合 part5" do
      @user.email = "foo@bar+baz.com"
      @user.valid?
      expect(@user.errors[:email]).to include("is invalid")
    end
  end

  context "password length の境界線テスト" do
    before do
      @user = create(:user)
    end

    it "passwordがblankの時はpass" do
      @user.password = ""
      expect(@user).to be_valid
    end

    it "passwordがnil" do
      @user.password = nil
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it "passwordは6文字" do
      @user.password =  "a" * 6
      expect(@user).to be_valid
    end

    it "passwordが5文字" do
      @user.password = "a" * 5
      expect(@user).to_not be_valid
    end
  end
end
