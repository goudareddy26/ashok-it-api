  
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

# Git operations to add RBAC files(service-account, role, role-binding) to github repo


I have this github repo name "ashok-it-api",
https://github.com/goudareddy26/ashok-it-api/tree/main, it has manifest 
springboot-app.yaml , I want to deploy this on minikube using jenkins pipeline, I have tested the integration with a pipeline and its working

now I want to add RBAC rules yamls to this repo which are required for this deployment and test them before deploying this above springboot-app.yaml.

ashok-it-api/
├── k8s-rbac/
│   ├── service-account.yaml
│   ├── role.yaml
│   ├── rolebinding.yaml
└── springboot-app.yaml


Two options available
1.Authentication with GitHub using SSH
2. Authentication with GitHub using HTTPS and a Personal Access Token

option 1: Authentication with GitHub using HTTPS and a Personal Access Token

Configure credential helper and Git identity
	  ```
   git config --global credential.helper store
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```
 ```   
git checkout -b f-rbac-rules
Switched to a new branch 'f-rbac-rules'
gogi@gogi-ubuntu:~/ashok-it-api$ git branch 
* f-rbac-rules
  main
 ```

create folder  k8s-rbac under ashok-it-api 
add all three manifest files under k8s-rbac foldr
 ```
git status
On branch f-rbac-rules
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   k8s-rbac/role.yaml
	new file:   k8s-rbac/rolebinding.yaml
	new file:   k8s-rbac/service-account.yaml
 ```
  ```
git commit -m "added rbac rule manifest files"
 ```

 ```
git config --global credential.helper store
gogi@gogi-ubuntu:~$ git config --global user.name goudareddy26
gogi@gogi-ubuntu:~$ git config --global user.email goudareddy26@gmail.com
 ```


 ```
git push -u origin f-rbac-rules 
Username for 'https://github.com': goudareddy26
Password for 'https://goudareddy26@github.com': 
remote: Invalid username or token. Password authentication is not supported for Git operations.
fatal: Authentication failed for 'https://github.com/goudareddy26/ashok-it-api.git/'
 ```
 
#create token in github.com
 
Option 1 — Use a Personal Access Token (Recommended)
🪄 Step 1. Create a GitHub Personal Access Token (PAT)

  1.Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
   
   Set:
    Note: jenkins-git-token
    Expiration: choose 90 days or “No expiration” (optional)
    Scopes:
	✅ repo (for full repo access)
    ✅ workflow (optional for GitHub Actions)
   Click Generate token
   Copy the token (you won’t see it again) 
   
🪄 Step 2. Configure Git to Use Token

In your terminal (as user gogi):
git remote set-url origin https://<YOUR_USERNAME>@github.com/goudareddy26/ashok-it-api.git

Then push like this:
 ```
git push -u origin f-rbac-rules
Username: goudareddy26
Password: <paste your Personal Access Token here>
 ```
 
🪄 Step 3 (Optional): Save Token in Git Credential Store

You can store the token to avoid retyping:
 ```
 git config --global credential.helper store
 ```
Then the next push will save credentials in ~/.git-credentials.
 ```
git push -u origin f-rbac-rules
 ```
Username for 'https://github.com': goudareddy26
Password for 'https://goudareddy26@github.com': 
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 12 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 831 bytes | 831.00 KiB/s, done.
Total 6 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote: 
remote: Create a pull request for 'f-rbac-rules' on GitHub by visiting:
remote:      https://github.com/goudareddy26/ashok-it-api/pull/new/f-rbac-rules
remote: 
To https://github.com/goudareddy26/ashok-it-api.git
 * [new branch]      f-rbac-rules -> f-rbac-rules
branch 'f-rbac-rules' set up to track 'origin/f-rbac-rules'.

goto github.com GUI, create PR and merge it 
