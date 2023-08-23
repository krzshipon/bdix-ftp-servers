from bs4 import BeautifulSoup

with open('your_input_filename.html', 'r') as file:
    content = file.read()

soup = BeautifulSoup(content, 'html.parser')

# Find all div elements with class name NsaAfc
target_divs_NsaAfc = soup.find_all('div', class_='NsaAfc')

# Find all span elements with class name C9DxTc
target_spans_C9DxTc = soup.find_all('span', class_='C9DxTc')

# Combine the lists of divs and spans
target_elements = target_divs_NsaAfc + target_spans_C9DxTc

# Create a new Beautiful Soup object for the output HTML
output_soup = BeautifulSoup(features="html.parser")
output_body = output_soup.new_tag('body')  # Create a new <body> tag

# Iterate through the original content and append matching elements to the output
for element in soup.find_all():
    if element in target_elements:
        # Remove attributes from the element
        element.attrs = {}
        output_body.append(element)

# Append the new <body> tag to the main <html> tag
output_soup.append(output_soup.new_tag('html'))
output_soup.html.append(output_body)

# Write the extracted divs and spans with removed attributes to output.html
with open('output.html', 'w') as output_file:
    output_file.write(str(output_soup))
