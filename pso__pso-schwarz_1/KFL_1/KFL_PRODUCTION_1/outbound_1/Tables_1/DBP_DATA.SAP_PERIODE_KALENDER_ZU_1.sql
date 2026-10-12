CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sap_periode_kalender_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
krk_id STRING(4) COLLATE 'und:ci' NOT NULL,
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL,
sap_buchungs_jahr BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);