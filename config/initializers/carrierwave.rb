CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AWS_ACCESS_KEY_ID',
    aws_secret_access_key: 'AWS_SECRET_ACCESS_KEY',
    region: 'ap-northeast-1'
  }

  case Rails.env
    when 'production'
      config.storage = :fog
      config.fog_directory = 'chatspace-image'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chatspace-image'

    when 'development'
      config.storage = :fog
      config.fog_directory = 'chatspace-image'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/chatspace-image'

    when 'test'
      config.storage = :file
  end
end
