#!/bin/bash

NAME="testsite"
DJANGODIR=/home/akshatha/django-apps/testsite
SOCKFILE=/home/akshatha/django-apps/testsite/run/gunicorn.sock
USER=akshatha
GROUP=getdata
NUM_WORKERS=1
DJANGO_SETTINGS_MODULE=testsite.settings
DJANGO_WSGI_MODULE=testsite.wsgi

echo "Starting $NAME as `whoami`"

#Activate the  virtual environment
cd $DJANGODIR
. /home/akshatha/django-apps/testsite/django_env/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

#Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

#Start your Django Unicorn

exec /home/akshatha/django-apps/testsite/django_env/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
 --name $NAME \
 --workers $NUM_WORKERS \
 --user $USER \
 --bind=unix:$SOCKFILE


