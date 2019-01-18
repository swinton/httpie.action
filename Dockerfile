FROM python:3-stretch

LABEL name="http"
LABEL version="1.0.0"
LABEL repository="http://github.com/swinton/httpie-action"
LABEL homepage="http://github.com/swinton/httpie-action"

LABEL maintainer="Steve Winton <stevewinton@gmail.com>"
LABEL com.github.actions.name="HTTPie"
LABEL com.github.actions.description="Wraps the HTTPie CLI to enable human-friendly interactions with third-party web services."
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="upload-cloud"

RUN apt-get update && \
  pip install --upgrade pip && \
  pip install --upgrade httpie 

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
