FROM streamsets/control-hub:3.7.1

ENV DPM_VERSION=3.7.1
ENV DPM_URL=localhost

COPY *.sh ./

RUN ./setup.sh

# start the install
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dpm"]