# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # Create connect session
    url = 'https://www.saltedge.com/api/v5/connect_sessions/create'
    payload = { "data": { "customer_id": current_user.customer_id, "return_connection_id": true,
                          "consent": { "scopes": %w[account_details transactions_details] }, "attempt": { "fetch_scopes": %w[accounts transactions] } } }
    response = RestClient::Request.execute(method: :post, url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json', App_id: APP_ID, Secret: SECRET },
                                           payload: payload)
    JSON.parse(response.body)
    @connect_url = JSON.parse(response.body)['data']['connect_url']

    redirect_to @connect_url
  end

  def index
    @connections = Connection.all
    # Fetch connections
    url = "https://www.saltedge.com/api/v5/connections?customer_id=#{current_user.customer_id}"
    response = RestClient::Request.execute(method: :get, url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json', App_id: APP_ID, Secret: SECRET })
    connections = JSON.parse(response.body)

    connections['data'].map { |connection| Connection.create(data: connection) }
  end
end
