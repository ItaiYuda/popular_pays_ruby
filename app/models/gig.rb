class Gig < ApplicationRecord
  belongs_to :creator
  has_one :gig_payment

  include AASM

  aasm column: :state do
    state :applied, initial: true
    state :accepted, :completed, :paid

    event :set_paid do
      transitions from: [:applied, :accepted, :completed], to: :paid
    end

    event :set_complete do
      transitions from: [:applied, :accepted], to: :completed, after: :create_gig_payment
    end
  end

  def create_gig_payment
    unless self.gig_payment
      gig_payment = GigPayment.create(gig_id: self.id)
    end
  end
end
