migration 11, :create_accounts do
  up do
    create_table :accounts do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :email, DataMapper::Property::String, :length => 255
      column :role, DataMapper::Property::String, :length => 255
      column :uid, DataMapper::Property::String, :length => 255
      column :provider, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :accounts
  end
end
