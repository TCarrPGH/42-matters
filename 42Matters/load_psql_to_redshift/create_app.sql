CREATE TABLE apps (
	pk INTEGER NOT NULL,
	id VARCHAR(256) NOT NULL,
	title VARCHAR(256) NOT NULL,
	description varchar(2000) NOT NULL,
	published_timestamp TIMESTAMP NOT NULL,
	last_updated_timestamp TIMESTAMP NOT NULL,
	CONSTRAINT apps_pk PRIMARY KEY (pk),
	CONSTRAINT apps_un UNIQUE (id)
);