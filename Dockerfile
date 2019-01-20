FROM python:3-slim-stretch

WORKDIR /

COPY "entrypoint.sh" "Pipfile" "Pipfile.lock" /

RUN apt-get update && \
  pip install --upgrade pip && \
  pip install --upgrade pipenv && \
  pipenv install

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
