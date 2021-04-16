require 'rails_helper'

RSpec.describe "レビュー投稿", type: :system do

  before do
    @book = FactoryBot.build(:book)
    @user = FactoryBot.create(:user)
  end

  context 'レビュー投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_book_path
      # フォームに情報を入力する
      fill_in '本のタイトル', with: @book.title
      image_path = Rails.root.join('public/images/output-image.png')
      attach_file('book[image]', image_path, make_visible: true)
      fill_in 'レビュー', with: @book.review
      # 送信するとreviewモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Book.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content(@book.title)
    end
  end

  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end
 
