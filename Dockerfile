FROM python:3-stretch

RUN apt-get update && \
  pip install --upgrade pip && \
  pip install --upgrade httpie 

ENTRYPOINT ["http"]
CMD ["--help"]
