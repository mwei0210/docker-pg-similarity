FROM postgres:11

ADD https://github.com/eulerto/pg_similarity/archive/pg_similarity_1_0.tar.gz ./

RUN tar -zxf pg_similarity_1_0.tar.gz

RUN apt-get update \
    && apt-get install -y make postgresql-server-dev-all gcc

WORKDIR /pg_similarity-pg_similarity_1_0

RUN USE_PGXS=1 make

RUN USE_PGXS=1 make install

RUN cp ./pg_similarity.conf.sample /etc/postgresql/pg_similarity.conf

RUN mkdir -p /docker-entrypoint-initdb.d

COPY ./initdb.sh /docker-entrypoint-initdb.d/initdb.sh

WORKDIR /