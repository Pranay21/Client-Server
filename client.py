#Name: Pranaya Bhat
#ID: 1001408965


import socket                                               # Import socket module
import sys
import time
import logging

LOG_FILENAME = 'log.txt'                                                                #Generating log report 
logging.basicConfig(filename=LOG_FILENAME,level=logging.DEBUG)

def main(hostid,portno,filepath):
    s = socket.socket()                                     # Create a socket object
    host = hostid                                           # Get local machine name
    port = int(portno)                                      # Reserve a port for your service.

    s.connect((host, port))
    s.send("GET "+filepath)

    data = s.recv(4096)
      
    print data
    print 'Host name of the server: Localhost'
    print 'Socket family: AF_INET'
    print 'Socket type: SOCK_STREAM' 
    logging.debug('*****ClientSide*****')
    logging.debug('Host name of the server: Localhost')
    logging.debug('Socket family: AF_INET')
    logging.debug('Socket type: SOCK_STREAM') 
    logging.debug('------------------------------------------------------')


    s.close()                                               # Close the socket when done

if __name__=="__main__":
	filename=raw_input("Enter the filename in the format</filename.extension> \n")
        main("localhost",8090,filename)            

#References:
#https://docs.python.org/2/library/thread.html
#https://www.tutorialspoint.com/python/python_multithreading.htm
#http://www.bogotobogo.com/python/python_network_programming_server_client.php
#http://www.tutorialspoint.com/python/python_networking.htm
#https://pythonspot.com/en/python-network-sockets-programming-tutorial/