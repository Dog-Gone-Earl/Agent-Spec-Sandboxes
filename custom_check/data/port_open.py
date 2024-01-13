import socket, time

port_nums = []

# Check for ports that are open, get port value, and append port value to list
for i in range(0, 65535):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex(("127.0.0.1", i))
    if result == 0:
        port_val = sock.getpeername()[1]
        port_nums.append(port_val)
    else:
        port_closed = 0
sock.close()

# the following try/except block will make the custom check compatible with any Agent version
try:
    # first, try to import the base class from new versions of the Agent...
    from datadog_checks.base import AgentCheck
except ImportError:
    # ...if the above failed, the check is running in Agent version < 6.6.0
    from checks import AgentCheck

# content of the special variable __version__ will be shown in the Agent status page
__version__ = "1.0.0"

# iterate through list to submit metric `1` value for open ports found
class OpenPorts(AgentCheck):
    def check(self, instance):
        for k in range(0, len(port_nums)):
            self.gauge("port.open", 1, tags=["port:" f"{port_nums[k]}"])
         #   time.sleep(0.5)
