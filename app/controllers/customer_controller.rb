class CustomerController < ApplicationController
  before_action :authenticate_user!
  
  APP_ID = 'onZUyupymIArVrb0bQ4KvY4jLprRQa6v4Bl5OZQHYOg'
  SECRET = 'YxfEXvS9XhwIbQBcXbO3hGuDdR5PNrAPMFUtTYTTnR8'

  def new
    #Create a customer
    begin
    url = 'https://www.saltedge.com/api/v5/customers/'
    payload = { "data": { "identifier": current_user.email } }
    response = RestClient::Request.execute(method: :post,
                                           url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json', App_id: APP_ID, Secret: SECRET },
                                           payload: payload)
    customer = JSON.parse(response.body)
    current_user.update(customer_id: customer['data']['id']) if !customer.empty?
    
    redirect_to root_path

    rescue RestClient::ExceptionWithResponse => err
      # Catch 409 Dublicated error
      redirect_to root_path if err.response.code == 409
    end
  end
end

