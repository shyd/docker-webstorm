# docker-webstorm
Full featured Jetbrains Projector Webstorm docker image.


## Run JetBrains IDE in Docker

All info to Webstorm can be found here <https://github.com/JetBrains/projector-docker>.

How to run JetBrains IDE in Docker and access it via a web browser?

Pull the image and run it via the following command:

```shell
docker run --rm -p 8887:8887 -it shyd/webstorm
```

This will run **Projector Server with the selected JetBrains IDE** locally.

To access Projector Server with IDE, use <http://localhost:8887/>.

## Whats inside?

- everything from shyd/zsh
- nodejs, npm, yarn, gulp-cli, bower, gh-pages
- imagemagick, graphicsmagick
- rbenv with ruby 2.6.0
 
