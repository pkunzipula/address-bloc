require_relative '../models/address_book'

RSpec.describe AddressBook do
    describe "attributes" do
        it "responds to entries" do
            book = AddressBook.new
            expect(book).to respond_to(:entries)
        end
        
        it "initializes entries as an array" do
            book = AddressBook.new
            expect(book.entries).to be_an(Array)
        end
        
        it "initializes entries as empty" do
            book = AddressBook.new
            expect(book.entries.length).to eq(0)
        end
    end
    
    describe "#add_entry" do
        it "adds only one entry to the address book" do
            book = AddressBook.new
            book.add_entry('Ada Lovelace', '090-454-2527', 'augusta.king@lovelace.com')
            
            expect(book.entries.length).to eq(1)
        end
        
        it "adds the correct information to entries" do
            book = AddressBook.new
            book.add_entry('Ada Lovelace', '090-454-2527', 'augusta.king@lovelace.com')
            new_entry = book.entries[0]
            
            expect(new_entry.name).to eq('Ada Lovelace')
            expect(new_entry.phone_number).to eq('090-454-2527')
            expect(new_entry.email).to eq('augusta.king@lovelace.com')
        end
    end
    
    describe "#remove_entry" do
        it "removes only one entry from the address book" do
            book = AddressBook.new
            book.add_entry('Miguel Faradoo', '098-489-1444', 'mcpeepants@geemail.com')
            
            name = "Ada Lovelace"
            phone_number = "090-454-2527"
            email = "augusta.king@lovelace.com"
            
            book.add_entry(name, phone_number, email)

            expect(book.entries.length).to eq(2)
            book.remove_entry(name, phone_number, email)
            expect(book.entries.length).to eq(1)
            expect(book.entries.first.name).to eq("Miguel Faradoo")
        end
    end
end