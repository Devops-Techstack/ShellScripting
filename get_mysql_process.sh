#!/bin/bash

# Define colors
RESET="\033[0m"
CYAN="\033[36m"
YELLOW="\033[33m"
GREEN="\033[32m"
MAGENTA="\033[35m"
RED="\033[31m"

# MySQL credentials
MYSQL_USER="root"  # Replace with your MySQL username
MYSQL_PASS="devops"  # Replace with your MySQL password
MYSQL_HOST="localhost"  # Change if not running MySQL locally

# Run MySQL SHOW PROCESSLIST command
RESULT=$(mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_HOST -e "SHOW PROCESSLIST;" 2>/dev/null)

# Check for errors
if [[ $? -ne 0 ]]; then
  echo -e "${RED}Error connecting to MySQL. Check your credentials.${RESET}"
  exit 1
fi

# Process and colorize output
echo -e "${CYAN}--- SHOW PROCESSLIST Result ---${RESET}"
echo "$RESULT" | while IFS= read -r line; do
  if [[ $line == *"Id"* && $line == *"Command"* ]]; then
    # Header
    echo -e "${YELLOW}${line}${RESET}"
  else
    # Data rows
    echo "$line" | awk -v reset="$RESET" -v green="$GREEN" -v cyan="$CYAN" -v magenta="$MAGENTA" -v yellow="$YELLOW" '
    {
      printf cyan $1 reset "\t" green $2 reset "\t" magenta $3 reset "\t" yellow $4 reset "\t";
      for (i = 5; i <= NF; i++) printf $i " ";
      printf "\n";
    }'
  fi
done
