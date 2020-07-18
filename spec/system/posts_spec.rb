require 'rails_helper'

describe "記事のテスト", type: :system do
	let(:user) { create(:user) }
	let(:user2) { create(:user) }
	let(:post) { create(:post, user_id: user.id) }
	let(:post2) { create(:post, user_id: user2.id) }
	let(:comment) { create(:comment, user_id: user.id, post_id: post.id) }
	let(:comment2) { create(:comment, user_id: user2.id, post_id: post.id) }
	before do
		visit new_user_session_path
		fill_in "user[email]", with: user.email
		fill_in "user[password]", with: user.password
		click_button "ログイン"
	end

	describe "投稿画面" do
		context "投稿画面への遷移"
			it "遷移できる" do
				visit new_post_path
				expect(current_path).to eq "/posts/new"
		end
		context "表示の確認" do
			before do
				visit new_post_path
			end

			it "プレビュー画像が表示されている" do
				expect(page).to have_css "img.fallback"
			end
			it "タイトル投稿フォームが表示されている" do
				expect(page).to have_field "post[title]"
			end
			it "タグ投稿フォームが表示されている" do
				expect(page).to have_field "post[tag_list]"
			end
			it "本文投稿フォームが表示されている" do
				expect(page).to have_field "post[body]"
			end
			it "郵便番号投稿フォームが表示されている" do
				expect(page).to have_field "post[post_code]"
			end
			it "住所投稿フォームが表示されている" do
				expect(page).to have_field "post[address]"
			end
		end
		context "フォームの確認" do
			before do
				visit new_post_path
			end

			it "投稿に成功し、記事詳細画面に遷移する" do
				fill_in "post[title]", with: "タイトルタイトル"
				fill_in "post[tag_list]", with: Faker::Lorem.characters(number:5)
				fill_in "post[body]", with: Faker::Lorem.characters(number:400)
				fill_in "post[post_code]", with: Faker::Lorem.characters(number:7)
				fill_in "post[address]", with: Faker::Lorem.characters(number:20)
				click_button "投稿"

				expect(page).to have_content "タイトルタイトル"
			end
			it "空欄で投稿に失敗する" do
				click_button "投稿"
				expect(page).to have_content "入力されていません"
			end
		end
	end
	describe "編集画面" do
		context "自分の編集画面への遷移" do
			it "遷移できる" do
				visit edit_post_path(post)
				expect(current_path).to eq "/posts/" + post.id.to_s + "/edit"
			end
		end
		context "他人の編集画面への遷移" do
			it "遷移できない" do
				visit edit_post_path(post2)
				expect(current_path).to eq "/posts"
			end
		end
		context "表示の確認" do
			before do
				visit edit_post_path(post)
			end

			it "プレビュー画像が表示されている" do
				expect(page).to have_css "img.image"
			end
			it "タイトル編集フォームが表示される" do
				expect(page).to have_field "post[title]", with: post.title
			end
			it "タグ編集フォームが表示される" do
				expect(page).to have_field "post[tag_list]", with: ""
			end
			it "本文編集フォームが表示される" do
				expect(page).to have_field "post[body]", with: post.body
			end
			it "郵便番号編集フォームが表示される" do
				expect(page).to have_field "post[post_code]", with: post.post_code
			end
			it "住所編集フォームが表示される" do
				expect(page).to have_field "post[address]", with: post.address
			end
		end
		context "フォームの確認" do
			before do
				visit edit_post_path(post)
			end
			it "編集に成功し、記事詳細画面に遷移する" do
				click_button "編集"
				expect(current_path).to eq post_path(post)
			end
			it "空欄で編集に失敗する" do
				fill_in "post[title]", with: ""
				click_button "編集"
				expect(current_path).to eq post_path(post)
			end
		end
	end
	describe "詳細画面" do
		context "詳細画面への遷移" do
			it "遷移できる" do
				visit post_path(post)
				expect(current_path).to eq "/posts/" + post.id.to_s
			end
		end
		context "表示の確認" do
			before do
				visit edit_post_path(post)
				fill_in "post[tag_list]", with: "tag1,tag2,tag3"
				click_button "編集"
				visit post_path(post)
			end
			# it "画像が表示される" do
			# 	expect(page).to have_css "img.image"
			# end
			it "タイトルが表示される" do
				expect(page).to have_content post.title
			end
			it "タグリンクが表示される" do
				expect(page).to have_link(href: search_path(search_tag: "tag1", sort: "新着順"))
				expect(page).to have_link(href: search_path(search_tag: "tag2", sort: "新着順"))
				expect(page).to have_link(href: search_path(search_tag: "tag3", sort: "新着順"))
			end
			it "本文が表示される" do
				expect(page).to have_content post.body
			end
			it "住所が表示される" do
				expect(page).to have_content post.address
			end
			# it "GoogleMapが表示される" do
			# 	要検討
			# end
			it "いいねリンクが表示される" do
				expect(page).to have_link(href: post_likes_path(post))
			end

			it "プロフィール画像が表示される" do
				expect(page).to have_css "img.profile_image"
			end
			it "名前が表示される" do
				expect(page).to have_content post.user.name
			end
			it "フォロー数が表示されている" do
				expect(page).to have_content "フォロー　#{post.user.followings.count}"
			end
			it "フォロワー数が表示されている" do
				expect(page).to have_content "フォロワー　#{post.user.followers.count}"
			end

			it "コメントの件数が表示される" do
				expect(page).to have_content "#{post.comments.count}件"
			end
			it "コメント投稿者名が表示される" do
				expect(page).to have_content comment.user.name
			end
			it "コメント本文が表示される" do
				expect(page).to have_content comment.body
			end
			it "コメント投稿フォームが表示される" do
				expect(page).to have_field "comment[body]"
			end
			it "自分のコメントに削除リンクが表示される" do
				expect(page).to have_link(href: comment_path(comment))
			end
			it "他人のコメントに削除リンクが表示されない" do
				expect(page).to_not have_link(href: comment_path(comment2))
			end
		end
		context "自分の詳細画面の表示確認" do
			before do
				visit post_path(post)
			end
			it "編集、削除リンクが表示される" do
				expect(page).to have_link(href: edit_post_path(post))
				expect(page).to have_link(href: post_path(post))
			end
			it "フォローリンクが表示されない" do
				expect(page).to_not have_link(href: user_relationships_path(post.user))
			end
		end
		context "他人の詳細画面の表示確認" do
			before do
				visit post_path(post2)
			end
			it "編集、削除リンクが表示されない" do
				expect(page).to_not have_link(href: edit_post_path(post))
				expect(page).to_not have_link(href: post_path(post))
			end
			it "フォローリンクが表示される" do
				expect(page).to have_link(href: user_relationships_path(post2.user))
			end
		end
		context "コメントフォームの確認" do
			before do
				visit post_path(post2)
			end

			it "投稿に成功する" do
			  post post_comments_path(post_id: post.id, body: "コメントコメント"), xhr: true
			  expect(page).to have_content "コメントコメント"
			end
			it "空欄で投稿に失敗する" do
				fill_in "comment[body]", with: ""
				click_button "コメントする"
				expect(page).to_not have_content user.name
			end
		end
	end
end
