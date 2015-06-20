migration 11, :add_salary_expectation_to_job_offers do
  up do
    modify_table :job_offers do
      add_column :salary_expectation, "Boolean"
    end
  end

  down do
    modify_table :job_offers do
      drop_column :salary_expectation
    end
  end
end
