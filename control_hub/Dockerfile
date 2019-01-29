FROM streamsets/control-hub:3.8.0

ARG MAIL_ADD
ARG MAIL_PWD

ENV DPM_VERSION=3.7.1
ARG DPM_URL=localhost:18631

COPY ./control_hub/*.sh ./

RUN ./setup.sh

# start the install
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dpm"]
