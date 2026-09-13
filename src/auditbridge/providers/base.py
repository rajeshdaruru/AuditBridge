from abc import ABC, abstractmethod


class ModelProvider(ABC):
    """Interface every LangGraph node reasons against, instead of calling an
    inference SDK directly. Swapping or adding a backend later means writing
    one new subclass, not touching agent logic."""

    @abstractmethod
    def generate(self, system_prompt: str, user_prompt: str, **kwargs) -> str:
        """Return the model's text completion for the given prompt pair."""
        raise NotImplementedError
