FROM raffle.azurecr.io/cimg-python-builder:latest as builder

RUN mkdir /home/somebody/ds_repo_template
WORKDIR /home/somebody/ds_repo_template
COPY --chown=somebody:somebody Makefile pyproject.toml poetry.lock ./

ARG GIT_TOKEN
RUN git config --global url."https://${GIT_TOKEN}@github.com/".insteadOf "https://github.com/"

RUN make deps-prod


FROM raffle.azurecr.io/cimg-python-runtime:latest as runtime

RUN mkdir /home/somebody/ds_repo_template
WORKDIR /home/somebody/ds_repo_template
ENV VENV_PATH=/home/somebody/ds_repo_template/.venv
ENV PATH=${VENV_PATH}/bin:$PATH

COPY --chown=somebody:somebody --from=builder ${VENV_PATH} ${VENV_PATH}
COPY --chown=somebody:somebody . .

ENV APP_PORT 8080
ENV HOST 0.0.0.0
EXPOSE ${APP_PORT}

CMD python -m ds_repo_template.api
