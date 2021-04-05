docker build -t smisra1988/multi-client:latest -t smisra1988/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smisra1988/multi-server:latest -t smisra1988/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t smisra1988/multi-worker:latest -t smisra1988/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push smisra1988/multi-client:latest
docker push smisra1988/multi-server:latest
docker push smisra1988/multi-worker:latest
docker push smisra1988/multi-client:$SHA
docker push smisra1988/multi-server:$SHA
docker push smisra1988/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smisra1988/multi-server:$SHA
kubectl set image deployments/client-deployment client=smisra1988/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=smisra1988/multi-worker:$SHA
