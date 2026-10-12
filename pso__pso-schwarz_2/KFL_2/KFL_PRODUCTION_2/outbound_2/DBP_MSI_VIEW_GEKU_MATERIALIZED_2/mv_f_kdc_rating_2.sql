CREATE OR REPLACE TABLE dbp_msi_view_geku_materialized.mv_f_kdc_rating_2 (
kdc_rating_uid STRING(255) COLLATE 'und:ci',
creation_date DATE,
expiration_date DATE,
mandant_id INTEGER,
geku_artikel_uid INTEGER,
geku_emotion_id INTEGER,
geku_prioritaet_id INTEGER,
response_time INTEGER,
kindness INTEGER,
satisfaction INTEGER,
repeated_contact INTEGER,
recommendation INTEGER,
datzeit_inserted DATETIME,
datzeit_updated DATETIME,
dat_inserted DATE,
dat_updated DATE,
abschlussgrund_id INTEGER
);