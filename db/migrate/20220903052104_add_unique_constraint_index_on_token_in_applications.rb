class AddUniqueConstraintIndexOnTokenInApplications < ActiveRecord::Migration[7.0]
  def change
    add_index :applications, :token, unique: true
  end
end
