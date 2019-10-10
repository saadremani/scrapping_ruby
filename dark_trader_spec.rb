require_relative '../lib/dark_trader'

describe "crypto_scrapper" do

  it "return something" do
    expect(crypto_scrapper).not_to be_nil
  end

	it "return at least 50 hash" do
		expect(crypto_scrapper).to satisfy { |value| value.size >= 50 }
	end

	
  
end