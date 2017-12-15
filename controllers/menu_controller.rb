require_relative '../models/address_book'

class MenuController
    attr_reader :address_book
    
    def initialize
        @address_book = AddressBook.new
    end
    
    def main_menu
        puts "Main Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entries from a CSV"
        puts "5 - View Entry Number n"
        puts "6 - Pretend the Russians are coming and WIPE YOUR DRIVE!"
        puts "7 - Exit"
        print "Enter your selection: "
    
        selection = gets.to_i
        
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                create_entry
                main_menu
            when 3
                system "clear"
                search_entries
                main_menu
            when 4
                system "clear"
                read_csv
                main_menu
            when 5
                system "clear"
                entry_n_submenu
                main_menu
            when 6
                system "clear"
                wipe_the_drive
                main_menu
            when 7
                puts "Good-bye!"
                exit(0)
            else
                system "clear"
                puts "Sorry, that is not a valid input"
                main_menu
        end
    end
    
    def view_all_entries
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s
            
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end

    def entry_n_submenu
       puts "Which fool in your little black book of fools do you wish to pity today?"
       selection = gets.chomp.to_i
       if selection < @address_book.entries.count
           puts @address_book.entries[selection]
           puts "A fine choice indeed, sir! If you ask me, I would pity #{address_book.entries[selection].name} for as long as it takes. Now press Return to return to the main menu."
           gets.chomp
           system "clear"
       else
           puts "#{selection} is not within our range. Please do try again."
           entry_n_submenu
       end
    end
    
    def wipe_the_drive
        puts "You want to Delete EVERYTHING?\nThis action is irreversible and irresponsible.\nIs that what you want them to say about you at your next Quinceañera?"
        puts "n - No, you're probably right. Delete nothing and take me back."
        puts "y - You're worse than Clippy from MS Office. Do it. NOW!"
        
        selection = gets.chomp
        
        case selection
            when "n"
                system "clear"
                main_menu
            when "y"
                address_book.entries.clear
                puts "The dishes are done, man!\nPress Return to get back to the main menu"
                gets.chomp
                system "clear"
            else
                system "clear"
                puts "Invalid response. Try again."
                wipe_the_drive
        end
    end
    
    def create_entry
        system "clear"
        puts "New AddressBloc Entry"
        print "Name: "
        name = gets.chomp
        print "Phone: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
        
        address_book.add_entry(name, phone, email)
        
        system "clear"
        puts "New entry created"
    end
    
    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end
    
    def search_entries
        print "Search by name: "
        name = gets.chomp
        
        match = address_book.binary_search(name)
        system "clear"
        
        if match
            puts match.to_s
            search_submenu(match)
        else
            puts "No match found for #{name}"
        end
    end
    
    def search_submenu(entry)
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        
        selection = gets.chomp
        
        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                puts entry.to_s
                search_submenu(entry)
        end
    end
    
    def edit_entry(entry)
        print "Updated name: "
        name = gets.chomp
        print "Updated phone number: "
        phone_number = gets.chomp
        print "Updated email: "
        email = gets.chomp
        
        entry.name = name if !name.empty?
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"
        puts "Updated entry: "
        puts entry
    end
    
    def read_csv
        print "Enter CSV file to import: "
        file_name = gets.chomp
        
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
            read_csv
        end
    end
    
    def entry_submenu(entry)
        puts "n - Next entry"
        puts "d - Delete entry"
        puts "e - Edit this entry"
        puts "m - Return to main menu"
        
        selection = gets.chomp
        
        case selection
            when "n"
            when "d"
                delete_entry(entry)
            when "e"
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input, fool"
                entry_submenu(entry)
        end
    end
end