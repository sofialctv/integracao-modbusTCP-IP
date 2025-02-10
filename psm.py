#                  - OpenPLC Python SubModule (PSM) -
# 
# PSM is the bridge connecting OpenPLC core to Python programs. PSM allows
# you to directly interface OpenPLC IO using Python and even write drivers 
# for expansion boards using just regular Python.
#
# PSM API is quite simple and just has a few functions. When writing your
# own programs, avoid touching on the "__main__" function as this regulates
# how PSM works on the PLC cycle. You can write your own hardware initialization
# code on hardware_init(), and your IO handling code on update_inputs() and
# update_outputs()
#
# To manipulate IOs, just use PSM calls psm.get_var([location name]) to read
# an OpenPLC location and psm.set_var([location name], [value]) to write to
# an OpenPLC location. For example:
#     psm.get_var("QX0.0")
# will read the value of %QX0.0. Also:
#     psm.set_var("IX0.0", True)
# will set %IX0.0 to true.
#
# Below you will find a simple example that uses PSM to switch OpenPLC's
# first digital input (%IX0.0) every second. Also, if the first digital
# output (%QX0.0) is true, PSM will display "QX0.0 is true" on OpenPLC's
# dashboard. Feel free to reuse this skeleton to write whatever you want.

#import all your libraries here
import psm
import time
import socket

#global variables
host = "172.31.19.88"              # Host IP Privado da Planta
port_atuador = 1515
port_sensor = 1516

var_controle = 0                   # Variável Output 
var_processo = 0                   # Variável Input

atuador_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sensor_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

def hardware_init():
    
    global atuador_socket
    global sensor_socket
    conn_atu = atuador_socket.connect((host, port_atuador))
    conn_sen = sensor_socket.connect((host, port_sensor))
    psm.start()

    #Insert your hardware initialization code in here
    client_socket_sensor.connect(host, port_sensor))
    psm.start()
    client_socket_sensor.connect(host, port_atuador))
    psm.start()

def update_inputs():
    global sensor_socket
    global var_processo
    data = sensor_socket.recv(1024)
    var_processo = data.decode()
    
    psm.set_var("IW0", int(var_processo))

def update_outputs():
    global var_controle
    var_controle = psm.get_var("QW0")
    atuador_socket.sendall(str(var_controle).encode())

if __name__ == "__main__":
    hardware_init()
    while (not psm.should_quit()):
        update_outputs()
        update_inputs()
        time.sleep(0.1)
    psm.stop()