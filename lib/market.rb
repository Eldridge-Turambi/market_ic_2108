class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def total_inventory
    items =  @vendors.map do |vendor|
      vendor.inventory.keys
    end
    unique_items = items.flatten.uniq
    market_inventory = {}
    unique_items.each do |item|
      sellers = vendors_that_sell(item)
      sellers.each do |seller|
        market_inventory[item] = {
          quantity: 0,
          vendors: sellers
        }
      end
      sellers.each do |seller|
        market_inventory[item][:quantity] += seller.inventory[item]
      end
    end
    market_inventory
  end

  def overstocked_items
    total_inventory.find_all do |item, item_info|
      if item_info[:quantity] > 50 && item_info[:vendors].length > 1
        items << item
      end
    end
    items
  end

  def sorted_item_list
    items = @vendors.map do |vendor|
      vendor.inventory.keys
    end
    unique_items = items.flatten.uniq

    names = unique_items.map do |item|
      item.names
    end

    names.sort
  end
end
