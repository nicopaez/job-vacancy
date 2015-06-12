migration 10, :add_offer_id_to_job_offers_applicants do
  up do
    modify_table :job_offer_applicants do
      add_column :offer_id, Integer
    end
  end

  down do
    modify_table :job_offer_applicants do
      drop_column :offer_id
    end
  end
end