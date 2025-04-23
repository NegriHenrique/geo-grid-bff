class CreateSolidQueueJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :job_class
      t.text :arguments
      t.string :queue_name
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
