migration 13, :add_omniauth_columns_to_users do
  up do
    modify_table :users do
      add_column :role, String
      add_column :uid, String
      add_column :provider, String
    end
  end

  down do
    modify_table :job_offers do
      drop_column :role
      drop_column :uid
      drop_column :provider
    end
  end
end