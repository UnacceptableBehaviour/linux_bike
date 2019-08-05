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
# 0.01  sf            Created
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
serialport = Serial.new '/dev/ttyAMA0', 115200      # h/w serial port
#serialport = Serial.new '/dev/ttyUSB0', 115200       # USB > h/w serial port
#serialport = Serial.new '/dev/ttyAMA0', 19200, 8, :even

rescue => e
    puts "\n================== FAULT ======================== #{Time.now}"  
    puts e.message
    puts e.backtrace
    puts "\n================== FAULT ======================== "
    pp e
    puts "\n================== FAULT ======================== #{Time.now}" 
end

## - - - - - - - - - - - - - - - - - - - - - - - -
## COMMAND           RESPONSE(S)
## - - - - - - - - - - - - -
## AT handshake
#AT
#                    OK
#
## - - - - - - - - - - - - -
## H/W version?
#ATI		
#                    SIM808 R14.18
#                    OK
#                    
## - - - - - - - - - - - - -
## VERBOSE ERRORS MODE = ON
#AT+CMEE=2				
#                    OK
#
## - - - - - - - - - - - - -
## IMEI NUMBER?
#AT+CCID
#                    9075XXXXXXXXXXXXXXXX
#                    OK
#
## - - - - - - - - - - - - -
## Network?
#AT+COPS?
#                    +COPS: 0,0,"O2"
#                    OK
#
## - - - - - - - - - - - - -
## SIGNAL Strength?
#AT+CSQ					
#                    +CSQ: 18,0          # 1ST NO IS DB SHOULD BE ABOVE 5 - WHAT THE RANGE HERE?
#                    OK
#
## - - - - - - - - - - - - -
## Battery? Lipo state:
#AT+CBC					# battery charge - power check
#                    +CBC: 0,88,4111	# 0=not charging, 88% charge remaining, 4111mV (4.1V)
#
#
## - - - - - - - - - - - - -
## GNS module POWER detect & control
#AT+CGNSPWR=?			# Responds to what parameters?
#                    +CGNSPWR: (0-1)
#                    \r\n
#                    OK
#AT+CGNSPWR?			# Is GNS module power ON?
#                    +CGNSPWR: 0 # 0=OFF 1=ON
#                    \r\n
#                    OK
#AT+CGNSPWR=1			# POWER ON
#                    OK
#AT+CGNSPWR=0			# POWER OFF
#                    OK
#
#
## - - - - - - - - - - - - -
## LOCATION - from GSM Masts
#AT                                      # say hello
#                    OK
#AT+SAPBR=3,1,"Contype","GPRS"           # set connection type (set bearer profile parameters)
#                    OK
#AT+SAPBR=1,1                            # activate bearer context
#                    OK                  # note: the red light should start blinking faster
#AT+CIPGSMLOC=1,1                        # get location                        
#                    +CIPGSMLOC: 0,-2.445663,51.117062,2017/03/28,08:40:12
#                    \r\n                # reverse long,lat to enter in gmaps
#                    OK
#AT+SAPBR=0,1                            # de-activate bearer context
#                    OK                  # note: the red light should start blinking slower
#                    
## - - - - - - - - - - - - -
## In context of GPRS Connection
## Get IP Address
#AT+SAPBR=2,1
#                    +SAPBR: 1,1,"10.161.24.61"
#                    \r\n
#                    OK
#
## - - - - - - - - - - - - -
## LOCATION - from GPS 
#
#
#                                        # SAPBR - Bearer profile settings 
#AT+SAPBR=3,1,"Contype","GPRS"		# 3=Set bearer parameters, Contype=Internet connection type
#                    OK                  # Value=GPRS
#
#AT+SAPBR=1,1                            # Open bearer - profile 1
#                    OK
#AT+CGNSPWR=1                            # power up - power went from 3mA to 80mA!!!
#                    OK
#AT+CGNSPWR?                             # check? is the GPS module ON?
#+CGNSPWR: 0                             # NO! - That might be a problem!!
#+CGNSPWR: 1                             # YES - Cool bananas
#                    +CGNSPWR: 1 # 0=OFF 1=ON
#                    \r\n
#                    OK
#
#AT+CGNSINF                              # we have a lock!!!!! Power at 105mA
#                    +CGNSINF: 1,1,20170304024139.000,51.111583,-2.457220,91.400,1.57,320.5,1,,1.7,1.9,0.9,,9,5,,,30,,
#
#AT+SAPBR=0,1                            # de-activate bearer context
#                    OK                  # note: the red light should start blinking slower
#
#
#                    
AT_HANDSHAKE = ['AT','OK']
# - - - - - - - - - - - - - - - - - - - - - - - -
# take array containing command sequence
# - - - - - - - - - - - - - - - - - - - - - - - -
MAX_TX_RETRIES = 5
MAX_RX_RETRIES = 8
TIME_OUT    = 0.5   # seconds
def send_command(port, command)
  attemps = 0
  data    = ''
  valid_response = false
  
  puts "--------------------------\\"
  
  while attemps < MAX_TX_RETRIES
    
    data = ''     # clear rx buffer
    
    begin
    
      # send command
      attemps += 1
      
      command_string = "#{command}\r\n"
      
      puts "w:'#{command}' r:#{attemps} <"
      bytes = port.write(command_string) #("#{attemps}")
      puts "wrote: #{bytes}bytes" # - #{DateTime.now}"
    
      rx_attempts = 0
      
      while rx_attempts < MAX_RX_RETRIES
        
        rx_attempts += 1
        
        # = = = = = read return data            # read 10000 bytes - go large or go home!!
        data = data + port.read(10000)          # sometime the read occurs mid reply - concatenate
                                                # before checking - avoid unnecessary retry
        puts "r:#{data.to_s.size}:\nr:#{data}<"
        
        if data.to_s.size > 0
          
          valid_response = (data =~ /OK/ || data =~ /ERROR/)
          
          puts "vr:#{valid_response.class} - rx"
          
          break if data =~ /OK/ || data =~ /ERROR/    # all transaction finish with OK or ERROR
          
        end
        
        sleep(TIME_OUT)  
      
      end

    rescue => e
      puts "\n================== FAULT ======================== #{Time.now}"  
      puts e.message
      puts e.backtrace
      puts "\n================== FAULT ======================== "
      pp e
      puts "\n================== FAULT ======================== #{Time.now}"  
    end
  
    puts "vr:#{valid_response.class} - tx"
    
    break if valid_response # we have a payload
    
  end
  
  puts "--------------------------/"
  
  data
end



puts "Serial test running #{DateTime.now}"

counter = 0
while (true)

  puts "\\mainloop start - - - - - "
  
  reply = send_command serialport,'AT'

  puts ">------------------------------------->\n#{reply}< - - <"

  puts "snooozing . . . "  

  sleep(4)
  
  puts "slept. . . "  

end
  


exit