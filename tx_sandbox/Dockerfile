FROM mariadb/server:10.3 as builder
ARG root_pass=secret_pass
ENV MYSQL_ROOT_PASSWORD=$root_pass

ARG user=sandbox
ENV MYSQL_USER=$user

ARG pass=highlyillogical
ENV MYSQL_PASSWORD=$pass

ARG db=bookstore
ENV MYSQL_DATABASE=$db

RUN mkdir -p /tmp/bookstore && \
	mkdir -p /tmp/bookstore/csv && \
	apt-get update && \
	apt-get -y install curl && \
	curl https://downloads.mariadb.com/sample-data/books5000light2.tar --output /tmp/bookstore/csv/bookstore.tar && \
	tar -vxf /tmp/bookstore/csv/bookstore.tar --directory /tmp/bookstore/csv/ && \
	cd /tmp/bookstore/csv/ && \
	gunzip -v *.gz && \
	sed -i 's/%CSV%/\/tmp\/bookstore\/csv\//g' /tmp/bookstore/csv/*.sql && \
	sed -i 's/%DB%/bookstore/g' /tmp/bookstore/csv/*.sql

FROM mariadb/server:10.3

ARG root_pass=secret_pass
ENV MYSQL_ROOT_PASSWORD=$root_pass

ARG user=sandbox
ENV MYSQL_USER=$user

ARG pass=highlyillogical
ENV MYSQL_PASSWORD=$pass

ARG db=bookstore
ENV MYSQL_DATABASE=$db

COPY --from=builder /tmp/bookstore/csv /tmp/bookstore/csv/
RUN ln -s /tmp/bookstore/csv/01_load_tx_init.sql /docker-entrypoint-initdb.d &&\
	ln -s /tmp/bookstore/csv/02_load_tx_ldi.sql /docker-entrypoint-initdb.d &&\
	ln -s /tmp/bookstore/csv/03_load_tx_verify.sql /docker-entrypoint-initdb.d