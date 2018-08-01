#!/usr/bin/ruby

require 'pg'

begin

  print  "Please enter database username: "
  user = gets.chomp
  print "Please entur user password: "
  password = gets.chomp
  con = PG.connect :hostaddr => '192.168.1.254', :dbname => 'musiccabinet', :user => "#{user}",
      :password => "#{password}"


            rs = con.exec 'select * FROM library.directory'

            rs.each do |rowid|
              rowid2 = "%s" % [ rowid['id'] ]
              rowpath = "%s" % [ rowid['path'] ]
              rowpathlinux = rowpath.sub('D:', '/media/mikebullshit')
              rowpathlinux = rowpathlinux.gsub('\\', '/')
              rowpathlinux = rowpathlinux + '/'
              if Dir.exist?("#{rowpath}") != true then
              rs = con.exec "select * from library.directory_import where parent_id = #{rowid2}"
              rs = con.exec "select * from library.directory where parent_id = #{rowid2}"
              rs = con.exec "select * from library.file where directory_id = #{rowid2}"
              rs = con.exec "select * from library.file_import where directory_id = #{rowid2}"
              rs = con.exec "select * from library.directory where id = #{rowid2}"
              puts "#{rowid}"
              #puts "#{rowpathlinux}"
              end
            end

        rescue PG::Error => e

            puts e.message

        ensure

            rs.clear if rs
            con.close if con

        end
