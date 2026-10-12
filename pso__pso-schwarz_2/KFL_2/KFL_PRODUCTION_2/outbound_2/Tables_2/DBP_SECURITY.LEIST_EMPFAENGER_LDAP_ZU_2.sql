CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.leist_empfaenger_ldap_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
leist_empfaenger_sap_id STRING(20) COLLATE 'und:ci' NOT NULL,
ma_ldap STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
gp_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
leist_auswerteberechtigt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);