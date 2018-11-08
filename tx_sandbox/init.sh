#!/bin/bash
mysql -uroot -p$MYSQL_ROOT_PASSWORD < /tmp/bookstore/csv/01_load_tx_init.sql
mysql -uroot -p$MYSQL_ROOT_PASSWORD < /tmp/bookstore/csv/02_load_tx_ldi.sql
mysql -uroot -p$MYSQL_ROOT_PASSWORD < /tmp/bookstore/csv/03_load_tx_verify.sql

