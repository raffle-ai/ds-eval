from fastapi import APIRouter

from api.models import CustomRequest, CustomResponse
from package.module import foo

router = APIRouter()


@router.post("/custom_request", summary="Custom request")
async def custom_request(request: CustomRequest) -> CustomResponse:
    """Perform the endpoint action."""
    content = CustomResponse(content=request.content)
    foo()
    return content
