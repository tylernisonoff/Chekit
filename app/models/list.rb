class List < ActiveRecord::Base
  has_many :items

  attr_accessible :name

  # returns an array of tags sorted from most popular to least
  def sorted_tags
    tags.sort_by {|k,v| v}.reverse
  end

  def tags
    tags  = self.items.inject(Hash.new(0)) do |hash, item|
      item.tags.each do |tag|
        hash[tag.name] += 1
      end
      hash # so that the inject block returns the hash 
    end
  end
end
