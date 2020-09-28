class CreateBulkService < ApplicationService
  def call
    # puts "#{@params[0][:inventory].id} - #{@params[1][:inventory].id} - #{@params[2][:inventory].id}"
    @params.each do |item|
      ActiveRecord::Base.transaction do
        item[:body_color].save!
        item[:memory].save!
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
    true
  end

  def initialize(params, user)
    @params = params
    @current_user = user
  end
end
