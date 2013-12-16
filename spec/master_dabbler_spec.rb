require 'master_dabbler'

describe AulDabbler do
	it "produces a inventory table" do
		expect(inventory.length).to eq("k") 
	end

	it "applies methods to modify the inventory table" do
		expect(inventory.used.length).to eq("k")
		expect(inventory.used.no_comments.length).to eq("k")
		expect(inventory.no_comments.length).to eq("k")
		expect(inventory.with_comments.length).to eq("k")
		expect(inventory.used.with_comments.length).to eq("k")
	end
end
