Launch [One-Time Secret](http://onetimesecret.com) as a Docker container

## Usage

    docker run --name=onetimesecret -p 80:7143 carlasouza/onetimesecret

Or BIY (build it yourself)!

    docker build . -t='my_onetimesecret'
    docker run --name=onetimesecret -p 80:7143 -t my_onetimesecret

Access it through your browser at `http://localhost`
