object @person
attributes :id, :username, :given_name, :family_name, :locale, :description

node :communities do |person|
  person.communities.map do |community|
    partial 'api/communities/show', :object => community, :root => false
  end
end

node do |person|
  node :picture_url do |person|
    ensure_full_image_url(person.image.url(:medium))
  end
  
  node :thumbnail_url do |person|
    ensure_full_image_url(person.image.url(:thumb))
  end
end

if @show_email
  attributes :email
end

if @current_user
  attributes :phone_number
  child :location => :location do
    extends "api/locations/show"
  end
end

