# frozen_string_literal: true

class TransactionsController < ApplicationController
  def index
    # fetch transactions
    @account = Account.where(connection_id: params[:connection_id])

    @connection_id = @account[params[:account_id].to_i - 1]['data']['connection_id']
    @account_id =  @account[params[:account_id].to_i - 1]['data']['id']

    url = "https://www.saltedge.com/api/v5/transactions?connection_id=#{@connection_id}&account_id=#{@account_id}"
    response = RestClient::Request.execute(method: :get, url: url,
                                           headers: { accept: 'application/json', 'content-type' => 'application/json', App_id: APP_ID, Secret: SECRET })
    @transactions = JSON.parse(response.body)
  end
end
