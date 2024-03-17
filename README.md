# Electronics Recycling System

System design for [Going Green](https://nealford.com/katas/kata?id=GoingGreen)

### System Landscape
![Component View](workspace/.structurizr/images/Component-002-thumbnail.png)

### Deployment view
![Deployment view](workspace/.structurizr/images/Deployment-001-thumbnail.png)

## How to run this example

Execute this command to run a Docker container with a structurizr lite image.

```bash
docker run --name going-green --env=PORT=8080 --volume=$(pwd)/workspace:/usr/local/structurizr -p 8888:8080 -d structurizr/lite:latest
```

## Links

* [Documentation](http://localhost:8888/workspace/documentation)
* [ADRs](http://localhost:8888/workspace/decisions)
* [Diagrams](http://localhost:8888/workspace/explore)
