#!/usr/bin/ruby

require 'pg'

begin

    con = PG.connect :hostaddr => '192.168.1.254', :dbname => 'musiccabinet', :user => 'postgres',
        :password => ''

    user = con.user
    db_name = con.db
    pswd = con.pass

    puts "User: #{user}"
    puts "Database name: #{db_name}"
    puts "Password: #{pswd}"

rescue PG::Error => e

    puts e.message

ensure

    con.close if con

end
