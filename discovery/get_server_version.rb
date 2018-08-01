#!/usr/bin/ruby

require 'pg'

begin
    print  "Please enter datbasae username:"
    user = gets.chomp
    print "Please enter user password"
    password = gets.chomp
    con = PG.connect :hostaddr => '192.168.1.254', :dbname => 'musiccabinet', :user => "#{user}",
        :password => "#{password}"

    rs = con.exec 'SHOW server_version'
    puts "#{rs}"
    user = con.user
    db_name = con.db
    pswd = con.pass


rescue PG::Error => e

    puts e.message

ensure

    con.close if con

end
