require 'rails_helper'

describe "会員認証のテスト", type: :system do
	describe "会員新規登録" do
		before do
			visit new_user_registration_path
		end
		context "新規登録画面" do
			it "新規登録に成功し、トップページに遷移する" do
				fill_in "user[name]", with: Faker::Lorem.characters(number:10)
				fill_in "user[email]", with: Faker::Internet.email
				fill_in "user[password]", with: "password"
				fill_in "user[password_confirmation]", with: "password"
				click_button "新規登録"

				expect(current_path).to eq root_path
			end
			it "空欄で新規登録に失敗する" do
				fill_in "user[name]", with: ""
				fill_in "user[email]", with: ""
				fill_in "user[password]", with: ""
				fill_in "user[password_confirmation]", with: ""
				click_button "新規登録"

				expect(current_path).to eq "/users"
			end
		end
	end
	describe "会員ログイン" do
		let!(:user) { create(:user) }
		before do
			visit new_user_session_path
		end

		context "ログイン" do
			it "ログインに成功し、トップページに遷移する" do
				fill_in "user[email]", with: user.email
				fill_in "user[password]", with: user.password
				click_button "ログイン"

				expect(current_path).to eq root_path
			end
			it "空欄でログインに失敗する" do
				fill_in "user[email]", with: ""
				fill_in "user[password]", with: ""
				click_button "ログイン"

				expect(current_path).to eq new_user_session_path
			end
		end
	end
end

describe "会員のテスト" do
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	describe "編集画面" do
		before do
			visit new_user_session_path
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
			click_button "ログイン"
		end

		context "自分の編集画面への遷移" do
			it "遷移できる" do
				visit edit_user_path(user)
				expect(current_path).to eq "/users/" + user.id.to_s + "/edit"
			end
		end
		context "他人の編集画面への遷移" do
			it "遷移できない" do
				visit edit_user_path(user2)
				expect(current_path).to eq "/users/" + user.id.to_s
			end
		end
		context "表示の確認" do
			before do
				visit edit_user_path(user)
			end
			it "プロフィール画像が表示される" do
				expect(page).to have_css "img.profile_image"
			end
			it "名前編集フォームが表示される" do
				expect(page).to have_field "user[name]", with: user.name
 			end
 			it "自己紹介編集フォームが表示される" do
 				expect(page).to have_field "user[introduction]"
 			end
 			it "メールアドレス編集フォームが表示される" do
 				expect(page).to have_field "user[email]", with: user.email
 			end
 			it "退会ページリンクが表示される" do
 				expect(page).to have_link(href: users_destroy_page_path)
 			end
		end
		context "フォームの確認" do
			before do
				visit edit_user_path(user)
			end
			it "編集に成功する" do
				click_button "編集"
				expect(current_path).to eq user_path(user)
			end
			it "編集に失敗する" do
				fill_in "user[name]", with: ""
				click_button "編集"
				expect(current_path).to eq user_path(user)
			end
		end
	end
	describe "退会画面" do
		before do
			visit new_user_session_path
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
			click_button "ログイン"
		end
		context "退会画面への遷移" do
			it "遷移できる" do
				visit users_destroy_page_path
				expect(current_path).to eq "/users/destroy_page"
			end
		end
		context "表示の確認" do
			it "退会リンクが表示されている" do
				visit users_destroy_page_path
				expect(page).to have_link(href: user_registration_path)
			end
		end
		context "アクセスの確認" do
			it "退会し、トップページに遷移する" do
				visit users_destroy_page_path
				page.driver.submit :delete, "/users", {}
				expect(current_path).to eq root_path
			end
		end
	end
	describe "詳細画面" do
		before do
			visit new_user_session_path
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
			click_button "ログイン"
		end

		context "詳細画面への遷移" do
			it "遷移できる" do
				visit user_path(user)
				expect(current_path).to eq "/users/" + user.id.to_s
			end
		end
		context "表示確認" do
			before do
				visit user_path(user)
			end
			it "画像が表示される" do
				expect(page).to have_css "img.profile_image"
			end
			it "名前が表示される" do
				expect(page).to have_content user.name
			end
			it "フォロー数が表示される" do
				expect(page).to have_selector "td", text: "フォロー　#{user.followings.count}"
			end
			it "フォロワー数が表示される" do
				expect(page).to have_selector "td", text: "フォロワー　#{user.followers.count}"
			end
			it "いいね済み記事一覧リンクが表示される" do
				expect(page).to have_link "", href: user_path(id: user.id, tab: "いいね")
			end
			it "フォロー一覧リンクが表示される" do
				expect(page).to have_link "", href: user_path(id: user.id, tab: "フォロー")
			end
			it "フォロワー一覧リンクが表示される" do
				expect(page).to have_link "", href: user_path(id: user.id, tab: "フォロワー")
			end
		end
		context "自分の詳細画面の表示確認" do
			before do
				visit user_path(user)
			end
			it "編集リンクが表示される" do
				expect(page).to have_link(href: edit_user_path(user))
			end
			it "フォローリンクが表示されない" do
				expect(page).to_not have_link(href: user_relationships_path(user))
			end
		end
		context "他人の詳細画面の表示確認" do
			before do
				visit user_path(user2)
			end
			it "フォローリンクが表示される" do
				expect(page).to have_link(href: user_relationships_path(user2))
			end
			it "編集リンクが表示されない" do
				expect(page).to_not eq have_link(href: edit_user_path(user2))
			end
		end
	end
end
