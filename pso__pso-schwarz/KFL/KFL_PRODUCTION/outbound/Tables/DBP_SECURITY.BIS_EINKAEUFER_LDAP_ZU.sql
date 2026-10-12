CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.bis_einkaeufer_ldap_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_ldap STRING(10) COLLATE 'und:ci' NOT NULL,
einkaeufer_bis_id STRING(10) COLLATE 'und:ci' NOT NULL,
eigene_gruppe_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);