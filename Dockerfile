FROM node

RUN apt update
RUN apt install -y \ 
    libnss3 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxkbcommon0 \
    libasound2

RUN mkdir /usr/local/lib/node_modules/pa11y \
    && chown -R node /usr/local/lib/node_modules /usr/local/bin

USER node
RUN npm install -g pa11y
WORKDIR /home/node

RUN git clone https://github.com/pa11y/pa11y-webservice.git
RUN cd pa11y-webservice \
    && npm install
COPY development.json pa11y-webservice/config/

RUN git clone https://github.com/pa11y/pa11y-dashboard.git
RUN cd pa11y-dashboard \
    && npm install

COPY pa11y.json .
ENTRYPOINT [ "/usr/local/bin/pa11y" ]