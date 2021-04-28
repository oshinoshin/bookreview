require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @book = FactoryBot.create(:book)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは本の詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @book.user.email
    fill_in 'user_password', with: @book.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 本の詳細ページに遷移する
    visit book_path(@book)
    # フォームに情報を入力する
    fill_in 'コメントする', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    within '.show-comment-form' do
      expect{
        find('input[class="book__btn"]').click
      }.to change { Comment.count }.by(1)
    end
    # 本の詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(book_path(@book))
    # 本の詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end