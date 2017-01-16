CREATE DATABASE `mosquitto`;
use `mosquitto`;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id INTEGER AUTO_INCREMENT,
	username VARCHAR(25) NOT NULL,
	pw VARCHAR(128) NOT NULL,
	super INT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (id)
  );

CREATE UNIQUE INDEX users_username ON users (username);

INSERT INTO users (username, pw) VALUES ('jjolie', 'PBKDF2$sha256$901$TlNdK2MjiABs2zdM$jZjspGyWfcK3jus/N/WGZGdn5QeDftgm');
INSERT INTO users (username, pw) VALUES ('a', 'PBKDF2$sha256$901$TlNdK2MjiABs2zdM$jZjspGyWfcK3jus/N/WGZGdn5QeDftgm');
INSERT INTO users (username, pw, super)
	VALUES ('su1',
	'PBKDF2$sha256$901$TlNdK2MjiABs2zdM$jZjspGyWfcK3jus/N/WGZGdn5QeDftgm',
	1);
INSERT INTO users (username, pw, super)
	VALUES ('S1',
	'PBKDF2$sha256$901$TlNdK2MjiABs2zdM$jZjspGyWfcK3jus/N/WGZGdn5QeDftgm',
	1);
INSERT INTO users (username, pw, super)
	VALUES ('m1',
	'PBKDF2$sha256$901$TlNdK2MjiABs2zdM$jZjspGyWfcK3jus/N/WGZGdn5QeDftgm',
	0);
-- PSK
INSERT INTO users (username, pw, super)
	VALUES ('ps1',
	'deaddead',
	0);

DROP TABLE IF EXISTS acls;

CREATE TABLE acls (
	id INTEGER AUTO_INCREMENT,
	username VARCHAR(25) NOT NULL,
	topic VARCHAR(256) NOT NULL,
	rw INTEGER(1) NOT NULL DEFAULT 1,	-- 1: read-only, 2: read-write
	PRIMARY KEY (id)
	);
CREATE UNIQUE INDEX acls_user_topic ON acls (username, topic(228));

INSERT INTO acls (username, topic, rw) VALUES ('jjolie', 'loc/jjolie', 1);
INSERT INTO acls (username, topic, rw) VALUES ('jjolie', 'loc/ro', 1);
INSERT INTO acls (username, topic, rw) VALUES ('jjolie', 'loc/rw', 2);
INSERT INTO acls (username, topic, rw) VALUES ('jjolie', '$SYS/something', 1);
INSERT INTO acls (username, topic, rw) VALUES ('a', 'loc/test/#', 1);
INSERT INTO acls (username, topic, rw) VALUES ('a', '$SYS/broker/log/+', 1);
INSERT INTO acls (username, topic, rw) VALUES ('su1', 'mega/secret', 1);
INSERT INTO acls (username, topic, rw) VALUES ('nop', 'mega/secret', 1);

INSERT INTO acls (username, topic, rw) VALUES ('jog', 'loc/#', 1);
INSERT INTO acls (username, topic, rw) VALUES ('m1', 'loc/#', 1);

INSERT INTO acls (username, topic, rw) VALUES ('ps1', 'x', 1);
INSERT INTO acls (username, topic, rw) VALUES ('ps1', 'blabla/%c/priv/#', 1);