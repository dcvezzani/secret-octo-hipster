raise "test dependency destroy option of r settlor model in rails console"

fg_settlor = FactoryGirl.create(:settlor)
fg_settlor.spouse
fg_settlor.children.count

Client.where{settlor_id == my{fg_settlor.id}}
Client.where{(id == my{fg_settlor.id}) | (settlor_id == my{fg_settlor.id}) | (settlor_parent_id == my{fg_settlor.id}) | (spouse_parent_id == my{fg_settlor.id})}

Client.count
Address.count
Alias.count

Address.all.map(&:type)

fg_settlor.destroy

fg_settlor = Settlor.first
