--==============================================================
-- Table: gruppe_zek_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gruppe_zek_zu_2
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:20:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.gruppe_zek_zu_2 (
gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer Usergruppe'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
alle_zek_fg BIGNUMERIC(38,0) OPTIONS(description='User dieser Gruppe_2 werden allen zeks zugeordnet.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gruppe_id, zek_id, mandant_id) NOT ENFORCED
) OPTIONS(description='AIS KMO - Securitytabelle zur Pflege von Usergruppen');