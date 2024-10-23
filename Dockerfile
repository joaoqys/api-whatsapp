FROM node:18-slim

# Instalar dependências
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

# Adicionar o repositório do Chrome e instalar o Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable

# Limpar o cache do npm, remover node_modules e package-lock.json se existirem, e instalar dependências
RUN npm cache clean --force
WORKDIR /app
COPY . /app
RUN rm -rf node_modules package-lock.json && npm install

# Expor a porta do seu webservice
EXPOSE 3000

# Iniciar a aplicação
CMD ["node", "app.js"]
