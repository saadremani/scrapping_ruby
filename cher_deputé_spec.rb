require_relative '../lib/cher_deputé'

describe "scrapper" do

  it "return something" do
    expect(scrapper).not_to be_nil
  end

  it "return at least 50 hash" do
		expect(scrapper).to satisfy { |value| value.size >= 50 }
	end


end