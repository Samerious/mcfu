#!/usr/bin/ruby

require 'pg'

begin

    con = PG.connect :hostaddr => '192.168.1.254', :dbname => 'musiccabinet', :user => 'postgres',
        :password => ''


            rs = con.exec 'SELECT * FROM library.directory;'

            rs.each do |rowid|
              rowid2 = "%s" % [ rowid['id'] ]
              rowpath = "%s" % [ rowid['path'] ]
              rowpath = rowpath.sub('D:', '/media/mikebullshit')
              rowpath = rowpath.gsub('\\', '/')
              rowpath = rowpath + '/'
              if Dir.exists?("#{rowpath}") == false
                puts "#{rowid2}"
                puts "#{rowpath}"
              end
            end

        rescue PG::Error => e

            puts e.message

        ensure

            rs.clear if rs
            con.close if con

        end
