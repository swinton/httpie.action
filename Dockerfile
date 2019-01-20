FROM python:3-slim-stretch

WORKDIR /

COPY "entrypoint.sh" "Pipfile" "Pipfile.lock" /

LABEL name="HTTPie CLI"
LABEL version="1.0.0"
LABEL repository="http://github.com/swinton/httpie-action"
LABEL homepage="http://github.com/swinton/httpie-action"

LABEL maintainer="Steve Winton <stevewinton@gmail.com>"
LABEL com.github.actions.name="HTTPie CLI"
LABEL com.github.actions.description="Wraps the HTTPie CLI to enable human-friendly interactions with third-party web services."
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="gray-dark"

RUN pip install --upgrade pip && \
  pip install --upgrade pipenv && \
  pipenv install

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
