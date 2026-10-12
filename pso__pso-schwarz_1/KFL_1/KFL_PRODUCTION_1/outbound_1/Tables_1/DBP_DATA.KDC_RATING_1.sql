CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kdc_rating_1 (
kdc_rating_uid STRING(255) COLLATE 'und:ci' NOT NULL,
creation_date DATE NOT NULL,
expiration_date DATE,
mandant_id BIGNUMERIC(38,0) NOT NULL,
geku_artikel_uid INTEGER NOT NULL,
geku_emotion_id BIGNUMERIC(38,0) NOT NULL,
geku_prioritaet_id BIGNUMERIC(38,0) NOT NULL,
response_time BIGNUMERIC(38,0),
kindness BIGNUMERIC(38,0),
satisfaction BIGNUMERIC(38,0),
repeated_contact BIGNUMERIC(38,0),
recommendation BIGNUMERIC(38,0),
datzeit_inserted DATETIME NOT NULL,
datzeit_updated DATETIME,
abschlussgrund_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);