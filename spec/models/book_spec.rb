require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
end

  describe 'レビューの新規投稿' do
    context '新規登録できるとき' do
      it 'titleとreviewとimageが存在すれば登録できる' do
        expect(@book).to be_valid
      end
    end
  
  
  
  
  end
end