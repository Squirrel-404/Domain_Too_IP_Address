#!/bin/bash

# Check if the necessary arguments are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 <domain_list_file> <output_txt_file> <output_xml_file>"
  exit 1
fi

DOMAIN_LIST_FILE=$1
OUTPUT_TXT_FILE=$2
OUTPUT_XML_FILE=$3

# Check if the domain list file exists
if [ ! -f "$DOMAIN_LIST_FILE" ]; then
  echo "File not found: $DOMAIN_LIST_FILE"
  exit 1
fi

# Initialize the XML file
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$OUTPUT_XML_FILE"
echo "<domains>" >> "$OUTPUT_XML_FILE"

# Function to gather IP addresses for a domain
gather_ip_addresses() {
  local domain=$1
  echo "Gathering IP addresses for $domain"
  ips=$(dig +short "$domain" | grep -E "^[0-9.]+$")
  if [ -z "$ips" ]; then
    echo "$domain: No IP address found" >> "$OUTPUT_TXT_FILE"
    echo "  <domain name=\"$domain\">" >> "$OUTPUT_XML_FILE"
    echo "    <ip>No IP address found</ip>" >> "$OUTPUT_XML_FILE"
    echo "  </domain>" >> "$OUTPUT_XML_FILE"
  else
    echo "$domain: $ips" >> "$OUTPUT_TXT_FILE"
    echo "  <domain name=\"$domain\">" >> "$OUTPUT_XML_FILE"
    for ip in $ips; do
      echo "    <ip>$ip</ip>" >> "$OUTPUT_XML_FILE"
    done
    echo "  </domain>" >> "$OUTPUT_XML_FILE"
  fi
}

# Clear the output text file if it exists
> "$OUTPUT_TXT_FILE"

# Read the domain list file and gather IP addresses
while IFS= read -r domain; do
  gather_ip_addresses "$domain"
done < "$DOMAIN_LIST_FILE"

# Finalize the XML file
echo "</domains>" >> "$OUTPUT_XML_FILE"

echo "Output saved to $OUTPUT_TXT_FILE and $OUTPUT_XML_FILE"
