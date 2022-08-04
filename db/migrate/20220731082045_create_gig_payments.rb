class CreateGigPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :gig_payments do |t|
      t.string :state
      t.belongs_to :gig

      t.timestamps
    end
  end
end
