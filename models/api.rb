class Api < ActiveRecord::Base
  has_paper_trail :only => [:input, :output1, :output2]
  belongs_to :vendor
end
