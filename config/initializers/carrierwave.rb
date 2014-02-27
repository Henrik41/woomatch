AWS_CONFIG = YAML.load_file("#{::Rails.root}/config/aws.yml")[::Rails.env]
CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = AWS_CONFIG['bucket']
  config.aws_acl    = :public_read
#  config.asset_host = 'http://localhost:3000'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     AWS_CONFIG['access_key_id'],
    secret_access_key: AWS_CONFIG['secret_access_key']
    
     }
end