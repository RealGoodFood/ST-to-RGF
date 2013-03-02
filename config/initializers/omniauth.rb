OmniAuth.config.full_host = "http://localhost:3000" #if this remove can see an error "undefined method ssl?"
OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
#  configure do |config|
#    config.path_prefix = '/auth'
#  end
  provider :facebook, '426505044096748', 'd0bf3a6cb055626cbc2d4cf38a9e2b7c'#, :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}
#  provide  :google_auth2, 'google_key', 'google_secret' #'/auth/google_oauth2'
  provider :twitter, '2ENJtS2IKIUxFlk2zlPQ', 'mx6AzFCMxWV5iTSvkOFjyfdvdqJWU72a3aZxE3rTW04'
#  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'

end


