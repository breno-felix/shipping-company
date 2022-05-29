class ChangeColumnCpfToString < ActiveRecord::Migration[7.0]
  def change
    change_column :order_services, :cpf, :string
  end
end
