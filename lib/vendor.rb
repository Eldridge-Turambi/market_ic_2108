class Vendor
  attr_reader :name,
              :inventory


  def initialize(name)
    @name = name
    @inventory =  Hash.new(0)# - will make new hash with default zero. It will not come back as nil
  end

  def check_stock(item)
    @inventory[item]
  #     @inventory[item] = 0
  #   else
  #     @inventory[item]
  #   end
  end

  def stock(item, quantity)
    check_stock(item)

    @inventory[item] += quantity
  end

  def potential_revenue
    revenue = 0
    @inventory.map do |item, quantity|
      revenue += (item.price * quantity)
    end
    revenue
  end

end
