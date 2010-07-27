InstaPush
=========

Add URLs to Instapaper.

Installation
------------

    gem install instapush

Usage
-----

    # Connect to Instapaper and add "http://kimjoar.net" to the user "kjbekkelund@gmail.com"
    # The password is optional and can be omitted when you don't have a password
    # on Instapaper.
    InstaPush.connect "kjbekkelund@gmail.com", "password" do
      add "http://kimjoar.net"
    end
    
    # Similarly you can use:
    conn = InstaPush.connect "kjbekkelund@gmail.com", "password"
    conn.add "http://kimjoar.net"
    
    # Just authenticate with Instapaper. Calling this before adding pages is 
    # not necessary.
    InstaPush.authenticate "kjbekkelund@gmail.com", "password"
