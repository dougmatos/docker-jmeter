@echo off
SETLOCAL EnableDelayedExpansion

set arquivo=%1%

docker-compose up --build -d

docker ps -q --filter name=slave > id_slaves.tmp
for /F %%a in (id_slaves.tmp) do docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" %%a >> result.tmp
set ips=
for /F "delims=" %%a in (result.tmp) do set ips=!ips!,%%a
set ips=!ips:~1!

set filetest=
for /f %%a in ('dir teste\*.jmx /b') do set filetest= %%a

for /F %%a in (id_slaves.tmp) do ( 
    docker exec -it %%a /bin/bash -c "cp /jmeter-teste/* /jmeter/bin"
)

del id_slaves.tmp
del result.tmp

docker exec -it master /bin/bash -c "cp /jmeter-teste/* /jmeter/bin"

docker exec -it master /bin/bash -c "./jmeter -n -t %filetest% -l data.csv -eo result -R %ips% "
docker cp master:/jmeter/bin/result results/

docker-compose down 