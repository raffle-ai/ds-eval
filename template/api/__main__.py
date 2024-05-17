import os

import uvicorn
from fastapi import FastAPI

import template
from template.api import router

APP_PORT = int(os.getenv("APP_PORT", "8080"))

app = FastAPI(
    title="ds-repo-template",
    description="Template repository for data science projects.",
    version=template.__version__,
)

app.include_router(router.router)


@app.get("/", summary="Health check")
async def root_handler() -> str:
    """Root endpoint for health check."""
    return "OK"


def main() -> None:
    """Main function to run ds-repo-template API."""
    uvicorn.run(app, host="0.0.0.0", port=APP_PORT)


if __name__ == "__main__":
    main()
