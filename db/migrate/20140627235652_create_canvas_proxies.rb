class CreateCanvasProxies < ActiveRecord::Migration
  def change
    create_table :canvas_proxies do |t|

      t.timestamps
    end
  end
end
