CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.standzeiten_we (
lagerplatz_id_ta1 STRING(10) COLLATE 'und:ci' NOT NULL,
lagernummer_id_ta1 STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagertyp_id_ta1 STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
lagerplatz_id_ta2 STRING(10) COLLATE 'und:ci' NOT NULL,
lagernummer_id_ta2 STRING(3) COLLATE 'und:ci' NOT NULL,
lagertyp_id_ta2 STRING(3) COLLATE 'und:ci' NOT NULL,
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
dat_erstellung DATE NOT NULL,
datzeit_quittierung_we DATETIME NOT NULL,
datzeit_quittierung_einl DATETIME NOT NULL,
lager_einheit_id STRING(20) COLLATE 'und:ci' NOT NULL,
dat_entnahme_quittierung_ta1 DATE OPTIONS(description='Entnahme-Quittierungsdatum aus edatu'),
zeit_entnahme_quittierung_ta1 BIGNUMERIC(38,0) OPTIONS(description='Zeitpunkt der Entnahme-Quittierung aus ezeit'),
dat_entnahme_quittierung_ta2 DATE OPTIONS(description='Entnahme-Quittierungsdatum aus edatu'),
zeit_entnahme_quittierung_ta2 BIGNUMERIC(38,0) OPTIONS(description='Zeitpunkt der Entnahme-Quittierung aus ezeit'),
datzeit_entn_quittierung_we TIMESTAMP
OPTIONS(description='Zeitstempel der Entnahme-Quittierung WE'),
datzeit_entn_quittierung_einl TIMESTAMP
OPTIONS(description='Zeitstempel der Entnahme-Quittierung Einlagerung'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, datzeit_quittierung_we;