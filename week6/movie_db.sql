-- Week 6: movie_db (recitation)
-- movie_db_model.mwb'deki şemanın DDL'i ve CSV dosyalarının yüklenmesi.
-- CSV'lerde başlık satırı yok. Bazı genre/language değerlerinin sonunda boşluk var,
-- sorgularda TRIM() kullanmak gerekiyor.

CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;

CREATE TABLE countries (
  country_id    INT         NOT NULL,
  country_name  VARCHAR(45) NOT NULL,
  PRIMARY KEY (country_id)
);

CREATE TABLE movies (
  movie_id  INT          NOT NULL,
  title     VARCHAR(100) NOT NULL,
  ranking   INT,
  rating    DECIMAL(3,1),
  year      INT,
  votes     INT,
  duration  INT,
  oscars    INT,
  budget    BIGINT,
  PRIMARY KEY (movie_id)
);

CREATE TABLE directors (
  director_id    INT         NOT NULL,
  country_id     INT,
  director_name  VARCHAR(60) NOT NULL,
  PRIMARY KEY (director_id),
  FOREIGN KEY (country_id) REFERENCES countries (country_id)
);

CREATE TABLE stars (
  star_id     INT         NOT NULL,
  country_id  INT,
  star_name   VARCHAR(60) NOT NULL,
  PRIMARY KEY (star_id),
  FOREIGN KEY (country_id) REFERENCES countries (country_id)
);

CREATE TABLE genres (
  movie_id    INT         NOT NULL,
  genre_name  VARCHAR(30) NOT NULL,
  PRIMARY KEY (movie_id, genre_name),
  FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
);

CREATE TABLE languages (
  movie_id       INT         NOT NULL,
  language_name  VARCHAR(30) NOT NULL,
  PRIMARY KEY (movie_id, language_name),
  FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
);

CREATE TABLE producer_countries (
  movie_id    INT NOT NULL,
  country_id  INT NOT NULL,
  PRIMARY KEY (movie_id, country_id),
  FOREIGN KEY (movie_id)   REFERENCES movies (movie_id),
  FOREIGN KEY (country_id) REFERENCES countries (country_id)
);

CREATE TABLE movie_directors (
  movie_id     INT NOT NULL,
  director_id  INT NOT NULL,
  PRIMARY KEY (movie_id, director_id),
  FOREIGN KEY (movie_id)    REFERENCES movies (movie_id),
  FOREIGN KEY (director_id) REFERENCES directors (director_id)
);

CREATE TABLE movie_stars (
  movie_id  INT NOT NULL,
  star_id   INT NOT NULL,
  PRIMARY KEY (movie_id, star_id),
  FOREIGN KEY (movie_id) REFERENCES movies (movie_id),
  FOREIGN KEY (star_id)  REFERENCES stars (star_id)
);

-- CSV'leri yükleme (dosyalar week6_movie_db/ klasöründe).
-- Workbench'te çalışması için bağlantıda OPT_LOCAL_INFILE=1 ve
-- sunucuda local_infile=ON olmalı. Sıra foreign key'lere göre.
LOAD DATA LOCAL INFILE 'week6_movie_db/countries.csv' INTO TABLE countries
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/movies.csv' INTO TABLE movies
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/directors.csv' INTO TABLE directors
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/stars.csv' INTO TABLE stars
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/genres.csv' INTO TABLE genres
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/languages.csv' INTO TABLE languages
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/producer_countries.csv' INTO TABLE producer_countries
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/movie_directors.csv' INTO TABLE movie_directors
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'week6_movie_db/movie_stars.csv' INTO TABLE movie_stars
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Kontrol
SELECT COUNT(*) FROM movies;   -- 20
SELECT COUNT(*) FROM genres;   -- 51
