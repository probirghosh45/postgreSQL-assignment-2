-- Active: 1747421302880@@127.0.0.1@5433@conservation_db@public
CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY Key,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    species_id INT NOT NULL,
    ranger_id INT NOT NULL,
    location VARCHAR(255) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)

);


INSERT INTO rangers(name,region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

SELECT * FROM rangers;

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species; 

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1,1,'Peak Ridge','2024-05-10 07:45:00','Camera trap image captured'),
(2,2,'Bankwood Area','2024-05-12 16:20:00','Juvenile seen'),
(3,3,'Bamboo Grove East','2024-05-15 09:10:00','Feeding observed'),
(2,1,'Snowfall Pass','2024-05-18 18:30:00',NULL);


SELECT * FROM sightings;

-- Task 1 : Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers (name, region) VALUES
('Derek Fox','Coastal Plains');
 
 SELECT * FROM rangers;

-- Task 2 : Count unique species ever sighted.
SELECT count (*) AS unique_species_count FROM species;

-- Task 3 : Find all sightings where the location includes "Pass".

SELECT * FROM sightings where location ILIKE '%Pass%';

-- Task 4 : List each ranger's name and their total number of sightings.
SELECT r.name ,count(s.sighting_id) AS total_sightings
FROM rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;


-- Task 5 : List species that have never been sighted.

SELECT s.common_name
FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.sighting_id IS NULL;   

