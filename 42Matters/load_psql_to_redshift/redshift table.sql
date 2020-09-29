DROP TABLE IF EXISTS apps CASCADE;
CREATE TABLE apps (
	pk INTEGER NOT NULL,
	id UNIQUE VARCHAR(256),
	title VARCHAR(256),
	description varchar(2000),
	published_timestamp TIMESTAMP,
	last_updated_timestamp TIMESTAMP
);
