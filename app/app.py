from typing import Final

import uvicorn
from fastapi import APIRouter, FastAPI
from starlette.responses import PlainTextResponse

DEFAULT_HOST: Final = "0.0.0.0"
DEFAULT_PORT: Final = 8000

api_router = APIRouter()


@api_router.get("/ping")
async def ping() -> PlainTextResponse:
    return PlainTextResponse("pong")


def create_app() -> FastAPI:
    app = FastAPI()
    app.include_router(api_router)
    return app


app = create_app()
if __name__ == "__main__":
    uvicorn.run(app=app, host=DEFAULT_HOST, port=DEFAULT_PORT)
