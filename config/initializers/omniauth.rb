OmniAuth.config.full_host = "http://localhost:3000" #if this remove can see an error "undefined method ssl?"
OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '426505044096748', 'd0bf3a6cb055626cbc2d4cf38a9e2b7c'
  provider :google_oauth2, '737093073099.apps.googleusercontent.com', 'cbNfqYjoFadGz1QEdsgYBemD', { access_type: "offline", approval_prompt: "" }
  provider :twitter, '2ENJtS2IKIUxFlk2zlPQ', 'mx6AzFCMxWV5iTSvkOFjyfdvdqJWU72a3aZxE3rTW04'
#  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'

end


