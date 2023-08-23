import json

# Load the JSON data from the file
with open('ftp_servers.json', 'r') as file:
    data = json.load(file)

# Filter out objects with URLs containing 'facebook.com'
filtered_data = [item for item in data if 'facebook.com' not in item['url']]

# Save the filtered data to a new JSON file
with open('output.json', 'w') as file:
    json.dump(filtered_data, file, indent=2)

print("Filtered data has been saved to output.json")
