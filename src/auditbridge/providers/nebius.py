import os

from openai import OpenAI

from auditbridge.providers.base import ModelProvider

# Nebius Token Factory exposes an OpenAI-compatible chat completions API.
# TODO: confirm base URL, exact model id, and any request-shape quirks against
# a live Token Factory account (Week 1 checklist item).
DEFAULT_BASE_URL = "https://api.studio.nebius.com/v1"


class NebiusNemotronProvider(ModelProvider):
    def __init__(
        self,
        model: str | None = None,
        api_key: str | None = None,
        base_url: str | None = None,
    ):
        self.model = model or os.environ["NEBIUS_NEMOTRON_MODEL"]
        self._client = OpenAI(
            api_key=api_key or os.environ["NEBIUS_API_KEY"],
            base_url=base_url or os.environ.get("NEBIUS_BASE_URL", DEFAULT_BASE_URL),
        )

    def generate(self, system_prompt: str, user_prompt: str, **kwargs) -> str:
        response = self._client.chat.completions.create(
            model=self.model,
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt},
            ],
            **kwargs,
        )
        return response.choices[0].message.content
