  
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

Clean up and useful commands
- Stop and remove container:
 ```bash
docker stop ashok-app
docker rm ashok-app
```

- Remove image:
 ```bash
docker rmi goudareddy26/ashokit:latest
```

- Show local images:
  ```bash
docker images
```

# Push image to Docker Hub
1. Ensure the image has the correct name (you already do)
Confirm the image tag points to your Docker Hub repo namespace:
```bash
docker images
```
# look for: goudareddy26/ashokit   v1


2. Log in to Docker Hub (use a Docker Hub Access Token instead of account password)
- Create an Access Token on Docker Hub: Docker Hub → Settings → Security → New Access Token.
- Then log in from your shell:
```bash
docker login -u <username>
docker login -u goudareddy26
```
# Username: goudareddy26
# Password: **********


3. Tag the image only if needed
If your local image already is named exactly goudareddy26/ashokit:v1 you can skip this step. If not, retag it:
Push the image
```bash
docker push goudareddy26/ashokit:v1
```

5. Verify successful push
- Confirm success output from the push command.
- Check on Docker Hub web UI under your repository goudareddy26/ashokit to see the v1 tag.


