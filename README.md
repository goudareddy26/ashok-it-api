  
# Simple Spring Boot with Docker Application#


Build the image using the following command

Build and run container image
Prerequisites
- Jar exists at target/ashok-it-api.jar after mvn clean package.
- Docker daemon running and your user can run docker commands.

Build the image
- From the directory containing the Dockerfile (same level as target/), run:
 ```bash
docker build -t goudareddy26/ashokit:latest .
```


- To tag with a version:
 ```bash
docker build -t goudareddy26/ashokit:v1 .
```

Run the container and expose port
- Run in foreground and map host port 8080 to container 8080:
 ```bash
docker run --rm -p 8080:8080 goudareddy26/ashokit:latest
```

- Run detached:
 ```bash
docker run -d --name ashok-app -p 8080:8080 goudareddy26/ashokit:latest
```

Verify the app is running

- List containers:
 ```bash
docker ps
```
- View logs:
 ```bash
docker logs -f ashok-app
```

- Test from the host:
 ```bash
curl -v http://localhost:8080/   # or the app's actual context path
```

- If using Windows and WSL/docker desktop, use localhost for host networking.

