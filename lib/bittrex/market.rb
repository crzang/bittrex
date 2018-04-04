require 'time'

module Bittrex
  class Market
    include Helpers

    attr_reader :name, :currency, :base, :currency_name, :base_name, :minimum_trade, :active, :created_at, :raw

    def initialize(attrs = {})
      @name = attrs['MarketName']
      @currency = attrs['MarketCurrency']
      @base = attrs['BaseCurrency']
      @currency_name = attrs['MarketCurrencyLong']
      @base_name = attrs['BaseCurrencyLong']
      @minimum_trade = attrs['MinTradeSize']
      @active = attrs['IsActive']
      @created_at = extract_timestamp(attrs['Created'])
      @raw = attrs
    end

    def self.all
      client.get('public/getmarkets').map{|data| new(data) }
    end

    def self.buylimit (pairname,price,volume)
      client.get("/market/buylimit",{
          market:pairname,
          quantity:volume,
          rate:price
      })
    end

    private

    def self.client
      @client ||= Bittrex.client
    end
  end
end
