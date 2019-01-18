FROM python:3-stretch

RUN apt-get update && \
  pip install --upgrade pip && \
  pip install --upgrade httpie 

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
