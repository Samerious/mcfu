#!/usr/bin/ruby

require 'pg'

begin

  print  "Please enter datbasae username: "
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
              if Dir.exist?("#{rowpathlinux}") != true then
              con.exec "delete from library.directory_import where parent_id = #{rowid2}"
              con.exec "delete from library.fileheader where file_id=(select file_id from library.file where id = #{rowid2})"
              con.exec "delete from library.file where directory_id = #{rowid2}"
              con.exec "delete from library.file_import where directory_id = #{rowid2}"
              con.exec "delete from library.directory where id = #{rowid2}"
              puts "#{rowid2}"
              #puts "#{rowpathlinux}"
              end
            end

        rescue PG::Error => e

            puts e.message

        ensure

            rs.clear if rs
            con.close if con

        end
