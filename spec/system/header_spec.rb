require 'rails_helper'

describe "ヘッダーのテスト", type: :system do
	let(:user) { create(:user) }
	let(:admin) { create(:admin) }
	describe "会員" do
		before do
			visit new_user_session_path
			fill_in "user[email]", with: user.email
			fill_in "user[password]", with: user.password
			click_button "ログイン"
		end
		describe "ログインしている場合" do
			context "ヘッダーの表示を確認" do
				it "トップリンクが表示される" do
					expect(page).to have_link(href: root_path)
				end
				it "マイページリンクが表示される" do
					expect(page).to have_link(href: user_path(user))
				end
				it "記事一覧リンクが表示される" do
					expect(page).to have_link(href: posts_path)
				end
				it "記事投稿リンクが表示される" do
					expect(page).to have_link(href: new_post_path)
				end
				it "ログアウトリンクが表示される" do
					expect(page).to have_link(href: destroy_user_session_path)
				end
			end
		end
		describe "ログアウトした場合" do
			before do
				page.driver.submit :delete, "/users/sign_out", {}
			end
			context "ヘッダーの表示を確認" do
				it "トップリンクが表示される" do
					expect(page).to have_link(href: root_path)
				end
				it "ログインリンクが表示される" do
					expect(page).to have_link(href: new_user_session_path)
				end
				it "新規登録リンクが表示される" do
					expect(page).to have_link(href: new_user_registration_path)
				end
			end
		end
	end
	describe "管理者" do
		before do
			visit new_admin_session_path
			fill_in "admin[email]", with: admin.email
			fill_in "admin[password]", with: admin.password
			click_button "ログイン"
		end
		describe "ログインしている場合" do
			context "ヘッダーの表示を確認" do
				it "会員一覧リンクが表示される" do
					expect(page).to have_link(href: admins_users_path)
				end
				it "記事一覧リンクが表示されている" do
					expect(page).to have_link(href: admins_posts_path)
				end
			end
		end
		describe "ログアウトした場合" do
			before do
				page.driver.submit :delete, "/admins/sign_out", {}
			end
			context "ヘッダーの表示を確認" do
				it "ログインリンクが表示される" do
					expect(page).to have_link(href: new_admin_session_path)
				end
			end
		end
	end
end
