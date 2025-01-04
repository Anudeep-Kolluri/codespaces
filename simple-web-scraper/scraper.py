from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from webdriver_manager.firefox import GeckoDriverManager
from selenium.webdriver.firefox.options import Options


job_name = "data engineer"
job_location = "Texas"

get_link = lambda job_name, job_location : f"https://www.indeed.com/jobs?q={job_name.replace(" ", "+")}&l={job_location}&from=searchOnDesktopSerp&vjk=a76d4312433c123c"

link = get_link(job_name, job_location)

# Set up the options for Firefox
options = Options()
options.binary_location = "/usr/bin/firefox"
options.add_argument("--headless")  # Run in headless mode

# Set up the Firefox WebDriver with the Service class
service = Service(GeckoDriverManager().install())

# Start Firefox WebDriver
driver = webdriver.Firefox(service=service, options=options)

# Example usage of the driver
driver.get("https://www.example.com")

# Close the driver when done
driver.quit()