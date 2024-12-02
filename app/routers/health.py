from fastapi import APIRouter
from starlette.config import Config

router = APIRouter()
config = Config(".env")

@router.get("/")
def env_main():
   return {"ENVIROMENT": config("ENVIRONMENT")}
 
@router.get("/healthcheck")
def healthcheck():
    return {"success": True}

@router.get("/secret")
def env_main():
   return {"ENVIROMENT_FROM_SECRET": config("ENVIRONMENT_FROM_SECRET")}
