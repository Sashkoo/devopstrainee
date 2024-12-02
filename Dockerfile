FROM python:3.12 AS python-base

RUN python3 -m venv /opt/poetry-venv \
    && /opt/poetry-venv/bin/pip install -U pip setuptools \
    && /opt/poetry-venv/bin/pip install poetry==1.5.0

ENV PATH="/opt/poetry-venv/bin:$PATH"

FROM python-base AS example-app

WORKDIR /app

COPY poetry.lock pyproject.toml ./

RUN poetry check

RUN poetry install --no-interaction --no-cache

COPY . .

EXPOSE 8000

CMD ["poetry", "run", "gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:app", "-k", "uvicorn.workers.UvicornWorker"]
