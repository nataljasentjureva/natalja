class AddConfirmableToAdminsToDevise < ActiveRecord::Migration[6.0]
    # Note: You can't use change, as User.update_all will fail in the down migration
    def change
      add_column :admins, :confirmation_token, :string
      add_column :admins, :confirmed_at, :datetime
      add_column :admins, :confirmation_sent_at, :datetime
      add_index :admins, :confirmation_token, unique: true

      Admin.update_all confirmed_at: DateTime.now
    end
end
