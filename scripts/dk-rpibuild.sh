echo `tput setaf 2`Introducir 1 si casa o 2 fuera`tput sgr0`
read var
option=0
option1=neo3@192.168.1.12
option2=neo3@ip.aml360esp.com
if [ $var = 1 ]; then
    var=1
    elif [ $var = 2 ]; then
    var=2
else
    echo `tput setaf 1`El numero introducido no es ni 1 ni 2`tput sgr0`
    exit 1
fi
if [ $var = 1 ]; then
    option=$option1
else
    option=$option2
fi

echo `tput setaf 3`Compliando nest`tput sgr0`
npm run build:compiled

export DOCKER_CLI_EXPERIMENTAL=enabled

echo `tput setaf 3`Generando imagen`tput sgr0`

docker buildx build --load --platform linux/arm64 -t servestaticnode .

echo `tput setaf 3`Creating img.tar`tput sgr0`

docker save  -o ~/dkImages/servestaticnode.tar servestaticnode:latest

echo `tput setaf 3`Copying to nanopi`tput sgr0`

scp ~/dkImages/servestaticnode.tar $option:~/dkImages/

echo `tput setaf 3`executing: 'Cargando imagen'`tput sgr0`

ssh $option 'cd ~/dkImages && docker load -i servestaticnode.tar'