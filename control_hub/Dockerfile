ARG VERSION

FROM streamsets/control-hub:${VERSION}

ARG MAIL_ADD
ARG MAIL_PWD

ARG DPM_URL

COPY ./control_hub/*.sh ./

RUN ./setup.sh

# start the install
#commented out temporarly as SCH container already has an entrypoint that starts all services which will create a conflict with this one on the DB
#We still have some issues that need to be sorted out about DB concurrency
#ENTRYPOINT ["./docker-entrypoint.sh"]
#CMD ["dpm"]

