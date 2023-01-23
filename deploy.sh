docker build -t nibrasmuhamed/multi-client:latest -t nibrasmuhamed/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t nibrasmuhamed/multi-server:latest -t nibrasmuhamed/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t nibrasmuhamed/multi-worker:latest -t nibrasmuhamed/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push nibrasmuhamed/multi-client:latest
docker push nibrasmuhamed/multi-server:latest
docker push nibrasmuhamed/multi-worker:latest

docker push nibrasmuhamed/multi-client:$SHA
docker push nibrasmuhamed/multi-server:$SHA
docker push nibrasmuhamed/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephergrider/multi-server:$SHA
kubectl set image deployments/client-deployment server=stephergrider/multi-client:$SHA
kubectl set image deployments/woker-deployment server=stephergrider/multi-woker:$SHA

