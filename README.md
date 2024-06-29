# basic-network-scanner
chmod +x network_scanner.sh
./network_scanner.sh 192.168.1.0/24
Explanation
Check Subnet Input: The script checks if a subnet is provided as an argument. If not, it displays usage information and exits.
Convert IP to Integer: The ip_to_int function converts an IP address to an integer for easy manipulation.
Convert Integer to IP: The int_to_ip function converts an integer back to an IP address.
Calculate IP Range: The script calculates the start and end IP addresses for the given subnet.
Ping IP Addresses: It iterates over each IP address in the range, pings it once, and checks if the host is up or down based on the ping response.
