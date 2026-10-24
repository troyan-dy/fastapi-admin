# FastAPI-template-repository

## Dependencies
- docker-compose
- python 3.14

## Commands
### Install
- `make setup`

### Run tests
- `make test`
### Linting
- `make lint`
- `make wps` (wemake-python-styleguide: `flake8 app tests --select=WPS`)

### Formatting
- `make format`

### Start in docker
- `make start`
- `make stop`


## Usage

- Curl
```bash
curl -X GET http://0.0.0.0:8000/ping
```

- Response

```bash
pong
```
