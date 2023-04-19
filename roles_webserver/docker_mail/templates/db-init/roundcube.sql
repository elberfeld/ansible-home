CREATE DATABASE IF NOT EXISTS roundcube;
CREATE USER IF NOT EXISTS roundcube@'%' IDENTIFIED BY '{{ roundcube_db_pass }}';
GRANT ALL ON roundcube.* TO roundcube@'%';
FLUSH PRIVILEGES;
