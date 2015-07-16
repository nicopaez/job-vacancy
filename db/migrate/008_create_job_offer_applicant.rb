migration 8, :create_job_offer_applicants do
  up do
    create_table :job_offer_applicants do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255
      column :last_name, DataMapper::Property::String, :length => 255
      column :salary_expectations, DataMapper::Property::Integer
      column :applicant_email, DataMapper::Property::String, :length => 255
      column :link_to_cv, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :job_offer_applicants
  end
end
