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
      # レビュー1に「編集」ボタンがあることを確認する

      # 編集ページへ遷移する
      visit edit_book_path(@book1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # 投稿内容を編集する
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      # 編集完了画面に遷移したことを確認する
      # 「更新が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      # ツイート2に「編集」ボタンがないことを確認する
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      # ツイート1に「編集」ボタンがないことを確認する
      # ツイート2に「編集」ボタンがないことを確認する
    end
  end
end