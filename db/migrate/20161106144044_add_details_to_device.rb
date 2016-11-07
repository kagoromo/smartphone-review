class AddDetailsToDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :devices, :screen, :string
    add_column :devices, :chipset, :string
    add_column :devices, :CPU, :string
    add_column :devices, :GPU, :string
    add_column :devices, :RAM, :string
    add_column :devices, :OS, :string
    add_column :devices, :main_camera, :string
    add_column :devices, :sub_camera, :string
    add_column :devices, :internal_memory, :string
    add_column :devices, :external_memory, :string
    add_column :devices, :battery, :string
  end
end
