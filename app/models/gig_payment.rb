class GigPayment < ApplicationRecord
  belongs_to :gig

  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :complete

    event :set_complete do
      transitions from: :pending, to: :complete, after: :after_complete
    end
  end

  def after_complete
    self.gig.set_paid!
  end
end
