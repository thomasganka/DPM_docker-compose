ARG VERSION

FROM streamsets/control-hub:${VERSION}

ARG MAIL_ADD
ARG MAIL_PWD

ARG DPM_URL

COPY ./control_hub/*.sh ./

RUN ./setup.sh

# start the install
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dpm"]

