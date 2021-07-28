# frozen_string_literal: true

class CustomerController < ApplicationController
  before_action :authenticate_user!

  def new
    # Create a customer

    url = 'https://www.saltedge.com/api/v5/customers/'
    payload = { "data": { "identifier": current_user.email } }
    response = RestClient::Request.execute(method: :post,
                                           url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json',
                                                      App_id: APP_ID, Secret: SECRET },
                                           payload: payload)
    customer = JSON.parse(response.body)
    current_user.update(customer_id: customer['data']['id']) unless customer.empty?

    redirect_to root_path
  rescue RestClient::ExceptionWithResponse => e
    # Catch 409 Dublicated error
    redirect_to root_path if e.response.code == 409
  end
end
