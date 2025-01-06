from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options
from webdriver_manager.firefox import GeckoDriverManager
from bs4 import BeautifulSoup

def fetch_html(url):
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    
    service = Service(GeckoDriverManager().install())
    driver = webdriver.Firefox(service=service, options=options)
    
    driver.get(url)
    html_content = driver.page_source
    driver.quit()
    
    return html_content

def scrape_table(html):
    soup = BeautifulSoup(html, "html.parser")
    table = soup.find("table", {"id": "occupationTable"})
    
    data = []
    headers = [header.text.strip() for header in table.find_all("th")]
    
    for row in table.find_all("tr")[1:]:
        cols = row.find_all("td")
        if cols:
            data.append([col.text.strip() for col in cols])
    
    print("Headers:", headers)
    for row in data:
        print(row)

url = "https://willrobotstakemyjob.com/rankings/top-searched-for-jobs"
html_content = fetch_html(url)

scrape_table(html_content)
