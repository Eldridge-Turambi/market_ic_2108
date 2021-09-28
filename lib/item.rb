class Item
  attr_reader :name,
              :price

  def initialize(item_info)
    @name = item_info[:name]
    @price = item_info[:price].gsub('$', '').to_f #delete would work too instead of gsub
  end
end
