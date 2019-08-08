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
# 0.01  sf    1Aug19  Created
#-------------------------------------------------------------------------------
# TODO
#
#-------------------------------------------------------------------------------
require 'rubygems'
require 'fileutils' # catname   chmod   compare   copy   install   FileUtils.mkdir_p   move   safe_unlink   syscopy
require 'date'   # DateTime::now
require 'pp'

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
#AT+SAPBR=3,1,"Contype","GPRS"		 # 3=Set bearer parameters, Contype=Internet connection type
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
AT_HANDSHAKE          = 'AT'
AT_SIGNAL_STRENGTH    = 'AT+CSQ'
AT_VERBOSE_ERRORS_ON  = 'AT+CMEE=2'
AT_BATTERY_STATE      = 'AT+CBC'
AT_HARDWARE_VS        = 'ATI'
AT_IMEI_NUMBER        = 'AT+CCID'
AT_WHICH_NETWORK      = 'AT+COPS?'
AT_AVAILABLE_CREDIT   = ''
AT_AVAILABLE_DATA     = ''

AT_IS_GNS_POWER_ON      = 'AT+CGNSPWR?'
AT_POWER_ON_GNS_MODULE  = 'AT+CGNSPWR=1'
AT_POWER_OFF_GNS_MODULE = 'AT+CGNSPWR=0'
AT_SET_BEARER_PROFILE   = 'AT+SAPBR=3,1,"Contype","GPRS"'
AT_OPEN_BEARER_PROFILE  = 'AT+SAPBR=1,1'
AT_CLOSE_BEARER_PROFILE = 'AT+SAPBR=0,1'
AT_LOCATE_WITH_GPS      = 'AT+CGNSINF'
AT_LOCATE_W_GSM_MASTS   = 'AT+CIPGSMLOC=1,1'
AT_IP_ADDRESS           = 'AT+SAPBR=2,1'
AT_DEFINE_NMEA_SENTENCE = 'AT+CGNSSEQ=RMC'      #< check if needed - GPS format spec?
AT_ = ''

# +CGNSINF: 1,1,20170304024139.000,51.111583,-2.457220,91.400,1.57,320.5,1,,1.7,1.9,0.9,,9,5,,,30,,

## format
#See GPS doc for sequence - needs honing!
#+CGNSINF:
#1,                  <GNSS run status>,
#1,                  <Fix status>,
#2017 02 19 0146 04.000, <UTC date & Time>,
#51.111462,          <Latitude>,
#-2.457305,          <Longitude>,
#99.300,             <MSL Altitude>,
#0.35,               <Speed Over Ground>,        ??
#212.6,              <Course Over Ground>,       ??
#1,                  <Fix Mode>,
#,                   <Reserved1>,
#1.6,                <HDOP>,
#1.9,                <PDOP>,
#0.9,                <VDOP>,
#,                   <Reserved2>,
#13,                 <GNSS Satellites in View>,
#6,                  <GNSS Satellites Used>,
#,                   <GLONASS Satellites Used>,
#,                   <Reserved3>,
#31,                 <C/N0 max>,
#,                   <HPA>, 
#                    <VPA>
#                    
## Date/Time: yyyyMMddhh mmss.sss	1980 01 06 00  2747.000

SEQUENCE_SYSTEM_CHECK = [AT_HANDSHAKE,
                         AT_VERBOSE_ERRORS_ON,
                         AT_HARDWARE_VS,
                         AT_IS_GNS_POWER_ON,
                         AT_SIGNAL_STRENGTH,
                         AT_BATTERY_STATE,
                         AT_IMEI_NUMBER,
                         AT_WHICH_NETWORK]

def process_system_check(transactions_in_sequence)
  info = {}
  

  transactions_in_sequence.each { |command_response|
    
    #split into lines - remove \r \n etc
    response_set = command_response.split(/$/).collect{|l| l.strip}
    
    puts "--------------------------\\\n#{command_response}#{pp response_set}\n--------------------------/"
    
    case response_set[0]
    #when AT_HANDSHAKE
    #  info[:handshake] = response_set[1]
    #  
    #when AT_VERBOSE_ERRORS_ON
    #  info[:] = response_set[1]
      
    when AT_HARDWARE_VS
      info[:hw_version] = response_set[1]
      
    when AT_IS_GNS_POWER_ON
      info[:power] = response_set[1].sub('+CGNSPWR: ','')
      
    when AT_SIGNAL_STRENGTH
      info[:signal_strength] = response_set[1].sub('+CSQ: ','')
      
    when AT_BATTERY_STATE
      response_set[1].sub!('+CBC: ','')
      info[:is_charging] = response_set[1].split(',')[0]
      info[:percent] = response_set[1].split(',')[1]
      info[:mili_volts] = response_set[1].split(',')[2]
      
    when AT_IMEI_NUMBER
      info[:imei] = response_set[1]
      
    when AT_WHICH_NETWORK
      response_set[1] =~ /\"(.*?)\"/      #+COPS: 0,0,"O2"
      info[:network] = $1
      
    end
  }
  
  pp info
  
  info                       
end


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

transaction_array= []

while (true)

  puts "\\mainloop start - - - - - "
  
  SEQUENCE_SYSTEM_CHECK.each { |command|
    
    reply = send_command serialport,command

    transaction_array << reply

    puts ">------------------------------------->\n#{reply}< - - <"
    
  }
      
  #puts "snooozing . . . "  
  #
  #sleep(4)
  #
  #puts "slept. . . "  

  pp transaction_array
  
  process_system_check transaction_array
  
  break

