CREATE OR REPLACE TABLE kfl_production_dbp_data.art_gruppe_2 (
art_gruppe_id INTEGER NOT NULL,
art_gruppe_bez STRING(100) COLLATE 'und:ci' DEFAULT '' NOT NULL,
art_gruppe_bereich STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
art_gruppe_bemerkung STRING(255) COLLATE 'und:ci' DEFAULT '' NOT NULL,
art_gruppe_kategorie STRING(100) COLLATE 'und:ci' DEFAULT '' NOT NULL,
dat_anlage DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
dat_aenderung DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);