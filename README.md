Launch [One-Time Secret](http://onetimesecret.com) as a Docker container

## Usage

```bash
# docker run --name=onetimesecret -p 80:7143 carlasouza/onetimesecret
```

Or BIY (build it yourself)!

```bash
# docker build . -t='my_onetimesecret'
# docker run --name=onetimesecret -p 80:7143 -t my_onetimesecret
```

Access it through your browser at `http://localhost`

## Limitations

The application generates a link that uses a preconfigured domain and port. Right now it is only generating using `localhost:80`
