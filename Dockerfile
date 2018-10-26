FROM centos:7

# setup ansible
RUN yum update -y
RUN yum group install "Development Tools" -y
RUN yum install -y git
RUN yum install -y python-jinja2 python-paramiko PyYAML make MySQL-python
RUN yum install -y epel-release
RUN yum install -y python-setuptools python-pip
RUN pip install --upgrade pip
RUN yum install -y gcc
RUN yum install -y libffi-devel openssl-devel
RUN yum install python34-devel -y
RUN yum install python27-devel python27-setuptools python34-setuptools -y
RUN git clone https://github.com/ansible/ansible.git && \
    cd ansible && \
    git checkout -b stable-2.4 origin/stable-2.4 && \
    git submodule update --init --recursive && \
    make install
RUN mkdir /etc/ansible/ && \
    echo "[localhost]" > /etc/ansible/hosts && \
    echo "localhost ansible_connection=local" >> /etc/ansible/hosts && \
    echo "export ANSIBLE_INVENTORY=~/ansible_hosts" >> /etc/profile
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python2.7 get-pip.py
RUN pip install ansible-lint 

# Copy files
COPY streamsets-dpm-3.5.0-1.x86_64.rpm .
COPY sch_install.yml .
COPY docker-entrypoint.sh .
# # COPY run.sh .
RUN chmod +x docker-entrypoint.sh

# # start the install
RUN ansible-playbook ./sch_install.yml
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["dpm"]