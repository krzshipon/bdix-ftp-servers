from bs4 import BeautifulSoup
import csv

with open('output.html', 'r') as file:
    content = file.read()

soup = BeautifulSoup(content, 'html.parser')

# Find all span and p elements
elements = soup.find_all(['span', 'p'])

# Initialize variables to store data for CSV
data = []
current_title = ''
current_link = ''

# Iterate through the elements and extract title and link information
for element in elements:
    if element.name == 'span':
        current_title = element.get_text(strip=True)
    elif element.name == 'p':
        current_link = element.get_text(strip=True)
        data.append([current_title, current_link])

# Write data to CSV file
with open('output.csv', 'w', newline='', encoding='utf-8') as csv_file:
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow(['Title', 'Link'])  # Write header
    csv_writer.writerows(data)  # Write data rows
