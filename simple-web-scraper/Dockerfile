FROM python:3.13.1-alpine3.21

COPY scraper.py .
COPY requirements.txt .

RUN apk update && apk add --no-cache firefox
RUN pip install --no-cache-dir -r requirements.txt


CMD [ "python", "scraper.py" ]