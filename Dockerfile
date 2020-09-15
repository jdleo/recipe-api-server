# base image to start the build process
FROM python:3.7-alpine
# for label info
LABEL maintainer="j@jdleo.me"
# run python in unbuffered mode (recommended for running py inside container)
ENV PYTHONUNBUFFERED 1
# copy python dependencies from host into container
COPY ./requirements.txt ./requirements.txt
# add postgres client to apk
RUN apk add --update --no-cache postgresql-client
# add temporary dependencies for building postgresql
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers postgresql-dev
# install dependencies in container
RUN pip install -r /requirements.txt
# delete temp requirements
RUN apk del .tmp-build-deps
# make /app for python app, set working directory to /app
RUN mkdir /app
WORKDIR /app
# copy python app source from host into container
COPY ./app /app
# create user named 'user' to run code
RUN adduser -D user
# switch to that user
USER user