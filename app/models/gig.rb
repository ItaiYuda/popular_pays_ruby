class Gig < ApplicationRecord
  belongs_to :creator
  has_one :gig_payment

  include AASM

  aasm column: :state do
    state :applied, initial: true
    
  end
end
