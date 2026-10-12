CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kompensation_gruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL,
komp_gruppe_id BIGNUMERIC(38,0) NOT NULL,
komp_gruppe_bez STRING(60) COLLATE 'und:ci' NOT NULL,
freigabe_fg BIGNUMERIC(38,0) NOT NULL,
komp_kriterium_bez STRING(60) COLLATE 'und:ci' DEFAULT ' ',
anz_art_komp_gruppe BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);