docker build -t 315426346/client:latest -t 315426346/client:$SHA ./client
docker build -t 315426346/worker:latest -t 315426346/worker:$SHA ./worker
docker build -t 315426346/server:latest -t 315426346/server:$SHA ./server



docker push 315426346/client:latest 
docker push 315426346/worker:latest
docker push 315426346/server:latest

docker push 315426346/client:$SHA 
docker push 315426346/worker:$SHA
docker push 315426346/server:$SHA


kubectl apply -f ./k8s/client
kubectl apply -f ./k8s/ingress-nginx
kubectl apply -f ./k8s/postgres
kubectl apply -f ./k8s/redis
kubectl apply -f ./k8s/server
kubectl apply -f ./k8s/worker


kubectl set image deployemnt/server-deployment server=315426346/server:$SHA
kubectl set image deployemnt/client-deployment client=315426346/client:$SHA
kubectl set image deployemnt/worker-deployment worker=315426346/worker:$SHA