FROM python:3-slim-stretch

LABEL name="HTTPie CLI"
LABEL version="1.0.0"
LABEL repository="http://github.com/swinton/httpie-action"
LABEL homepage="http://github.com/swinton/httpie-action"

LABEL maintainer="Steve Winton <stevewinton@gmail.com>"
LABEL com.github.actions.name="HTTPie CLI"
LABEL com.github.actions.description="Wraps the HTTPie CLI to enable human-friendly interactions with third-party web services."
LABEL com.github.actions.icon="send"
LABEL com.github.actions.color="gray-dark"

WORKDIR /

COPY "entrypoint.sh" "Pipfile" "Pipfile.lock" /
COPY "config.json" /.httpie/

RUN apt-get update -y && \
  apt-get install --no-install-recommends jq && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install --upgrade pipenv && \
  pipenv install --deploy --system

ENV HTTPIE_CONFIG_DIR /.httpie

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
