from fastapi import APIRouter
from service_api.auth.dependencies import AuthenticatedUserWithRolesDep
from service_api.models.auth import AuthenticatedUser

router = APIRouter(tags=["auth"])


@router.get("/whoami")
async def whoami_with_roles(
    current_user: AuthenticatedUserWithRolesDep,
) -> AuthenticatedUser:
    """Return authenticated user's information including their Keycloak roles."""

    return current_user
