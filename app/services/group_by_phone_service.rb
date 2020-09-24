class GroupByPhoneService < ApplicationService
  def call
    Inventory.kept.each_with_object({}) do |inventory, hash|
      hash[inventory.phone.model.id] = hash.key?(inventory.phone.model.id) ? change_item(hash[inventory.phone.model.id], inventory) : init_item(inventory) # rubocop:disable Layout/LineLength
    end
  end

  private

  # Set inventory data to a new item for hash
  def init_item(inventory)
    item = {}
    item[:model_name] = inventory.phone.model.name
    item[:quantity] = inventory.quantity
    item[:price_min] = inventory.price
    item[:price_max] = inventory.price
    item[:price] = "#{inventory.price}$"
    item[:memory_min] = inventory.phone.memory.amount
    item[:memory_max] = item[:memory_min]
    item[:memory] = inventory.phone.memory.display_name
    item
  end

  # Update data for existed item in hash
  def change_item(item, inventory)
    item[:quantity] += inventory.quantity
    unless item[:price_min] == inventory.price && item[:price_max] == inventory.price
      item[:price_min] = [item[:price_min], inventory.price].min
      item[:price_max] = [item[:price_max], inventory.price].max
      item[:price] = "#{item[:price_min]}$ - #{item[:price_max]}$"
    end
    unless item[:memory_min] == inventory.phone.memory.amount && item[:memory_max] == inventory.phone.memory.amount
      item[:memory_min] = [item[:memory_min], inventory.phone.memory.amount].min
      item[:memory_max] = [item[:memory_max], inventory.phone.memory.amount].max
      item[:memory] = Memory.where(amount: item[:memory_min]).pick(:display_name) + " - " + Memory.where(amount: item[:memory_max]).pick(:display_name) # rubocop:disable Layout/LineLength
    end
    item
  end
end
