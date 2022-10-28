FROM node:19
WORKDIR /usr/app

RUN apt update && \
    apt -y install python3 python3-pip python3-dev build-essential curl libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN npm install --ignore-scripts && \
    curl -sSL https://github.com/secretchatbot/libtensorflow/releases/download/v2.6.0/libtensorflow-cpu-linux-arm64-2.6.0.tar.gz -o libtensorflow.tar.gz && \
    mkdir -p node_modules/@tensorflow/tfjs-node/deps/ && \
    tar -xvf libtensorflow.tar.gz -C node_modules/@tensorflow/tfjs-node/deps/ && \
    rm libtensorflow.tar.gz && \
    npm rebuild --build-addon-from-source

CMD ["node", "-r", "newrelic", "dist/index.js"]
