CREATE OR REPLACE TABLE kfl_production_dbp_data.kdc_rating_2 (
kdc_rating_uid STRING(255) COLLATE 'und:ci' NOT NULL,
creation_date DATE NOT NULL,
expiration_date DATE,
mandant_id INTEGER NOT NULL,
geku_artikel_uid INTEGER NOT NULL,
geku_emotion_id INTEGER NOT NULL,
geku_prioritaet_id INTEGER NOT NULL,
response_time INTEGER,
kindness INTEGER,
satisfaction INTEGER,
repeated_contact INTEGER,
recommendation INTEGER,
datzeit_inserted DATETIME NOT NULL,
datzeit_updated DATETIME,
abschlussgrund_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);