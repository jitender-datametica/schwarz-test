CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_qual_ursache (
mandant_id BIGNUMERIC(38,0) NOT NULL,
qual_meldung_id INTEGER NOT NULL,
qual_meldung_pos_id BIGNUMERIC(38,0) NOT NULL,
qual_meldung_ursache_id BIGNUMERIC(38,0) NOT NULL,
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL,
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL,
pruefcode_id STRING(4) COLLATE 'und:ci' NOT NULL,
version_id STRING(7) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);