npm run build:compiled
# mv .env .envDev && mv .envProd .env
docker build -t nestservestatic .
# mv .env .envProd && mv .envDev .env

