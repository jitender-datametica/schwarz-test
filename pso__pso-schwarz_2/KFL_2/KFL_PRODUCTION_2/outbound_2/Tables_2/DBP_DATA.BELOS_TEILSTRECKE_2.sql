CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_teilstrecke_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL,
teilstrecke_nr BIGNUMERIC(38,0) NOT NULL,
belos_adresse_absender_id STRING(40) COLLATE 'und:ci' NOT NULL,
belos_adresse_empfaenger_id STRING(40) COLLATE 'und:ci',
sendung_fg BIGNUMERIC(38,0) NOT NULL,
belos_ladung_id BIGNUMERIC(38,0) NOT NULL,
teilstrecke_id BIGNUMERIC(38,0) NOT NULL,
anz_stellplatz NUMERIC(9,3),
stellplatz_menge_einh_id STRING(3) COLLATE 'und:ci',
belosart_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);