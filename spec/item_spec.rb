require './lib/item'

RSpec.describe Item do
  before :each do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  it 'is an instance of Item' do
    expect(@item1).to be_an_instance_of(Item)
  end

  it 'has a name and price attributes' do
    expect(@item2.name).to eq("Tomato")
    expect(@item1.price).to eq(0.75)
  end
end
