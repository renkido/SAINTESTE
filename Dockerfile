FROM node:lts-buster  

USER root
RUN apt-get update && \
    apt-get install -y ffmpeg webp git python3 make g++ && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

USER node
RUN git clone https://github.com/renkido/SUBZERO-MD.git /home/node/SUBZERO-MD
WORKDIR /home/node/SUBZERO-MD

# Installation sécurisée des dépendances
RUN yarn config set network-timeout 300000 && \
    yarn install --network-concurrency 1 --ignore-engines
RUN yarn remove better-sqlite3 && \
    yarn add sqlite3@5.1.6

EXPOSE 7860
ENV NODE_ENV=production
CMD ["npm", "start"]
