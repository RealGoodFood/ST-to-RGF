#OmniAuth.config.full_host = "http://localhost:3000" #if this remove can see an error "undefined method ssl?"
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '368106349969719', '73d046490c266d859fc57a78a3502565'
  provider :google_oauth2, '737093073099.apps.googleusercontent.com', 'cbNfqYjoFadGz1QEdsgYBemD', { access_type: "offline", approval_prompt: "" }
  provider :twitter, '2ENJtS2IKIUxFlk2zlPQ', 'mx6AzFCMxWV5iTSvkOFjyfdvdqJWU72a3aZxE3rTW04'
  provider :linkedin, '0i8midv5si3p', 'A9C4M304Z2OuLdnu'

end


