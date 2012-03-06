class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table(:user_roles, :id => false) do |t|
      t.column :user_id, :integer
      t.column :role, :string
    end
  end

  def self.down
    drop_table :user_roles
  end
end
