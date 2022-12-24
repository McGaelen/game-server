# Game Server Template
This game server template is for running dedicated servers for games using Docker. It also uses Github Actions to start and stop the server.

The image will always update the game to the latest version on launch. The installation is stored on a volume (`data` directory) so that it doesn't have to be downloaded every time the container starts. Therefore, if a new version of the game is released, you only need to restart the container to download the update. If save data is needed, it will be stored in the `save-data` volume.

## How to use this repo

### Prerequisites:
* A server running Linux
* Docker is installed on your server
* You must install a self-hosted Github Actions runner on the machine that you want to host the game server for this repo to work. Read the docs for how to do that. https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners
> **Note**
> You should never attach a self-hosted Github Actions runner to a public repository. This causes major security issues. More info: https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners


### Once the prereqs are met:
1. Fork this repo. Make sure you make it private.
2. Create a directory on your server where the deployment can live. Doesn't matter where it is, but I normally use `/opt/[game-name]`
3. In this directory, create a `.env` file with all the relevant parameters for your server, like a server name and password. 
4. Use find and replace in your editor to fill in the required info:
   * `[game-name]` : Name of the game. Can be whatever you want; doesn't have to match the name in Steam. No spaces allowed. For example: `my-valheim-server`
   * `[steam-app-id]` : The app id of the game. Find it here: https://steamdb.info/apps/
   * `[game-deploy-directory]` : The directory ***on your server*** where the deployment will live. Should be a full/absolute path. This is the path to the directory you created in step 2.
   * `[github-actions-runner]` : A Github Actions tag representing the server that the game will be deployed to. Set this to self-hosted if you didn't create a different tag name for your self-hosted runner. 
   * `[save-file-directory]` : The directory ***inside the container*** where save files live. Google "Where does [game-name] store save files" and put that here. Should be a full/absolute path. If your game doesn't need save data, then remove the line in `docker-compose.yml` that uses this variable (under `volumes:`).
   * `[game-executable]` : The name of the game's executable. Can be found by reading the game's documentation.
5. Update `start_server.sh` to pass the correct parameters to the game's executable. Read the game's documentation for what params to pass. Variables in `.env` can be used here.
6. Update `docker-compose.yml` to forward ports the game needs from the container. (You still need to forward these same ports in your router.)
7. Push your code. Make sure to not commit `.env`, as it probably contains passwords.
8. Run the Github Action by going to the Actions tab in your repo, then selecting either Deploy or Stop on the left-hand side.

## Tips
* To view logs, run `docker logs -f [game-name]`
* To attach a shell to the running container, run `docker exec -it [game-name] /bin/bash`