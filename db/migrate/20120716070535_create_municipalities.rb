class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.string  :geographic_area
      t.string  :state
      t.string  :url
      t.integer :population_estimate
      t.integer :region
      t.integer :size
      t.boolean :facebook,          default: false
      t.boolean :twitter,           default: false
      t.boolean :multiple_accounts, default: false
      t.string  :multiple_account_notes

      t.timestamps
    end
  end
end
