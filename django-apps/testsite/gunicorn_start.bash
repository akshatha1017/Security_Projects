NAME="testsite"
DJANGODIR=/home/akshatha/django-apps/testsite
SOCKFILE=/home/akshatha/django-apps/testsite/django_env/run/gunicorn.sock
USER=ubuntu
GROUP=ubuntu
NUM_WORKERS=3
DJANGO_SETTINGS_MODULE=testsite.settings
DJANGO_WSGI_MODULE=testsite.wsgi
echo "Starting $NAME as 'whoami'"

cd $DJANGODIR
source /home/akshatha/django_apps/testsite/django_env/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH



RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

exec gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-


