class Inventories::BulkCreateService < ApplicationService
  def call
    @params.each do |item|
      ActiveRecord::Base.transaction do
        item[:os_version].save!
        phone = Phone.create(
          user: @current_user,
          body_color: item[:body_color],
          memory: item[:memory],
          os_version: item[:os_version],
          model: item[:model],
        )
        item[:inventory].phone = phone
        item[:inventory].save!
      end
    end
  end

  def initialize(params, user)
    @params = params
    @current_user = user
  end
end
