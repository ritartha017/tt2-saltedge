# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :customer

  def customer
    # Create a customer
    url = 'https://www.saltedge.com/api/v5/customers/'
    payload = { "data": { "identifier": SecureRandom.hex(8) } }
    response = RestClient::Request.execute(method: :post,
                                           url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json',
                                                      App_id: ENV['APP_ID'], Secret: ENV['SECRET'] },
                                           payload: payload)
    customer = JSON.parse(response.body)
    
    db = User.find(id)
    db.update(customer_id: customer['data']['id']) unless customer.empty?
  
    rescue RestClient::ExceptionWithResponse => e
      # Catch 409 Dublicated error
    end
end
