require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before :each do
    @vendor = Vendor.new("Rocky Mountain Fresh")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})

  end

  it 'is an instance of Vendor' do
    expect(@vendor).to be_an_instance_of(Vendor)
  end

  it 'has a name' do
    expect(@vendor.name).to eq("Rocky Mountain Fresh")
  end

  it "has empty inventory by default" do
    expect(@vendor.inventory).to eq({})
  end

  it "#check_stock is 0 by default" do
    expect(@vendor.check_stock(@item1)).to eq(0)
  end

  it "#stock" do
    @vendor.stock(@item1, 30)
    expect(@vendor.check_stock(@item1)).to eq(30)
    expect(@vendor.inventory).to eq({@item1 => 30})

    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)
    expect(@vendor.check_stock(@item1)).to eq(55)
    expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
  end

  it "#potential_revenue" do
    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    expect(@vendor.potential_revenue).to eq(24.75)

  end

end
