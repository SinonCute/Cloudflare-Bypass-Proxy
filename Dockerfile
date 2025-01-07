FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential python3-distutils curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

COPY . /app

RUN mkdir -p /usr/local/lib/python3.13/site-packages/javascript/js/node_modules && \
    npm install jsdom@latest node-fetch@2 --prefix /usr/local/lib/python3.13/site-packages/javascript/js

RUN mkdir -p /usr/local/lib/python3.13/site-packages/javascript/js/node_modules && \
    npm install atob --prefix /usr/local/lib/python3.13/site-packages/javascript/js

RUN python3 -m pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python3", "app.py"]
