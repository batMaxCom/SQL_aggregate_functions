CREATE TABLE IF NOT EXISTS genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL);

CREATE TABLE IF NOT EXISTS list_of_performers (
	id SERIAL PRIMARY KEY,
	nickname VARCHAR(40) NOT NULL);
	
CREATE TABLE IF NOT EXISTS genre_performers (
	id SERIAL PRIMARY KEY,
	genre_id INTEGER not NULL REFERENCES genre(id),
	performers_id INTEGER not NULL REFERENCES list_of_performers(id));
	
CREATE TABLE IF NOT EXISTS album (
	id SERIAL PRIMARY KEY,
	album_name VARCHAR(40) NOT NULL,
	release_album DATE not NULL);

CREATE TABLE IF NOT EXISTS album_performers (
	id SERIAL PRIMARY KEY,
	album_id INTEGER not NULL REFERENCES album(id),
	nickname_id INTEGER not NULL REFERENCES list_of_performers(id));

CREATE TABLE IF NOT EXISTS track (
	id SERIAL PRIMARY KEY,
	track_name VARCHAR(40) NOT NULL,
	duration TIME not NULL,
	album_id INTEGER not NULL REFERENCES album(id));

CREATE TABLE IF NOT EXISTS music_collection (
	id SERIAL PRIMARY KEY,
	collection_name VARCHAR(40) NOT NULL,
	collection_release DATE NOT NULL);

CREATE TABLE IF NOT EXISTS track_for_collection (
	id SERIAL PRIMARY KEY,
	collection_id INTEGER NOT NULL REFERENCES music_collection(id),
	track_id INTEGER NOT NULL REFERENCES track(id));
