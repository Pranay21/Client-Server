#Name: Pranaya Bhat
#ID: 1001408965


from socket import *                                                                    #import socket module
import thread                                                                           #import thread module
import sys
import logging

LOG_FILENAME = 'log.txt'                                                                #Generating log report 
logging.basicConfig(filename=LOG_FILENAME,level=logging.DEBUG)
logging.debug('*****Server Side*****' )


def HttpRequest(connectionSocket,addr):                                                 #function to handle individual client requests     
    try:
        message =  connectionSocket.recv(1024)
        print "Message is :"+ message                                                  #http request message printed
        print 'connected from',addr
        print 'Host name : Localhost'                                                   #printing name of client
        print 'socket family: AF_INET'                                                  #printing socket family
        print 'Socket Type: SOCK_STREAM'                                                #printing socket type
        print 'protocol : TCP'                                                          #printing the type of protocol 
        if message.split()[1] == "/":                                                   #Serving request from a browser	
			connectionSocket.send('HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n Connection Established')
                                                       		 #get filename from the request
        else:
			filename = message.split()[1] 
        f = open(filename[1:])
        outputdata = f.read()                                                            #Retrive file contents to send to Client
                                                                                         
        connectionSocket.send('HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n'+outputdata)
        logging.debug('HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n'+outputdata )  #Writes to the log file
        
        connectionSocket.close()                                                         #Close the client connection 
    except IOError:                                                                      #if file not found send apporiate message
                                                                                         #Send response message for file not found
        print "404 FILE NOT FOUND"
        connectionSocket.send('HTTP/1.1 404 File Not Found\r\n')
        connectionSocket.send('Content-Type: text/html\r\n\r\n<html><h1>404 File Not Found</h1></html>')
        logging.debug('HTTP/1.1 404 File Not Found\r\n' )                                #Writes the log file
        
                                                                                        #Close client socket
        connectionSocket.close()
                                     
def main(argv):
    serverSocket = socket(AF_INET, SOCK_STREAM)                                         #Create Socket object for TCP connection
                                                                                        #Prepare a sever socket
    host=''
    port= int(argv)
    serverSocket.bind((host,port))
    print "Socket number Selected is",serverSocket.getsockname()[1]                     #Disply the listening Port number
    serverSocket.listen(10)
    while True:
                                                                                        #Establish the connection
        print 'Ready to serve...'
        connectionSocket, addr =  serverSocket.accept()
        thread.start_new_thread(HttpRequest, (connectionSocket,addr))   

                        
if __name__=="__main__":
        main(8090)                      

#References:
#https://docs.python.org/2/library/thread.html
#https://www.tutorialspoint.com/python/python_multithreading.htm
#http://www.bogotobogo.com/python/python_network_programming_server_client.php
#http://www.tutorialspoint.com/python/python_networking.htm
#https://pythonspot.com/en/python-network-sockets-programming-tutorial/