class CreateBulkService < ApplicationService
  def call
    @params.each do |item|
      ActiveRecord::Base.transaction do
        if item[:body_color].save && item[:memory].save && item[:os_version].save
          phone = Phone.create(
            user_id: @current_user.id,
            body_color_id: item[:body_color].id,
            memory_id: item[:memory].id,
            os_version_id: item[:os_version].id,
            model_id: item[:model].id,
          )
          item[:inventory].phone_id = phone.id
          @inventory = item[:inventory]
          return false unless @inventory.save
        end
      end
    end
    true
  end

  def initialize(params, user)
    @params = params
    @current_user = user
  end
end