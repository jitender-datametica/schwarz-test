CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ewm_geschaeftsvorfall_grp_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
ewm_gv_grp_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ewm_gv_grp_bez STRING(60) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);