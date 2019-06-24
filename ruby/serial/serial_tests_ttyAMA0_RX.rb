#!/usr/bin/env ruby

#-------------------------------------------------------------------------------
#  Filename: serial_tests.rb
#
#= Description - timestamp into a file until flat - low tech battery test
#
#
#-------------------------------------------------------------------------------
#  Vs   Auth  Date    Comments
#-------------------------------------------------------------------------------
# 0.01  sf    24Jun19 Created
#-------------------------------------------------------------------------------
# TODO
#
#-------------------------------------------------------------------------------
require 'rubygems'
require 'fileutils' # catname   chmod   compare   copy   install   FileUtils.mkdir_p   move   safe_unlink   syscopy
require 'date'   # DateTime::now


# require 'serialport'
# http://ruby-serialport.rubyforge.org/
# gem install ruby-serialport
# failed to build < < 

#  https://github.com/hybridgroup/rubyserial
require 'rubyserial'

begin
#serialport = Serial.new '/dev/ttyAMA0' # Defaults to 9600 baud, 8 data bits, and no parity
#serialport = Serial.new '/dev/ttyAMA0', 115200      # h/w serial port
serialport = Serial.new '/dev/ttyUSB0', 115200       # USB > h/w serial port
#serialport = Serial.new '/dev/ttyAMA0', 19200, 8, :even

rescue => e
    puts "\n================== FAULT ======================== #{Time.now}"  
    puts e.message
    puts e.backtrace
    puts "\n================== FAULT ======================== "
    pp e
    puts "\n================== FAULT ======================== #{Time.now}" 
end


puts "Serial test running #{DateTime.now}"

counter = 0
while (true)

  begin
    
    # = = = = = read return data
    puts "= = = = reading: #{counter} <"
    
    data = serialport.read(10000)         # read 10000 bytes - go large or go home!!    
    puts "READ: #{data} :#{data.to_s.size}:"
    
    if data.to_s.strip == 'AT'
      reply = "SERIAL PORT RECEIVING - 'KINA"

      # write - reply
      counter += 1
      puts "=WRITING. . ."
      bytes = serialport.write("#{reply} - #{counter}\r\n")
      puts "=WRITTEN: #{bytes} - #{DateTime.now}"

    end  
    puts "- - - - - - done reading\n\n\n\n\n\n"
  
    sleep(1)


  rescue => e
    puts "\n================== FAULT ======================== #{Time.now}"  
    puts e.message
    puts e.backtrace
    puts "\n================== FAULT ======================== "
    pp e
    puts "\n================== FAULT ======================== #{Time.now}"  
  end

end
  


exit
