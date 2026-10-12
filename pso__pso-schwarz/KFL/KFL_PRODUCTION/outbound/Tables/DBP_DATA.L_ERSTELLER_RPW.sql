CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ersteller_rpw (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
ersteller_id BIGNUMERIC(38,0) NOT NULL,
sap_user STRING(20),
ecm_user STRING(20),
ocr_user STRING(30),
ldap_user STRING(20),
vorname STRING(40),
nachname STRING(40),
kjmo_geb BIGNUMERIC(38,0),
auto_fg BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);