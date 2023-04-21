from fastapi import APIRouter

from template.api.models import CustomRequest, CustomResponse
from template.package.module import do_business_logic

router = APIRouter()


@router.post("/custom_request", summary="Custom request")
async def custom_request(request: CustomRequest) -> CustomResponse:
    """Perform the endpoint action."""
    content = CustomResponse(content=request.content)
    do_business_logic()
    return content
