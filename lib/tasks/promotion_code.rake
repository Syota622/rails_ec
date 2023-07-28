namespace :promotion_code do
  desc 'プロモーションコードを生成'
  task generate: :environment do
    10.times do
      # 7文字のランダムな英数字を生成
      code = SecureRandom.alphanumeric(7)
      discount_amount = rand(100..1000)
      # 生成したコードと割引額をPromotionCodeモデルに保存
      PromotionCode.create(code: code, discount_amount: discount_amount, used: false)
    end
  end
end
