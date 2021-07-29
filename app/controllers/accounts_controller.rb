# frozen_string_literal: true

class AccountsController < ApplicationController
  def index
    @connection = Connection.find(params[:connection_id])

    # fetch accounts
    url = "https://www.saltedge.com/api/v5/accounts?connection_id=#{@connection.data['id']}"
    response = RestClient::Request.execute(method: :get,
                                           url: url,
                                           headers: { accept: 'application/json',
                                                      'content-type' => 'application/json',
                                                      App_id: APP_ID, Secret: SECRET })
    @accounts = JSON.parse(response.body)
    @accounts['data'].map { |account| @connection.accounts.create(data: account) }
    @account = Account.where(connection_id: @connection.id)
  end
end
