if Rails.env.development?   
  OmniAuth.config.full_host = "http://localhost:3000" #if this remove can see an error "undefined method ssl?"
end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?  
    provider :facebook, '368106349969719', '73d046490c266d859fc57a78a3502565'
    provider :google_oauth2, '737093073099.apps.googleusercontent.com', 'cbNfqYjoFadGz1QEdsgYBemD',       { access_type: "offline", approval_prompt: "" }
    provider :linkedin, '0i8midv5si3p', 'A9C4M304Z2OuLdnu'
  elsif Rails.env.development?
    provider :facebook, '106263322898504', '355d56ba0873640e5c432e48975d9525'
    provider :google_oauth2, '737093073099.apps.googleusercontent.com', 'cbNfqYjoFadGz1QEdsgYBemD',       { access_type: "offline", approval_prompt: "" }
    provider :linkedin, 'ylfidq4p110g', 'EiQ6O7MvXJFDFc1U'
  end
end


