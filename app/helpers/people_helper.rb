require 'openssl'
require 'base64'

module PeopleHelper
  
  # Class is selected if listing type is currently selected
  def get_profile_tab_class(tab_name)
    current_tab_name = params[:type] || "offers"
    "inbox_tab_#{current_tab_name.eql?(tab_name) ? 'selected' : 'unselected'}"
  end
  
  def grade_profile_image_class(feedback_positive_percentage)
    "profile_feedback_average_image_#{grade_number_profile(feedback_positive_percentage).to_s}"
  end
  
  def grade_image_class(grade)
    "feedback_average_image_#{grade_number(grade).to_s}"
  end
  
  def grade_text(grade, full_description = true)
    t("people.#{full_description ? 'profile_feedback' : 'show'}.#{Testimonial::GRADES[grade_number(grade) - 1][0]}")
  end
  
  def grade_number(grade)
    if grade < 2
      return 1
    elsif (grade >= 2 && grade < 3)
      return 2
    elsif (grade >= 3 && grade < 3.5)
      return 3
    elsif (grade >= 3.5 && grade < 4.5)
      return 4
    else
      return 5
    end
  end
  
  def grade_number_profile(percentage)
    if percentage < 50
      return 1
    elsif (percentage >= 50 && percentage < 65)
      return 2
    elsif (percentage >= 65 && percentage < 80)
      return 3
    elsif (percentage >= 80 && percentage < 90)
      return 4
    else
      return 5
    end
  end
  
  def profile_testimonial_other_person_role(person, listing)
    if (person.eql?(listing.author) && listing.listing_type.eql?("request")) || (!person.eql?(listing.author) && listing.listing_type.eql?("offer"))
      "offer"
    else
      "request"
    end
  end
  
  def help_text_class(field)
    case field
    when "terms"
      "hidden_description_terms"
    when "feedback_description"
      "hidden_description_feedback"
    else
       "hidden_description_terms"
    end
  end
  
  def email_available_for_user?(user, email)
      if user && (user.email == email || Email.find_by_address_and_person_id(email, user.id) )
        # Current user's own email should not be shown as unavailable
        return true
      else
        return Person.email_available?(email)
      end
  end
  
  def encrypted_email_for_trustcloud(email)
    # Public RSA key of TrustCloud
    tcpublickey =  OpenSSL::PKey::RSA.new("-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDY1tLeY6qZtq8BqDnbArujYyjG\nwGPrkzLhyQMUX4ASW+912gf1RPRJVsuufGuhTYsP+biXxjWAI8rUX1k4YisiOK8u\nflUED8i5Zrpn7dR8NNGQc/A3LLjPzmaqW7g++5Q+iIoSCRYczsUxx6Bmo/a9YIFJ\nWWbeYnKh10eHN/JMewIDAQAB\n-----END PUBLIC KEY-----")
    # Make the string URL safe by changing some characters
    encrypted_email = Base64.encode64(tcpublickey.public_encrypt(email)).tr('+/=', '-_~')
  end
  
  # Returns the error message for a case where
  # the user is trying to create a new email-restricted tribe
  # but there's already a community with the
  # email provided.
  def restricted_tribe_already_exists_error_message(existing_community)
    t("communities.signup_form.existing_community_with_this_email", :community_category => t("communities.signup_form.for_#{existing_community.category}"), :link => self.class.helpers.link_to(t("communities.signup_form.here"), get_url_for(existing_community))).html_safe 
  end
  
end