end

exit


# OUTPUT LOOKS LIKE
#
#pi@rpi_T:~/scripts $ ./serial_tests_tty2FONA_v0.1.rb 
#Serial test running 2019-08-07T09:43:26+00:00
#\mainloop start - - - - - 
#--------------------------\
#w:'AT' r:1 <
#wrote: 4bytes
#r:0:
#r:<
#r:9:
#r:AT
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT
#OK
#< - - <
#--------------------------\
#w:'AT+CMEE=2' r:1 <
#wrote: 11bytes
#r:0:
#r:<
#r:16:
#r:AT+CMEE=2
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+CMEE=2
#OK
#< - - <
#--------------------------\
#w:'ATI' r:1 <
#wrote: 5bytes
#r:0:
#r:<
#r:27:
#r:ATI
#SIM808 R14.18
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#ATI
#SIM808 R14.18
#
#OK
#< - - <
#--------------------------\
#w:'AT+CGNSPWR?' r:1 <
#wrote: 13bytes
#r:0:
#r:<
#r:33:
#r:AT+CGNSPWR?
#+CGNSPWR: 0
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+CGNSPWR?
#+CGNSPWR: 0
#
#OK
#< - - <
#--------------------------\
#w:'AT+CSQ' r:1 <
#wrote: 8bytes
#r:0:
#r:<
#r:26:
#r:AT+CSQ
#+CSQ: 5,0
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+CSQ
#+CSQ: 5,0
#
#OK
#< - - <
#--------------------------\
#w:'AT+CBC' r:1 <
#wrote: 8bytes
#r:0:
#r:<
#r:32:
#r:AT+CBC
#+CBC: 0,97,4177
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+CBC
#+CBC: 0,97,4177
#
#OK
#< - - <
#--------------------------\
#w:'AT+CCID' r:1 <
#wrote: 9bytes
#r:0:
#r:<
#r:38:
#r:AT+CCID
#8944****************
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+CCID
#8944****************
#
#OK
#< - - <
#--------------------------\
#w:'AT+COPS?' r:1 <
#wrote: 10bytes
#r:0:
#r:<
#r:40:
#r:AT+COPS?
#+COPS: 0,0,"T-Mobile"
#
#OK
#<
#vr:Fixnum - rx
#vr:Fixnum - tx
#--------------------------/
#>------------------------------------->
#AT+COPS?
#+COPS: 0,0,"T-Mobile"
#
#OK
#< - - <
#["AT\r\r\nOK\r\n",
# "AT+CMEE=2\r\r\nOK\r\n",
# "ATI\r\r\nSIM808 R14.18\r\n\r\nOK\r\n",
# "AT+CGNSPWR?\r\r\n+CGNSPWR: 0\r\n\r\nOK\r\n",
# "AT+CSQ\r\r\n+CSQ: 5,0\r\n\r\nOK\r\n",
# "AT+CBC\r\r\n+CBC: 0,97,4177\r\n\r\nOK\r\n",
# "AT+CCID\r\r\n8944****************\r\n\r\nOK\r\n",
# "AT+COPS?\r\r\n+COPS: 0,0,\"T-Mobile\"\r\n\r\nOK\r\n"]
#["AT", "OK", ""]
#--------------------------\
#AT
#OK
#["AT", "OK", ""]
#--------------------------/
#["AT+CMEE=2", "OK", ""]
#--------------------------\
#AT+CMEE=2
#OK
#["AT+CMEE=2", "OK", ""]
#--------------------------/
#["ATI", "SIM808 R14.18", "", "OK", ""]
#--------------------------\
#ATI
#SIM808 R14.18
#
#OK
#["ATI", "SIM808 R14.18", "", "OK", ""]
#--------------------------/
#["AT+CGNSPWR?", "+CGNSPWR: 0", "", "OK", ""]
#--------------------------\
#AT+CGNSPWR?
#+CGNSPWR: 0
#
#OK
#["AT+CGNSPWR?", "+CGNSPWR: 0", "", "OK", ""]
#--------------------------/
#["AT+CSQ", "+CSQ: 5,0", "", "OK", ""]
#--------------------------\
#AT+CSQ
#+CSQ: 5,0
#
#OK
#["AT+CSQ", "+CSQ: 5,0", "", "OK", ""]
#--------------------------/
#["AT+CBC", "+CBC: 0,97,4177", "", "OK", ""]
#--------------------------\
#AT+CBC
#+CBC: 0,97,4177
#
#OK
#["AT+CBC", "+CBC: 0,97,4177", "", "OK", ""]
#--------------------------/
#["AT+CCID", "8944****************", "", "OK", ""]
#--------------------------\
#AT+CCID
#8944****************
#
#OK
#["AT+CCID", "8944****************", "", "OK", ""]
#--------------------------/
#["AT+COPS?", "+COPS: 0,0,\"T-Mobile\"", "", "OK", ""]
#--------------------------\
#AT+COPS?
#+COPS: 0,0,"T-Mobile"
#
#OK
#["AT+COPS?", "+COPS: 0,0,\"T-Mobile\"", "", "OK", ""]
#--------------------------/
#{:hw_version=>"SIM808 R14.18",
# :power=>"0",
# :signal_strength=>"5,0",
# :is_charging=>"0",
# :percent=>"97",
# :mili_volts=>"4177",         
# :imei=>"8944****************",
# :network=>"T-Mobile"}
