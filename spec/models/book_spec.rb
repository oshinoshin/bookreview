require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  describe 'レビューの投稿ができるとき' do
    context '新規登録できるとき' do
      it 'titleとreviewとimageが存在すれば登録できる' do
        expect(@book).to be_valid
      end
    end
  
    context 'レビューの投稿ができないとき' do
      it 'imageが空では登録できない' do
        @book.image = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Imageを入力してください")
      end

      it 'titleが空では登録できない' do
        @book.title = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Titleを入力してください")
      end

      it 'reviewが空では登録できない' do
        @book.review = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Reviewを入力してください")
      end


    end
  end
end