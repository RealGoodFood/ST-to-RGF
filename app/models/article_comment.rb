class ArticleComment < ActiveRecord::Base
  belongs_to :article
  belongs_to :author, :class_name => "Person"

  validates_presence_of :article_id, :author_id, :description

  attr_accessible :article_id, :description, :author_id

end
