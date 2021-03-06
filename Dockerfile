FROM jupyterhub/singleuser@sha256:5dd681bb378274d57c89116e9e1d4741716f72b90a6bda7d8397d1e1d6d89ef2

USER root

RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx git

ADD requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ADD jupyter_notebook_config.py /etc/jupyter_config.py

RUN jupyter contrib nbextension install --sys-prefix

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter nbextension enable --sys-prefix toc2/main

RUN jupyter nbextension install --sys-prefix --py gradelabel
RUN jupyter nbextension enable --sys-prefix gradelabel/main

RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader

RUN jupyter nbextension disable --sys-prefix create_assignment/main
RUN jupyter nbextension disable --sys-prefix formgrader/main --section=tree
RUN jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader
RUN jupyter nbextensions_configurator disable --sys-prefix

RUN mkdir /exchange && \
    chmod -R 777 /exchange

VOLUME ["/exchange"]
