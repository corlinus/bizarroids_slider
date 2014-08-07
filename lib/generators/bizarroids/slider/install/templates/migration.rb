class CreateBizarroidsSliderTables < ActiveRecord::Migration
  def change
    create_table :bizarroids_slider_collections do |t|
      t.string :key, :name, :description
      t.integer :position
    end

    add_index :bizarroids_slider_collections, :key

    create_table :bizarroids_slider_slides do |t|
      t.references :collection
      t.string :name, :description, :media, :link
      t.integer :position
    end

    add_index :bizarroids_slider_slides, [:collection_id, :position]
  end
end
