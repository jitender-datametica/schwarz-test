CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wug_restlaufzeit_kunde_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
einstellung_objekt STRING(4) COLLATE 'und:ci' NOT NULL,
einstellung_schema STRING(4) COLLATE 'und:ci' NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
wg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
wug_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
mhd_zeitraum_ab BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
restlaufzeit_ist BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);