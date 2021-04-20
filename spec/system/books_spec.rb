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
 
RSpec.describe 'レビュー編集', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  context 'レビュー編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @book1.user.email
      fill_in 'user_password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 本の詳細ページへ遷移する
      visit book_path(@book1)
      # レビュー1に「編集」ボタンがあることを確認する
      click_link '編集する'
      # 編集ページへ遷移する
      visit edit_book_path(@book1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # expect(
      #   find('#book_image').value
      # ).to eq(@book1.image)
      expect(
        find('#book_title').value
      ).to eq(@book1.title)
      expect(
        find('#book_review').value
      ).to eq(@book1.review)
      # 投稿内容を編集する
      fill_in 'book_title', with: "#{@book1.title}+編集したテキスト"
      fill_in 'book_review', with: "#{@book1.review}+編集したテキスト"
      image_path = Rails.root.join('public/images/output-image.png')
      attach_file('book[image]', image_path, make_visible: true)
      # 編集してもBookモデルのカウントは変わらないことを確認する
      expect{
        click_on '投稿する', match: :first
      }.to change { Book.count }.by(0)

      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector('img')
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@book1.title)
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @book1.user.email
      fill_in 'user_password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # レビュー2の本の詳細ページへ遷移する
      visit book_path(@book2)
      # レビュー2に「編集」ボタンがないことを確認する
      have_no_link '編集する', href: edit_book_path(@book2)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # レビュー1に「編集」ボタンがないことを確認する
      have_no_link '編集する', href: edit_book_path(@book1)
      # レビュー2に「編集」ボタンがないことを確認する
      have_no_link '編集する', href: edit_book_path(@book2)
    end
  end
end