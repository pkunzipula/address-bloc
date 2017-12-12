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
        puts "6 - Exit"
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
    
    def search_entries
    end
    
    def read_csv
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
            when "e"
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