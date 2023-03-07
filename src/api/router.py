from fastapi import APIRouter

from src.api.models import CustomRequest, CustomResponse
from src.package.module import do_business_logic

router = APIRouter()


@router.post("/custom_request", summary="Custom request")
async def custom_request(request: CustomRequest) -> CustomResponse:
    """Perform the endpoint action."""
    content = CustomResponse(content=request.content)
    do_business_logic()
    return content
