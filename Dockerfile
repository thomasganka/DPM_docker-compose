FROM centos:7

ARG ORACLE_JDK_URL
ARG DPM_RMP
ARG MYSQL_CONNECTOR_URL

# Copy files
COPY ${DPM_RMP} /tmp/streamsets-dpm.rpm

# Download & install jdk
RUN curl -o /tmp/jdk.rpm -b "oraclelicense=accept-securebackup-cookie" -L -C - -O ${ORACLE_JDK_URL}
RUN yum localinstall -y /tmp/jdk.rpm && rm /tmp/jdk.rpm

# Install DPM
RUN yum localinstall -y /tmp/streamsets-dpm.rpm && rm /tmp/streamsets-dpm.rpm
ENV DPM_HOME=/opt/streamsets-dpm
ENV DPM_CONF=/etc/dpm
ENV DPM_URL=localhost


# # download and unzip mysql-connector-java
RUN curl -SL ${MYSQL_CONNECTOR_URL} \
    | tar -xz -C /tmp \
    && mv /tmp/mysql*/*.jar ${DPM_HOME}/extra-lib/ \
    && rm -rf /tmp/mysql*


COPY *.sh ./
RUN chmod +x docker-entrypoint.sh
RUN chmod +x setup.sh

RUN ./setup.sh

# start the install
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dpm"]