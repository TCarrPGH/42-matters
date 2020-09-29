CREATE TABLE myschema.apps (
	pk INTEGER PRIMARY KEY,
	id VARCHAR(256),
	title VARCHAR(256),
	rating FLOAT,
	last_updated_date DATE
);

INSERT INTO myschema.apps VALUES
	(1, 'com.facebook.katana', 'Facebook', 4.0, to_date('2016-09-12', 'YYYY/MM/DD'))
	(2, 'com.whatsapp', 'WhatsApp', 4.5, to_date('2016-09-11', 'YYYY/MM/DD')),
	(3, 'com.whatsapp', 'WhatsApp', 4.4, to_date('2016-09-12', 'YYYY/MM/DD')),
	(4, 'com.nianticlabs.pokemongo', 'Pokémon GO', 4.6, to_date('2016-09-05', 'YYYY/MM/DD')),
	(5, 'com.nianticlabs.pokemongo', 'Pokémon GO', 4.3, to_date('2016-09-06', 'YYYY/MM/DD')),
	(6, 'com.nianticlabs.pokemongo', 'Pokémon GO', 4.1, to_date('2016-09-07', 'YYYY/MM/DD'))
