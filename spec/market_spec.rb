require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before :each do
    @market = Market.new("South Pearl Street Farmers Market")

    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")

  end

  it "is an instance of Market" do
    expect(@market).to be_an_instance_of(Market)
  end

  it "has a name" do
    expect(@market.name).to eq("South Pearl Street Farmers Market")
  end

  it "has empty vendors by default" do
    expect(@market.vendors).to eq([])
  end

  it "#add_vendor" do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
  end

  it "#vendor_names" do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expect(@market.vendor_names).to eq([@vendor1.name, @vendor2.name, @vendor3.name])
  end

  it "#vendors_that_sell(item)" do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)

    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
  end

  it "#total_inventory" do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)

    expected = {
      @item1 => {
        quantity: 100,
        vendors: [@vendor1, @vendor3]
      },
      @item2 => {
        quantity: 7,
        vendors: [@vendor1]
      },
      @item4 => {
        quantity: 50,
        vendors: [@vendor2]
      },
      @item3 => {
        quantity: 35,
        vendors: [@vendor2, @vendor3]
      },
    }

    expect(@market.total_inventory).to eq(expected)
  end
end
