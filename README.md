# Domain_Too_IP_Address
This tool takes a domain name and gathers its ip address.

### How to Use the Script
1. Download the script
```sh
git clone https://github.com/Squirrel-404/Domain_Too_IP_Address.git
```
3. Make the script executable by running:
   ```sh
   chmod +x gather_addresses.sh
   ```
4. Create a file with a list of domain names (one per line), and name it: `domains.txt`:
   ```
   example.com
   google.com
   github.com
   ```
5. Run the script and pass the domain list file, the output text file, and the output XML file as arguments:
   ```sh
   ./gather_addresses.sh domains.txt output.txt output.xml
   ```
This script will read the domain names from `domains.txt`, gather the IP addresses for each domain, and save the results to both `output.txt` and `output.xml`. Each line in the text file will contain a domain name followed by its corresponding IP addresses, or indicate if no IP address was found. The XML file will contain the same information in a structured format.
