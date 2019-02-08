FROM python:3-slim-stretch

LABEL name="HTTP client for GitHub Actions"
LABEL version="1.0.3"
LABEL repository="http://github.com/swinton/httpie.action"
LABEL homepage="http://github.com/swinton/httpie.action"

LABEL maintainer="Steve Winton <stevewinton@gmail.com>"
LABEL com.github.actions.name="HTTP client"
LABEL com.github.actions.description="A general purpose HTTP client for GitHub Actions providing human-friendly interactions with third-party web services."
LABEL com.github.actions.icon="send"
LABEL com.github.actions.color="gray-dark"

WORKDIR /

COPY "entrypoint.sh" "Pipfile" "Pipfile.lock" /
COPY "config.json" /.httpie/

RUN apt-get update -y && \
  apt-get install -y --no-install-recommends jq && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install --upgrade pipenv && \
  pipenv install --deploy --system

ENV HTTPIE_CONFIG_DIR /.httpie

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
