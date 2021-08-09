class EnableUuid < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'unaccent'
  end
end
