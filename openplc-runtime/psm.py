import psm
import time
import socket

HOST = "172.31.19.88"  # IP DA PLANTA
PORT_ACTUATOR = 1515
PORT_SENSOR = 1516

control_var = 0  # Variável de saída do processo 
process_var = 0  # Variável de entrada do processo

actuator_s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sensor_s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

def hardware_init():
    global actuator_s
    global sensor_s
    try:
        actuator_s.connect((HOST, PORT_ACTUATOR))
        sensor_s.connect((HOST, PORT_SENSOR))
        psm.start()
    except Exception as e:
        print(f"Error during hardware initialization: {e}")
        raise

def update_inputs():
    global sensor_s
    global process_var
    try:
        data = sensor_s.recv(1024)
        if data:
            process_var = float(data.decode())  # Conversão para float
            print(f"Received process_var: {process_var}")
            scaled_value = int(round(process_var)) 
            psm.set_var("IW0", scaled_value)
    except Exception as e:
        print(f"Error updating inputs: {e}")

def update_outputs():
    global control_var
    try:
        control_var = psm.get_var("QW1")
        actuator_s.sendall(str(control_var).encode())
    except Exception as e:
        print(f"Error updating outputs: {e}")

if __name__ == "__main__":
    hardware_init()
    while not psm.should_quit():
        update_outputs()
        update_inputs()
        time.sleep(0.05)
    psm.stop()