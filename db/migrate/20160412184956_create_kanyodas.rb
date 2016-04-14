class CreateKanyodas < ActiveRecord::Migration
  def change
    create_table :kanyodas do |t|

      t.timestamps null: false
    end
  end
end
