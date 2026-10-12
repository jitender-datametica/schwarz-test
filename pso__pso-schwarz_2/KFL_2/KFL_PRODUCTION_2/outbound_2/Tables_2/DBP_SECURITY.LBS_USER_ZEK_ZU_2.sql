--==============================================================
-- Table: lbs_user_zek_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_user_zek_zu_2
   generated from Powerdesigner on Montag, 5. August 2024 10:16:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.lbs_user_zek_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
user_id STRING(30) NOT NULL OPTIONS(description='LDAP des User, für welchen die ZEK_2 Zugehörigkeit gepflegt wird.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zek_id, user_id) NOT ENFORCED
) OPTIONS(description='Zuordnung von User zu Zentraleinkäufer für die Anzeigeberechtigung auf deren Lieferantent.');