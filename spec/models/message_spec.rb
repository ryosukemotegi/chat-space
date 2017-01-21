require 'rails_helper'
describe Message do
  describe '#create' do
    it "bodyが存在すれば登録できる" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "bodyが空だと登録できない" do
      message = build(:message, body: nil)
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end
  end
end
