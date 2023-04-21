FROM raffle.azurecr.io/cimg-python:latest

ARG GIT_TOKEN
RUN git config --global url."https://${GIT_TOKEN}@github.com/".insteadOf "https://github.com/"

WORKDIR /ds-repo-template
COPY . /ds-repo-template

COPY poetry.lock pyproject.toml ./
RUN poetry install

ENV APP_PORT 8080
EXPOSE ${APP_PORT}

CMD [\
  "poetry", "run", \
  "uvicorn", "api.main:app", \
  "--port", "${APP_PORT}", \
  "--host", "0.0.0.0" \
  ]

